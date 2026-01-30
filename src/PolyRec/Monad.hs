{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module PolyRec.Monad (TI(runInfer),lookupEnv,extendEnv,newTyVar) where

import           Control.Monad.Reader (MonadReader (ask, local),
                                       MonadTrans (lift))
import Control.Monad.State (put, get)
import Control.Monad.IO.Class (MonadIO(liftIO))
import Control.Monad.Logger (MonadLogger(monadLoggerLog))
import Control.Monad.Except (ExceptT,throwError)
import           Control.Monad.State  (MonadState (state))
import           Data.Map             (insert, lookup)
import           PolyRec.Syntax               (Env, Name, Type (TyVar), Uniq,Tau,Typing,Error(MiscErr))
newtype TI m a = TI {runInfer :: Env -> Uniq -> m (a, Uniq)}

instance Monad m => Functor (TI m) where
  fmap g (TI f) = TI(\env uq -> do{
                         (x, u) <- f env uq;
                         return (g x, u)
                                   })
instance Monad m => Applicative (TI m) where
  pure x = TI(\_ uq -> pure (x, uq))
  TI f <*> TI x = TI(\env uq -> do{
                         (f', u1) <- f env uq;
                         (x', u2) <- x env u1;
                         pure (f' x', u2)
                                   })
instance Monad m => Monad (TI m) where
  TI f >>= g = TI(\env uq -> do{
                      (x, u1) <- f env uq;
                       let  TI {runInfer = g'} = g x in g' env u1
                                })
instance MonadFail m => MonadFail (TI m) where
  fail err = TI(\_ uq -> do{
                    e' <- fail err;
                    pure (e', uq)})

instance MonadLogger m => MonadLogger (TI m) where
  monadLoggerLog loc src lvl msg = lift $ monadLoggerLog loc src lvl msg

instance MonadIO m => MonadIO (TI m) where
  liftIO = lift . liftIO

instance MonadTrans TI where
  lift m = TI (\_ uq -> m >>= \x -> pure (x, uq))

instance Monad m => MonadReader Env (TI m) where
  ask = TI(curry pure)
  local s (TI f) = TI(f. s)

instance Monad m => MonadState Uniq (TI m) where
  state trans = TI (\_ uq -> do{let (x, u') = trans uq in pure (x, u')})

extendEnv :: Monad m => Name -> Typing -> TI m a -> TI m a
extendEnv x ty = local (insert x ty)

lookupEnv :: MonadFail m => Name -> ExceptT Error (TI m) Typing
lookupEnv x = do{
  env <- ask;
  case Data.Map.lookup x env of
    Just ty -> pure ty
    Nothing -> throwError $ MiscErr ("Not in scope:" ++ x)
}

newTyVar :: Monad m => TI m Tau
newTyVar = do{
  u <- get;
  put (u + 1);
  pure $ TyVar u;
}
