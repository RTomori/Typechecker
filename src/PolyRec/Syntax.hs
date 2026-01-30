{-# LANGUAGE GADTs        #-}
{-# LANGUAGE InstanceSigs #-}
module PolyRec.Syntax
  ( Name,
    Term (TmLit, TmVar, TmApp, TmAbs, TmRec, TmConst,TmLet),
    Const (Nil,And, Equiv, Fst, Hd, Lt, Minus, Not, Null, Or, Plus, Snd, Times, Tl,Pair,Cons,Ifc),
    Uniq,
    Type (TyVar, TyCon, TyProd, TyFun, TyAll, TyList),
    TyCon (TyInt, TyBool),
    Lit (LInt, LBool),
    Tau,
    Sigma,
    Scheme (Forall),
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
  (Nil,  TyAll [0] (TyList (TyVar 0))),
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
  (Pair,  TyAll [0,1] (TyFun (TyVar 0) (TyFun (TyVar 1) (TyProd (TyVar 0) (TyVar 1))))),
  (Cons, TyAll [0] (TyFun (TyVar 0) (TyFun (TyList (TyVar 0))(TyList (TyVar 0))))),
  (Ifc,TyAll [0] (TyFun (TyCon TyBool) (TyFun (TyVar 0) (TyFun (TyVar 0) (TyVar 0)))))]

data Lit = LInt Int | LBool Bool
  deriving (Eq)

instance Show Lit where
  show (LInt n) = show n
  show (LBool b) = show b

data Term where
  TmLit :: Lit -> Term
  TmConst :: Const -> Term
  TmVar :: Name -> Term
  TmApp :: Term -> Term -> Term
  TmAbs :: Name -> Term -> Term
  TmRec :: Name -> Term -> Term
  TmLet :: Name -> Term -> Term ->  Term
  deriving (Eq)

type Uniq = Int

instance Show Term where
  -- showsPrec _ (TmLit x) = showString $ show x
  -- showsPrec _ (TmVar x) = showString x
  -- showsPrec p (TmApp t1 t2) = showsPrec p t1 . showString " " . showsPrec p t2
  -- showsPrec p (TmAbs x t) = showString "fun " . showsPrec p x . showString "." . showsPrec p t
  -- showsPrec p (TmRec x t) = showString "fix " . showsPrec p x . showString "." . showsPrec p t
  -- showsPrec p (TmLet x t1 t2) = showString "let " . showsPrec p x . showString " = " .showsPrec p t1 . showString " in " . showsPrec p t2
  -- showsPrec _ (TmConst c) = showString $ show c
  showsPrec _ (TmLit x) = showString $ show x
  showsPrec _ (TmVar x) = showString x
  showsPrec p (TmApp t1 t2) = showParen (p > 6) $ showsPrec 7 t1 . showString " " . showsPrec 8 t2
  showsPrec p (TmAbs x t) = showParen (p > 6) $ showString "fun " . showsPrec 7 x . showString "." . showsPrec 6 t
  showsPrec p (TmRec x t) = showParen (p > 6) $ showString "rec" . showsPrec 7 x . showString "." . showsPrec 6 t
  showsPrec p (TmLet x t1 t2) = showString "let " . showsPrec p x . showString " = " . showsPrec p t1 . showString " in " . showsPrec p t2
  showsPrec _ (TmConst c) = showString $ show c
  
data Type where
  TyVar :: Uniq -> Type
  TyCon :: TyCon -> Type
  TyFun :: Tau -> Tau -> Type
  TyProd :: Tau -> Tau -> Type
  TyList :: Tau -> Type
  TyAll :: [Uniq] -> Tau -> Type
  deriving (Eq)

instance Show Type where
  showsPrec _ (TyVar x) = showString "v" .showsPrec 11 x
  showsPrec _ (TyCon TyInt) = showString "int"
  showsPrec _ (TyCon TyBool) = showString "bool"
  showsPrec p (TyFun t1 t2) = showParen (p > 6) $ showsPrec 7 t1 . showString "->" . showsPrec 6 t2
  showsPrec _ (TyProd t1 t2) = showParen True $ showsPrec 15 t1 . showString ","  . showsPrec 15 t2
  showsPrec p (TyList t) = showParen (p > 7) $ showString "list " . showsPrec 7 t
  showsPrec p (TyAll us t) = showString "forall" . showList us . showsPrec (p + 1) t 
  

type Tau = Type

type Sigma = Type

-- | Type scheme for polymorphic types
-- Forall quantifies over a list of type variables
data Scheme where
  Forall :: [Uniq] -> Type -> Scheme
  deriving (Eq)

instance Show Scheme where
  showsPrec p (Forall [] t) = showsPrec p t
  showsPrec p (Forall us t) = showString "forall " . showList us . showString ". " . showsPrec (p + 1) t

-- simple types, or monomorphic types
data TyCon = TyInt | TyBool
  deriving (Eq, Ord, Show)

-- typing environment
type Typing = (Map Name Sigma, Sigma)
type Env = Map Name Typing

emptyEnv :: Env
emptyEnv = Map.empty

fVar :: Term -> Set Name
fVar (TmLit _)     = empty
fVar (TmVar x)     = singleton x
fVar (TmApp e1 e2) = fVar e1 `union` fVar e2
fVar (TmAbs x e0)  = delete x (fVar e0)
fVar (TmRec x e0)  = delete x (fVar e0)
fVar (TmLet x e t) = fVar (TmApp (TmAbs x t) e)
fVar (TmConst _)   = empty


data Error = UnifyErr UnifyError|TypeError String|SpcErr String|MiscErr String|Impossible
  deriving (Eq,Show)

data UnifyError = ECircular|EUnsolvable|EInfty String
  deriving (Eq,Show)

