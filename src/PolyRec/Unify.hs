module PolyRec.Unify (fvVarSet, occursCheck, unify) where
import           Control.Monad.Except (ExceptT, MonadError (throwError))
import           Data.Bifunctor       (Bifunctor (bimap))
import qualified Data.Map.Strict      (singleton)
import qualified Data.Set             as Set
import           PolyRec.Monad        (TI)
import           PolyRec.Subst        (Subst, apply, compose, nullSubst)
import           PolyRec.Syntax       (Error (UnifyErr), Tau,
                                       Type (TyAll, TyCon, TyFun, TyList, TyProd, TyVar),
                                       UnifyError (ECircular, EUnsolvable),
                                       Uniq)

fvVarSet ::Tau -> Set.Set Uniq
fvVarSet (TyVar n)          = Set.singleton n
fvVarSet (TyCon {})         = Set.empty
fvVarSet (TyFun ty1 ty2)    = Set.union (fvVarSet ty1) (fvVarSet ty2)
fvVarSet (TyProd ty1 ty2)   = Set.union (fvVarSet ty1) (fvVarSet ty2)
fvVarSet (TyAll ns ty)      = fvVarSet ty `Set.difference` Set.fromList ns
fvVarSet (TyList (TyVar n)) = Set.singleton n
fvVarSet (TyList t)         = fvVarSet t

-- |循環代入を確認する．
occursCheck :: Uniq -> Tau -> Bool
occursCheck u ty = u `Set.member` fvVarSet ty

-- | 制約集合に対する単一化アルゴリズム．単一化が成功した場合はmguを，そうでない場合は例外を送出する．
unify :: MonadFail m => [(Tau, Tau)] -> ExceptT Error (TI m) Subst
unify [] = pure nullSubst
unify ((TyVar x, t):c')
  |t == TyVar x = unify c'
  |occursCheck x t = throwError $ UnifyErr ECircular
  |otherwise =  let subst = Data.Map.Strict.singleton x t ::Subst in
                do
                  c1 <- unify (map (bimap (apply subst) (apply subst)) c')
                  pure (c1 `compose` subst)
unify ((s, TyVar x):c')
  |s == TyVar x = unify c'
  |occursCheck x s = throwError $ UnifyErr ECircular
  |otherwise = let subst = Data.Map.Strict.singleton x s :: Subst in
      do
       c1 <- unify (map (bimap (apply subst) (apply subst)) c');
       pure (c1 `compose` subst)
unify ((TyFun s1 s2,TyFun t1 t2):c') = unify (c'++[(s1,t1),(s2,t2)])
unify ((TyProd s1 s2,TyProd t1 t2):c') = unify (c'++[(s1,t1),(s2,t2)])
unify ((TyCon c1, TyCon c2):c') =
  if c1 == c2 then unify c'
  else throwError $ UnifyErr EUnsolvable
unify ((TyList t1, TyList t2):c') = unify (c' ++ [(t1,t2)])
unify ((_, _):_) = throwError $ UnifyErr EUnsolvable

