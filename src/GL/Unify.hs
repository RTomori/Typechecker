module GL.Unify (fvVarSet, occursCheck, unify, unifyVar) where
import           Control.Monad.Except      (ExceptT, MonadError (throwError))
import           Data.Bifunctor            (Bifunctor (bimap))
import qualified Data.Map.Strict           ( singleton,union)
import qualified Data.Set                  as Set
import           GL.Monad                     (TI)
import           GL.Subst                     (Subst, apply, nullSubst)
import           GL.Syntax                    (Tau,
                                            Type (TyAll, TyCon, TyFun, TyList, TyProd, TyVar),
                                            Uniq, Error(UnifyErr),UnifyError(ECircular,EUnsolvable,EInfty))

fvVarSet ::Tau -> Set.Set Uniq
fvVarSet (TyVar n)          = Set.singleton n
fvVarSet (TyCon {})         = Set.empty
fvVarSet (TyFun ty1 ty2)    = Set.union (fvVarSet ty1) (fvVarSet ty2)
fvVarSet (TyProd ty1 ty2)   = Set.union (fvVarSet ty1) (fvVarSet ty2)
fvVarSet (TyAll ns ty)      = fvVarSet ty `Set.difference` Set.fromList ns
fvVarSet (TyList (TyVar n)) = Set.singleton n
fvVarSet (TyList t)         = fvVarSet t
-- occurs check

occursCheck :: Uniq -> Tau -> Bool
occursCheck u ty = u `Set.member` fvVarSet ty
-- unify type variables
-- 
unifyVar :: Monad m => Uniq -> Tau -> ExceptT Error (TI m) Subst
unifyVar u ty
  |ty == TyVar u = return nullSubst
  |occursCheck u ty = throwError $ UnifyErr (EInfty (show ty))
  |otherwise =
       pure $ Data.Map.Strict.singleton u ty


unify :: MonadFail m => [(Tau, Tau)] -> ExceptT Error (TI m) Subst
unify [] = pure nullSubst
unify ((TyVar x, t):c')
  |t == TyVar x = unify c'
  |occursCheck x t = throwError $ UnifyErr ECircular
  |otherwise =  let subst = Data.Map.Strict.singleton x t ::Subst in
                do
                  c1 <- unify (map (bimap (apply subst) (apply subst)) c')
                  pure (c1 `Data.Map.Strict.union` subst)
unify ((s, TyVar x):c')
  |s == TyVar x = unify c'
  |occursCheck x s = throwError $ UnifyErr ECircular
  |otherwise = let subst = Data.Map.Strict.singleton x s :: Subst in
     do
         c1 <- unify (map (bimap (apply subst) (apply subst)) c')
         pure (c1 `Data.Map.Strict.union` subst)
unify ((TyFun s1 s2,TyFun t1 t2):c') = unify (c'++[(s1,t1),(s2,t2)])
unify ((TyProd s1 s2,TyProd t1 t2):c') = unify (c'++[(s1,t1),(s2,t2)])
unify ((TyCon c1, TyCon c2):c') =
  if c1 == c2 then unify c'
  else throwError . UnifyErr  . EUnsolvable $ ("Cannot unify " ++ show c1 ++ " against " ++ show c2)
unify ((TyList t1, TyList t2):c') = unify (c'++[(t1,t2)])
unify ((u1, u2):_) = throwError . UnifyErr $ EUnsolvable "" 

-- runUnify :: MonadFail m => [(Tau, Tau)] -> TI m Subst
-- runUnify xs = do{
--   s <- runExceptT $ unify xs;
--   case s of
--    Left err -> fail err
--    Right s' -> pure s'
-- }
