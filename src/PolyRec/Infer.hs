{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections     #-}
{-# OPTIONS_GHC -Wno-name-shadowing #-}
module PolyRec.Infer (showTyp) where

import           Control.Monad          (unless)
import           Control.Monad.Except   (ExceptT, MonadError (throwError),
                                         catchError, runExceptT)
import           Control.Monad.IO.Class (MonadIO)
import           Control.Monad.Logger   (LoggingT, MonadLogger, logDebugN,
                                         runStdoutLoggingT)
import           Control.Monad.Reader   (MonadTrans (lift), ask)
import           Control.Monad.State    (StateT, get, put, runStateT)
import           Data.Map.Strict        (Map)
import qualified Data.Map.Strict        (delete, elems, fromList, keysSet, (!))
import qualified Data.Map.Strict        as Map (delete, empty, foldr', fromList,
                                                intersectionWith, lookup, map,
                                                singleton, size, union)
import           Data.Set
import qualified Data.Set               as Set (empty, size, (\\))
import qualified Data.Text              as T
import           PolyRec.Monad          (TI, extendEnv, newTyVar, runInfer)
import           PolyRec.Subst
import           PolyRec.Syntax
import           PolyRec.Unify          (unify)



-- Type variables occuring freely in type t are those which are not
-- universally quantified
freeTyVar :: Type -> Set Uniq
freeTyVar (TyCon _)        = empty
freeTyVar (TyVar n)        = singleton n
freeTyVar (TyFun ty1 ty2)  = freeTyVar ty1 `union` freeTyVar ty2
freeTyVar (TyAll ns ts)    = freeTyVar ts `difference` fromList ns
freeTyVar (TyProd ty1 ty2) = freeTyVar ty1 `union` freeTyVar ty2
freeTyVar (TyList t)       = freeTyVar t

freeInEnv :: Map Name Sigma -> Set Uniq
freeInEnv env = mconcat (Prelude.map freeTyVar (Data.Map.Strict.elems env))

-- create a new substitution

-- Collect all free type variables within typing <U;u>
ftv :: Typing -> Set Uniq
ftv (assm,ty) = freeInEnv assm `union` freeTyVar ty

substOfTyp ::  Typing->Subst
substOfTyp typ = Data.Map.Strict.fromList $ Prelude.map (,TyVar 0) fVars
  where
    fVars = toList $ ftv typ

-- | Create a "new" substitution from a list of given type variables and types.
newSubst :: [Uniq] -> [Type] -> Subst
newSubst = (Map.fromList .) . zip

-- | Check if the 2nd typing subsumes the 1st, i.e. for given two typings (U1;u1), (U2;u2), it checks if there exists a substitution s s.t. s(U1) = U2 and s(u1) = u2.
spc :: (MonadLogger m,MonadFail m) => Typing -> Typing -> ExceptT Error (TI m) ()
spc t0@(env0,ty0) t1@(env1,ty1) = do{
  s <-  unify ((ty0,ty1):Data.Map.Strict.elems (Map.intersectionWith (,) env0 env1));
  logDebugN("Substitutions generated for specialisation:" <> T.show s);
  let  ty0' = apply s ty0 in unless (ty0' == ty1 && Map.map (apply s) env0 == Map.map (apply s) env1) (throwError (SpcErr (show t0 ++ " does not specialize to " ++ show t1))) }

-- | The main inference algorithm. It either calculates principal typing for given term or
-- raises exception if it fails, while producing inference traces to standard output.
infer :: (MonadIO m, MonadFail m,MonadLogger m) =>
         Int
        -> Term -- the term to calculate typing
        -> LoggingT (ExceptT Error (TI m)) Typing
infer _ (TmVar x) = do
  env <- ask
  case Map.lookup x env of
    Just typ@(hyp,res) -> let size = Map.size env in let sub = substOfTyp typ in
      do{
      put (size + 1);
      pure (Map.map (apply sub) hyp, apply sub res);
    }
    Nothing -> do{
      a <- lift $ lift newTyVar;
      let ty=  (Map.singleton x a,a) in do{
        logDebugN(T.show x <> T.pack ":" <> T.show ty);
        pure ty;
      }
    }
infer _ (TmConst c) =
  case consts Data.Map.Strict.! c of
    -- TyAll _ ty -> pure (Map.empty, ty)
    TyAll ns ty -> do{tvs <- mapM (const . lift . lift $ newTyVar) ns;
      let s = newSubst ns tvs in
      let res = (Map.empty,apply s ty) :: (Map Name Tau, Tau) in
      do{
        logDebugN(T.show c <> ":" <> T.show res);
        pure res}}
    ty         -> pure (Map.empty,ty)
infer k (TmAbs x e0) = do{
  (hyp, u0) <- infer k e0;
  if Data.Set.member x (fVar e0)
  then do{
    case Map.lookup x hyp of
      Just u  -> let res = (Data.Map.Strict.delete x hyp, TyFun u u0) in do{
        logDebugN(T.show (TmAbs x e0) <> ": "<> T.show res);
        pure (Data.Map.Strict.delete x hyp, TyFun u u0)}
      Nothing -> throwError Impossible
  }
  else do{
    a <- lift $ lift newTyVar;
    logDebugN(T.show (TmAbs x e0) <> ":" <> T.show(hyp,TyFun a u0));
    pure (hyp, TyFun a u0)
  }
}
infer k (TmApp e0 e1) = do{
  (hyp,u0) <- infer k e0;
  case u0 of
    TyVar _ -> do{
      (hyp',u1) <- infer k e1;
      a1 <- lift $ lift newTyVar;
      a2 <- lift $ lift newTyVar;
      s <- lift $ unify $ (TyFun a1 a2,u0):(u1,a1): Data.Map.Strict.elems (Map.intersectionWith (,) hyp' hyp);
      logDebugN("Substitutions generated:" <> T.show s);
      let resHyp = hyp `Map.union` hyp' in
      let res = (Map.map (apply s) resHyp, apply s a2) in do{
      logDebugN(T.show e0 <> " " <> T.show e1 <> ":"<> T.show res);
      pure res;
      }
    }
    TyFun u2 u -> do{
      (hyp',u1) <- infer k e1;
      s <- lift $ unify ((u1,u2):Data.Map.Strict.elems (Map.intersectionWith (,) hyp' hyp));
      logDebugN("Substitutions generated:" <> T.show s);
      let resHyp = hyp `Map.union` hyp' in
      let res = (Map.map (apply s) resHyp, apply s u) in do{
        logDebugN(T.show e0 <> " " <> T.show e1 <> ":" <> T.show res);
        pure (Map.map (apply s) resHyp, apply s u);
        }
    }
    _ -> throwError $ TypeError "Applicand must be either a variable or an abstraction"
}
infer _ (TmLit (LInt _)) = pure (Map.empty, TyCon TyInt)
infer _ (TmLit (LBool _)) = pure (Map.empty, TyCon TyBool)
infer k (TmRec x e0) =
  catchError
    (ask >>= \env -> fst <$> runStateT (inferRec k x e0) (0, t0 env (TmRec x e0)))
    (const $
      do{
        (env,u) <- infer k e0;
        case Map.lookup x env of
          Nothing -> throwError $ TypeError "rec-bound parameter is also bound in body"
          Just u' -> do{
            s <- lift $ unify [(u',u)];
            let env' = Map.delete x env in
            pure (Map.map (apply s) env', apply s u)
          }
      })
infer k (TmLet x e1 e2) = do{
  ty0 <- infer k e1;
  -- put 0;
  typ <- lift . lift $ extendEnv x ty0 (runExceptT $ runStdoutLoggingT (infer k e2));
  logDebugN (T.show typ);
  case typ of
    Left err -> throwError err
    Right ty -> pure ty
}
-- | Inference algorithm for rec-bound terms. 
inferRec :: (MonadLogger m,MonadFail m,MonadIO m) =>
                       Int ->
                       Name ->
                       Term ->
                        StateT (Int,Typing) (LoggingT (ExceptT Error (TI m))) Typing
inferRec k x e0 = do{
    ty <- get;
    case ty of{
      (h, typ')
        |h == 0 -> do {
          typ <- lift . lift . lift $ extendEnv x typ' (runExceptT (runStdoutLoggingT $ infer k e0));
          logDebugN(T.show typ);
          case typ of
            Left _ -> pure typ'
            Right t -> catchError (do{lift . lift $ spc t typ';pure typ'})(\e -> do{logDebugN (T.show e); put(h + 1,t); inferRec k x e0})
                --do{put (1,t1); inferRec k x e0}
        }
        |h <= k-> do{
          typ <- lift .lift . lift $ extendEnv x typ' (runExceptT (runStdoutLoggingT $ infer k e0));
          logDebugN(T.show typ);
          case typ of
              Left _ -> pure typ'
              Right t -> catchError (do{lift .lift $ spc t typ'; pure typ'})(\e -> do{logDebugN(T.show e);catchError(do{lift . lift $ spc typ' t; pure t}) (\e -> do{logDebugN(T.show e);put(h + 1,t); inferRec k x e0})});
              --(\e ->  (do{put (h +1, t); inferRec k x e0}))
              --(do{lift $ spc t typ'; pure t})

        }
        |otherwise -> throwError $ TypeError "failed to find principal typing within given recursion limit"
    }
}

t0 :: Env -> Term -> Typing
t0 env e0 = let fvar = fVar e0
                dom = Data.Map.Strict.keysSet env
                vrange =  Map.foldr' (\(u,_) ns -> Data.Map.Strict.keysSet u `union` ns) Set.empty env
                vars = (fvar Set.\\ dom) `union` vrange
                n = Set.size vars
                tyVars = Prelude.map TyVar [1..n] in (Data.Map.Strict.fromList $ zip (toList vars) tyVars, TyVar (n + 1))



showTyp' :: (MonadIO m,MonadLogger m,MonadFail m) => Int -> Term -> TI m (Env,Typing)
showTyp' n t = do{
  res <- runExceptT $ runStdoutLoggingT (infer n t);
  env <- ask;
  case res of
    Left err -> fail $ show err
    Right ty -> pure (env,ty)
}
-- | This function infers types for given recursion limit, given term and type environment.
-- 
showTyp :: (MonadLogger m,MonadFail m,MonadIO m) => Int -> Env -> Term -> m (Env,Typing)
showTyp n env t = fst <$> runInfer (showTyp' n t) env 0

-- | Examples of basic terms. Intended for testing
i :: Term
i = TmAbs "x" (TmVar "x")

k :: Term
k = TmAbs "x" (TmAbs "y" (TmVar "x"))

s :: Term
s = TmAbs "x" (TmAbs "y"(TmAbs "z" (TmApp (TmApp (TmVar "x") (TmVar "z")) (TmApp (TmVar "y") (TmVar "z")))))
example :: Term
example = TmRec "f" (TmAbs "g" (TmAbs "y" (TmApp (TmApp (TmApp (TmConst Ifc) (TmLit (LBool False))) (TmVar "y")) (TmApp (TmVar "g") (TmApp (TmApp (TmVar "f") (TmVar "g")) (TmVar "y"))))))

example2 :: Term
example2 = TmRec "f" (TmAbs "g" (TmAbs "h1" (TmAbs "y" (TmApp (TmApp (TmApp (TmConst Ifc) (TmLit (LBool False))) (TmVar "y")) (TmApp (TmVar "g") (TmApp (TmApp (TmApp (TmVar "f") (TmVar "g")) (TmVar "h1")) (TmApp (TmApp (TmApp (TmVar "f") (TmVar "h1")) (TmVar "g")) (TmVar "y"))))))))


example2Body :: Term
example2Body = TmAbs "g" (TmAbs "h1" (TmAbs "y" (TmApp (TmApp (TmApp (TmConst Ifc) (TmLit (LBool False))) (TmVar "y")) (TmApp (TmVar "g") (TmApp (TmApp (TmApp (TmVar "f") (TmVar "g")) (TmVar "h1")) (TmApp (TmApp (TmApp (TmVar "f") (TmVar "h1")) (TmVar "g")) (TmVar "y")))))))

example3 :: Term
example3 = TmRec "g" (TmAbs "x" (TmApp (TmConst Plus)(TmApp (TmApp (TmConst Pair) (TmApp (TmVar "g") (TmLit (LInt 2)))) (TmApp (TmVar "g") (TmLit (LBool False))))))

foldN :: Term
foldN = TmAbs "h"
          (TmAbs "c"
            (TmRec "f"
              (TmAbs "n"
                (TmApp
                  (TmApp
                    (TmApp (TmConst Ifc)
                      (TmApp (TmApp (TmConst Equiv) (TmVar "n"))
                      (TmLit (LInt 0)))) (TmVar "c"))
                      (TmApp (TmVar "h") (TmApp (TmVar "f") (TmApp (TmApp (TmConst Minus) (TmVar "n")) (TmLit (LInt 1)))))))))
example4 :: Term
example4 = TmRec "f" (TmAbs "x" (TmApp (TmAbs "y" (TmLit (LBool True))) (TmApp (TmConst Not) (TmApp (TmVar "f") (TmLit (LBool False))))))
example5 :: Term
example5 = TmRec "g" (TmAbs "x" (TmApp (TmConst Plus) (TmApp (TmApp (TmConst Pair) (TmApp (TmVar "g") (TmLit (LInt 2)))) (TmApp (TmVar "g") (TmLit (LBool False))))))
body :: Term -> Term
body (TmAbs _ e) = body e
body (TmRec _ e) = body e
body e           = e
