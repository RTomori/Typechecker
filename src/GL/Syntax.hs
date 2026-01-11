{-# LANGUAGE GADTs        #-}
{-# LANGUAGE InstanceSigs #-}

module GL.Syntax
  ( Name,
    Term (TmLit, TmVar, TmApp, TmAbs, TmRec, TmConst),
    Const (Nil,And, Equiv, Fst, Hd, Lt, Minus, Not, Null, Or, Plus, Snd, Times, Tl,Pair,Cons,Ifc),
    Uniq,
    Type (TyVar, TyCon, TyProd, TyFun, TyAll, TyList),
    TyCon (TyInt, TyBool),
    Lit (LInt, LBool),
    Tau,
    Sigma,
    Typing,
    Env,
    consts, 
    emptyEnv,
    fVar,
    Error(UnifyErr,SpcErr,MiscErr,TypeError,Impossible), UnifyError(ECircular,EUnsolvable,EInfty) 
  )
where

import           Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map (empty, fromList)
import           Data.Set        (Set, delete, empty, singleton, union)

type Name = String


-- | list of operators, classified by their arities
data Const =
  Nil|Not|And|Or|Plus|Minus|Times|Equiv|Lt|Null|Fst|Snd|Hd|Tl|
  Pair|Cons|Ifc
  deriving (Eq,Ord,Show)

consts :: Map Const Type
consts = Map.fromList [
  (Nil, TyAll [0] (TyList (TyVar 0))),
  (Not, TyFun (TyCon TyBool) (TyCon TyBool)),
  (And, TyFun (TyProd (TyCon TyBool) (TyCon TyBool)) (TyCon TyBool)),
  (Or, TyFun (TyProd (TyCon TyBool) (TyCon TyBool)) (TyCon TyBool)),
  (Plus, TyFun (TyProd (TyCon TyInt) (TyCon TyInt)) (TyCon TyInt)),
  (Minus, TyFun (TyProd (TyCon TyInt) (TyCon TyInt)) (TyCon TyInt)),
  (Times, TyFun (TyProd (TyCon TyInt) (TyCon TyInt))(TyCon TyInt)),
  (Equiv, TyFun (TyProd (TyCon TyInt) (TyCon TyInt)) (TyCon TyBool)),
  (Lt, TyFun (TyProd (TyCon TyInt) (TyCon TyInt)) (TyCon TyBool)),
  (Fst, TyAll [0,1] (TyFun (TyProd (TyVar 0) (TyVar 1)) (TyVar 0))),
  (Snd, TyAll [0,1] (TyFun (TyProd (TyVar 0) (TyVar 1)) (TyVar 1))),
  (Null, TyAll [0] (TyFun (TyList (TyVar 0)) (TyCon TyBool))),
  (Hd, TyAll [0] (TyFun (TyList (TyVar 0)) (TyVar 0))),
  (Tl, TyAll [0] (TyFun (TyList (TyVar 0)) (TyList (TyVar 0)))),
  (Pair, TyAll [0,1] (TyFun (TyVar 0) (TyFun (TyVar 1) (TyProd (TyVar 0) (TyVar 1))))),
  (Cons, TyAll [0] (TyFun (TyVar 0) (TyFun (TyList (TyVar 0))(TyList (TyVar 0))))),
  (Ifc,TyAll [0] (TyFun (TyCon TyBool) (TyFun (TyVar 0) (TyFun (TyVar 0) (TyVar 0)))))]

data Lit = LInt Int | LBool Bool
  deriving (Eq, Show)


data Term where
  TmLit :: Lit -> Term
  TmConst :: Const -> Term
  TmVar :: Name -> Term
  TmApp :: Term -> Term -> Term
  TmAbs :: Name -> Term -> Term
  TmRec :: Name -> Term -> Term
  deriving (Eq, Show)

type Uniq = Int

-- |  ::= bool | int |α | u1 → u2 | u1 × u2 | u list.
data Type where
  TyVar :: Uniq -> Type
  TyCon :: TyCon -> Type
  TyFun :: Tau -> Tau -> Type
  TyProd :: Tau -> Tau -> Type
  TyList :: Tau -> Type
  TyAll :: [Uniq] -> Tau -> Type
  deriving (Eq,Ord)

instance Show Type where
   show :: Type -> String
   show (TyVar n)      = "a" ++ show n
   show (TyCon TyInt)  = "Int"
   show (TyCon TyBool) = "Bool"
   show (TyFun a1 a2)  = "(" ++ show a1 ++ " -> " ++ show a2 ++ ")"
   show (TyProd a1 a2) = "(" ++ show a1 ++ "," ++ show a2 ++ ")"
   show (TyList a)     = "List " ++ show a
   show (TyAll _ ts)  = show ts

type Tau = Type

type Sigma = Type

-- simple types, or monomorphic types
data TyCon = TyInt | TyBool
  deriving (Eq, Ord, Show)

-- typing environment
type Typing = (Map Name Sigma, Sigma)
type Env = Map Name Typing

emptyEnv :: Env
emptyEnv = Map.empty

fVar :: Term -> Set Name
fVar (TmLit _)          = empty
fVar (TmVar x)          = singleton x
fVar (TmApp e1 e2)      = fVar e1 `union` fVar e2
fVar (TmAbs x e0)       = delete x (fVar e0)
fVar (TmRec x e0)       = delete x (fVar e0)
fVar (TmConst _)        = empty

data Error = UnifyErr UnifyError|TypeError String|SpcErr String|MiscErr String|Impossible
  deriving (Eq,Show)

data UnifyError = ECircular|EUnsolvable String|EInfty String
  deriving (Eq,Show)
