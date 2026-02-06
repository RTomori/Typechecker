{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE Strict            #-}

{-# OPTIONS_GHC -Wno-name-shadowing #-}
module PolyRec.Infer (showTyp) where

import           Control.Monad          (unless)
import           Control.Monad.Except   (ExceptT, MonadError (throwError),
                                         catchError, runExceptT)
import           Control.Monad.IO.Class (MonadIO)
import           Control.Monad.Logger   (MonadLogger, logDebugN, logErrorN)
import           Control.Monad.Reader   (MonadTrans (lift), ask)
import           Control.Monad.State    (StateT, get, put, runStateT)
import           Data.Map.Strict        (Map)
import qualified Data.Map.Strict        (delete, elems, fromList, keysSet, (!))
import qualified Data.Map.Strict        as Map (delete, empty, foldr', fromList,
                                                intersectionWith, lookup, map,
                                                singleton, union)
import           Data.Set               (Set, difference, empty, fromList,
                                         member, singleton, toList, union)
import qualified Data.Set               as Set (empty, size, toList, (\\))
import qualified Data.Text              as T (pack, show)
import           PolyRec.Monad          (TI, extendEnv, newTyVar, runInfer)
import           PolyRec.Subst          (Subst, apply)
import           PolyRec.Syntax         (Env,
                                         Error (Impossible, SpcErr, TypeError),
                                         Lit (LBool, LInt), Name, Sigma, Tau,
                                         Term (..), TyCon (TyBool, TyInt),
                                         Type (TyAll, TyCon, TyFun, TyList, TyProd, TyVar),
                                         Typing, Uniq, consts, fVar, termSubst)
import           PolyRec.Unify          (unify)



freeTyVar :: Type -> Set Uniq
freeTyVar (TyCon _)        = empty
freeTyVar (TyVar n)        = singleton n
freeTyVar (TyFun ty1 ty2)  = freeTyVar ty1 `union` freeTyVar ty2
freeTyVar (TyAll ns ts)    = freeTyVar ts `difference` fromList ns
freeTyVar (TyProd ty1 ty2) = freeTyVar ty1 `union` freeTyVar ty2
freeTyVar (TyList t)       = freeTyVar t

freeInEnv :: Map Name Sigma -> Set Uniq
freeInEnv env = mconcat (Prelude.map freeTyVar (Data.Map.Strict.elems env))

ftv :: Typing -> Set Uniq
ftv (assm,ty) = freeInEnv assm `union` freeTyVar ty

newSubst :: [Uniq] -> [Type] -> Subst
newSubst = (Map.fromList .) . zip

-- | Checks if the 2nd typing subsumes the 1st, i.e. for given two typings (U1;u1), (U2;u2), it checks if there exists a substitution $s$ s.t. s(U1) = U2 and s(u1) = u2.
spc :: (MonadLogger m,MonadFail m) => Typing -> Typing -> ExceptT Error (TI m) ()
spc t0@(env0,ty0) t1@(env1,ty1) = do{
  s <-  unify ((ty0,ty1):Data.Map.Strict.elems (Map.intersectionWith (,) env0 env1));
  unless (apply s ty0 == ty1 && apply s ty1 == ty1) (throwError (SpcErr (show t0 ++ " does not specialize to " ++ show t1))) }


infer :: (MonadIO m, MonadFail m, MonadLogger m) =>
         Int
        -> Term
        -> ExceptT Error (TI m) Typing
infer _ (TmVar x) = do
  env <- ask
  case Map.lookup x env of
    Just typ@(env,ty) -> let ns = Set.toList (ftv typ) in do{
      tvs <- mapM (const . lift $ newTyVar) ns;
      let s = newSubst ns tvs in
      let res = (Map.map (apply s) env, apply s ty) :: (Map Name Tau, Tau) in do{
        logDebugN (T.show x <> T.pack ":" <> T.show res);
        pure res;
      }
    }

    Nothing -> do{
      a <- lift newTyVar;
      let ty=  (Map.singleton x a, a) in do{
      logDebugN(T.show x <> T.pack ":" <> T.show ty);
        pure ty;
      }
    }
-- Requires shifting of type variables to avoid clash.
infer _ (TmConst c) =
  case consts Data.Map.Strict.! c of
    ty ->
       let ns = toList $ freeTyVar ty in do{tvs <- mapM (const. lift $ newTyVar) ns;
            let s = newSubst ns tvs in
             let res = (Map.empty,apply s ty) :: (Map Name Tau, Tau) in
             do{
                logDebugN(T.show c <> ":" <> T.show res);
               pure res}}

infer k (TmAbs x e0) = do{
  (hyp, u0) <- infer k e0;
  if Data.Set.member x (fVar e0)
  then do{
    case Map.lookup x hyp of
      Just u  -> do{
        let res = (Data.Map.Strict.delete x hyp, TyFun u u0) in do{
        logDebugN(T.show (TmAbs x e0) <> ": "<> T.show res);
        pure res}}
      Nothing -> throwError Impossible
  }
  else do{
    a <- lift newTyVar;
    let res = (hyp, TyFun a u0) in do{
      logDebugN(T.show (TmAbs x e0) <> ":" <> T.show res);
      pure res;
    }
  }
}
infer k (TmApp e0 e1) = do{
  -- Let <U0;u0> be the principal typing of e0 in environment D.
  (hyp,u0) <- infer k e0;
   case u0 of
     TyVar _ ->
     -- If u0 = a (type variable), a1,a2 are fresh, typing <U1;u1> of e1 is fresh.
     -- Let s be the mgu of the constraint set {u1 = a1, a = a1 -> a2}∪ {u' = u''|x:u' ∈ U0 and x:u''∈ U1}.
     -- then <s(U0) ⊕s(U1); s(a2)> is the principal type of e = e0 e1.
      do{
       (hyp',u1) <- infer k e1;
        a1 <- lift newTyVar;
        a2 <- lift newTyVar;
       s <- unify ((u1,a1):(u0,TyFun a1 a2):Data.Map.Strict.elems (Map.intersectionWith (,) hyp hyp'));
       logDebugN("Substs:" <> T.show s);
       let hyp1 = Map.map (apply s) hyp in
       let hyp2 = Map.map (apply s) hyp' in
       let res = (hyp2 `Map.union` hyp1, apply s a2) in do{
       logDebugN(T.show e0 <> " " <> T.show e1 <> ":"<> T.show res);
       pure res;
    }}
     TyFun u2 u -> do{
       -- put 0;
       (hyp',u1) <- infer k e1;
       s <- unify $ (u1,u2):Data.Map.Strict.elems (Map.intersectionWith (,) hyp hyp');
       logDebugN("Substs:" <> T.show s);
       let hyp1 = Map.map (apply s) hyp in
       let hyp2 = Map.map (apply s) hyp' in
       let res = (hyp1 `Map.union` hyp2, apply s u) in do{
         logDebugN(T.show e0 <> " " <> T.show e1 <> ":" <> T.show res);
         pure res;
     }}
     _ -> throwError $ TypeError "Applicand must be either a variable or an abstraction"
}
infer _ (TmLit (LInt c)) =
  let ty = (Map.empty, TyCon TyInt) :: Typing in do{logDebugN (T.show c <> ":" <> T.show ty); pure ty}
infer _ (TmLit (LBool b)) = let ty = (Map.empty, TyCon TyBool) :: Typing in do{logDebugN (T.show b <> ":" <> T.show ty);pure ty}
infer k (TmRec x e0) =
  catchError
    (ask >>= \env -> fst <$> runStateT (inferRec k x e0) (1, t0 env (TmRec x e0)))
    (const $
      do{
        logErrorN "Failed to find typing for term within given recursion limit";
        lift $ put 0;
        (env,u) <- infer k e0;
        case Map.lookup x env of
          Nothing -> throwError $ TypeError "rec-bound parameter is also bound in body"
          Just u' -> do{
            s <- unify [(u',u)];
            let env' = Map.delete x env in
            pure (Map.map (apply s) env', apply s u)
          }
      })
-- | Numeric values cannot be variables by definition of lexer/scanners
infer k (TmLet x e0 e) = do{
  ty0@(a0,_) <- infer k e0;
  i <- get;
  let e' = termSubst x (TmVar("_" <> show i)) e in do{ty <- lift $ extendEnv ("_" <> show i :: Name) ty0 (runExceptT $ infer k (termSubst x (TmVar ("_" <> show i)) e));
  logDebugN (T.show e' <> ":" <> T.show ty);
  case ty of
    Left e -> throwError e
    Right (a1, v1) -> if member x (fVar e) then pure (a1, v1) else pure (a0  `Map.union` a1, v1)
}
}
-- | Inference algorithm for rec-bound terms,
inferRec :: (MonadLogger m, MonadFail m, MonadIO m) =>
                       Int ->
                       Name ->
                       Term ->
                        StateT (Int,Typing) (ExceptT Error (TI m)) Typing
inferRec k x e0 = do{
    ty <- get;
    case ty of{
      (h, typ')
        |h == 1 -> do {
          typ <- lift . lift $ extendEnv x typ' (runExceptT (infer k e0));
          logDebugN("iteration #1:" <> T.show typ);
          case typ of
            Left _ -> pure typ'
            Right t -> catchError (do{lift . lift $ put 0;lift $ spc t typ';pure typ'})(\_ -> do{put(h + 1,t); inferRec k x e0})
        }
        |h <= k -> do{
          typ <- lift . lift $ extendEnv x typ' (runExceptT (infer k e0));
          logDebugN("iteration #" <> T.show h <> ":"  <> T.show typ);
          case typ of
            Left err -> throwError err;
            Right t -> catchError(do{lift . lift $ put 0;lift $ spc t typ';pure typ'})(\_ -> do{put(h + 1, t); inferRec k x e0});}
        |otherwise -> throwError $ TypeError "failed to find principal typing within limit"
    }
}

t0 :: Env -> Term -> Typing
t0 env e0 = let fvar = fVar e0
                dom = Data.Map.Strict.keysSet env
                vrange =  Map.foldr' (\(u,_) ns -> Data.Map.Strict.keysSet u `union` ns) Set.empty env
                vars = (fvar Set.\\ dom) `union` vrange
                n = Set.size vars
                tyVars = Prelude.map TyVar [0..n-1] in (Data.Map.Strict.fromList $ zip (toList vars) tyVars, TyVar n)



showTyp' :: (MonadIO m, MonadLogger m, MonadFail m) => Int -> Term -> TI m (Env, Either Error Typing)
showTyp' n t = do{
  res <- runExceptT (infer n t);
  env <- ask;
  pure (env, res)
}
showTyp :: (MonadLogger m,MonadFail m,MonadIO m) => Int -> Env -> Term -> m (Env,Either Error Typing)
showTyp n env t = fst <$> runInfer (showTyp' n t) env 0


