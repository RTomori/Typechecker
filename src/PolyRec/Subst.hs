module PolyRec.Subst (Subst, nullSubst, apply, compose)where

import           Data.Map.Strict      as Map (Map, delete, empty,
                                              findWithDefault, map, union)
import           PolyRec.Syntax       (Tau,
                                       Type (TyAll, TyCon, TyFun, TyList, TyProd, TyVar),
                                       Uniq)

type Subst = Map.Map Uniq Tau

nullSubst :: Subst
nullSubst = Map.empty

apply :: Subst -> Tau -> Tau
apply s t@(TyVar n)      = Map.findWithDefault t n s
apply _ (TyCon tc)       = TyCon tc
apply s (TyFun ty1 ty2)  = TyFun (apply s ty1) (apply s ty2)
apply s (TyAll ns ty)    = TyAll ns $ apply (Prelude.foldr Map.delete s ns) ty
apply s (TyList t)       = TyList $ apply s t
apply s (TyProd ty1 ty2) = TyProd (apply s ty1) (apply s ty2)

compose :: Subst -> Subst -> Subst
compose s1 s2 = Map.map (apply s1) s2 `Map.union` s1
