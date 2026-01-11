{-# LANGUAGE TupleSections #-}
{-# OPTIONS_GHC -Wno-name-shadowing #-}
module GL.Infer  where

import           Control.Monad        (unless)
import           Control.Monad.Except (ExceptT, MonadError (throwError),
                                       catchError, runExceptT)
import           Control.Monad.Reader (MonadTrans (lift), ask)
import           Control.Monad.State  (StateT, get, put, runStateT)
import           Data.Map.Strict      (Map)
import qualified Data.Map.Strict      (delete, elems, fromList, keysSet, (!))
import qualified Data.Map.Strict      as Map (empty, foldr', fromList,
                                              intersectionWith, lookup, map,
                                              singleton, union,insert)
import           Data.Set
import qualified Data.Set             as Set (empty, size, (\\))
import           PolyRec.Monad        (TI, extendEnv, newTyVar, runInfer)
import           PolyRec.Subst
import           PolyRec.Syntax
import           PolyRec.Unify        (unify)
-- trivially, type variables occuring freely in type t are those which are not
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
newSubst :: [Uniq] -> [Tau] -> Subst
newSubst ns ts = Map.fromList $ zip ns ts

ftv :: Typing -> Set Uniq
ftv (assm,ty) = freeInEnv assm `union` freeTyVar ty

substOfTyp ::  Typing->Subst
-- ウソ．
substOfTyp typ = Data.Map.Strict.fromList $ Prelude.map (,TyVar 0) fVars
  where
    fVars = toList $ ftv typ

spc :: MonadFail m => Typing -> Typing -> ExceptT Error (TI m) ()
spc (env0,ty0) (env1,ty1) = do{
  s <-  unify  $ (ty0,ty1):Data.Map.Strict.elems (Map.intersectionWith (,) env0 env1);
  let env0' = Map.map (apply s) env0 in
      let  ty0' = apply s ty0 in unless (env0' == env1 && ty0' == ty1) (throwError (SpcErr "1st typing does not specialise to 2nd"))
}

runSpc :: MonadFail m => Typing -> Typing -> m Bool
runSpc e1 e2 = fst <$> runInfer (do{
  s <- runExceptT (spc e1 e2);
  case s of
    Left _  -> pure False
    Right _ -> pure True
}) emptyEnv 0
-- varsInEnv :: MonadFail m => Term -> ExceptT Error (TI m) Typing
-- varsInEnv e = do{
--   env <- ask;
--   let vrange = Map.keys $ Map.unions (Map.map fst env)
--       fv = toList $ fVar e
--       dom = Map.keys env

-- }

infer :: MonadFail m =>
         Int -- cutoff value
        -> Term
        -> ExceptT Error (TI m) Typing -- returns either principal-in-environment typing or error
infer _ (TmVar x) = do
  env <- ask
  case Map.lookup x env of
    Just (hyp,res) -> let env' = Map.insert x res hyp in pure(env',res)
    Nothing -> do{
      a <- lift newTyVar;
      pure (Map.singleton x a,a)
    }
infer _ (TmConst c) =
  case consts Data.Map.Strict.! c of
    TyAll ns ty -> let n = length ns in do{t <- get;put(t + n);pure (Map.empty, ty)}
    ty         -> pure (Map.empty,ty)
infer k (TmAbs x e0) = do{
  (hyp, u0) <- infer k e0;
  if Data.Set.member x (fVar e0)
  then do{
    case Map.lookup x hyp of
      Just u  -> pure (Data.Map.Strict.delete x hyp, TyFun u u0)
      Nothing -> throwError Impossible
  }
  else do{
    a <- lift newTyVar;
    pure (hyp, TyFun a u0)
  }
}
infer k (TmApp e0 e1) = do{
  (hyp,u0) <- infer k e0;
  case u0 of
    TyVar _ -> do{
      a1 <- lift newTyVar;
      a2 <- lift newTyVar;
      (hyp',u1) <- infer k e1;
      s <- unify $ [(u1,a1),(u0,TyFun a1 a2)] ++ Data.Map.Strict.elems (Map.intersectionWith (,) hyp hyp');
      let resHyp = hyp `Map.union` hyp' in pure (Map.map (apply s) resHyp, apply s a2)
    }
    TyFun u2 u -> do{
      (hyp',u1) <- infer k e1;
      s <- unify ((u1,u2):Data.Map.Strict.elems (Map.intersectionWith (,) hyp hyp'));
      let resHyp = hyp `Map.union` hyp' in pure (Map.map (apply s) resHyp, apply s u);
    }
    _ -> throwError $ TypeError "Applicand must be either a variable or an abstraction"
}
infer _ (TmLit (LInt _)) = pure (Map.empty, TyCon TyInt)
infer _ (TmLit (LBool _)) = pure (Map.empty, TyCon TyBool)
infer k (TmRec x e0) =
  -- catchError
    ask >>= \env -> fst <$> runStateT (inferRec k x e0) (0,t0 env (TmRec x e0))
    -- (const $
    --   do{
    --     (env,u) <- infer k e0;
    --     case Map.lookup x env of
    --       Nothing -> throwError $ TypeError "rec-bound parameter is also bound in body"
    --       Just u' -> do{
    --         s <- unify [(u',u)];
    --         let env' = Map.delete x env in
    --         pure (Map.map (apply s) env', apply s u)
    --       }
      
infer _ _ = undefined

inferRec :: MonadFail m =>
                       Int ->
                       Name ->
                       Term ->
                        StateT (Int,Typing) (ExceptT Error (TI m)) Typing
inferRec k x e0 = do{
    ty <- get;
    case ty of{
      (h, typ')
        |h == 0 -> do {
          typ <- lift . lift $ extendEnv x typ' (runExceptT (infer k e0));
          case typ of
              Left _   -> pure typ' 
              Right t1 -> do{put (1,t1); inferRec k x e0}
                --do{put (1,t1); inferRec k x e0}
        }
        |h < k-> do{
          typ <- lift . lift $ extendEnv x typ' (runExceptT (infer k e0));
          case typ of
              Left _ -> pure typ'
              Right t -> catchError (do{lift $ spc t typ'; pure typ'}) (const $ do{put (h + 1, t);inferRec k x e0})
              --(\e ->  (do{put (h +1, t); inferRec k x e0}))
              --(do{lift $ spc t typ'; pure t})

        }
        |otherwise -> throwError $ TypeError "failed to find typing within recursion limit"
    }
}

t0 :: Env -> Term -> Typing
t0 env e0
    -- |Map.null env = let fvar = fVar e0 in
    --                    let n = Set.size fvar in
    --                    let tyVars = Prelude.map TyVar [1..n] in
    --                      (Data.Map.Strict.fromList $ zip (toList fvar) tyVars, TyVar 0)
               = let fvar = fVar e0
                     dom = Data.Map.Strict.keysSet env
                    -- \union {x:<U,u> \in (D\cup FV(e))} dom (U)
                     vrange =  Map.foldr' (\(u,_) ns -> Data.Map.Strict.keysSet u `union` ns) Set.empty env
                     vars = ((fvar Set.\\ dom) `union` vrange)`union` fvar
                     n = Set.size vars
                     tyVars = Prelude.map TyVar [1..n] in (Data.Map.Strict.fromList $ zip (toList vars) tyVars, TyVar 0)



showTyp' :: MonadFail m => Int -> Term -> TI m (Env,Typing)
showTyp' n t = do{
  res <- runExceptT (infer n t);
  env <- ask;
  case res of
    Left err -> fail $ show err;
    Right ty -> pure (env,ty)

}
--
showTyp :: MonadFail m => Int -> Env -> Term -> m (Env,Typing)
showTyp n env t = fst <$> runInfer (showTyp' n t) env 0

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
foldN = TmAbs "h" (TmAbs "c"(TmRec "f" (TmAbs "n" (TmApp (TmApp (TmApp (TmConst Ifc) (TmApp (TmApp (TmConst Equiv) (TmVar "n")) (TmLit (LInt 0)))) (TmVar "c")) (TmApp (TmVar "h") (TmApp (TmVar "f") (TmApp (TmApp (TmConst Minus) (TmVar "n")) (TmLit (LInt 1)))))))))

example4 :: Term
example4 = TmRec "f" (TmAbs "x" (TmApp (TmAbs "y" (TmLit (LBool True))) (TmApp (TmConst Not) (TmApp (TmVar "f") (TmLit (LBool False))))))
example5 :: Term
example5 = TmRec "g" (TmAbs "x" (TmApp (TmConst Plus) (TmApp (TmApp (TmConst Pair) (TmApp (TmVar "g") (TmLit (LInt 2)))) (TmApp (TmVar "g") (TmLit (LBool False))))))

body :: Term -> Term
body (TmAbs _ e) = body e
body (TmRec _ e) = body e
body e           = e
