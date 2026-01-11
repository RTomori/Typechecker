{-# LANGUAGE OverloadedStrings #-}
module Main (main) where
import           Data.Text                
import qualified Data.Text                (show)
import           PolyRec.Infer                    (showTyp)
import PolyRec.Lexer 
import           System.Console.Haskeline (InputT, defaultSettings,
                                           getInputLine, outputStrLn, runInputT)
import           System.Environment       (getArgs)
import qualified PolyRec.Lexer as Lexer
import qualified PolyRec.Parser as Parser
import PolyRec.Syntax (emptyEnv,Term)
import Control.Monad.Logger (runStderrLoggingT)

showTok :: Text -> Either String Token
showTok s = runAlex s alexMonadScan

parseTerm :: Text -> Either String Term
parseTerm s = Lexer.runAlex s Parser.termparser

main :: IO()
main = do{
  i <- getArgs;
  case i of
    (x:_) -> runInputT defaultSettings (loop $ read x);
    _     -> runInputT defaultSettings (loop 100)}
  where
    loop :: Int -> InputT IO ()
    loop k = do
      minput <- getInputLine "typechecker> "
      case minput of
        Nothing -> pure ()
        Just "quit" -> pure ()
        Just input -> do{
          -- let p = parse parseAExp "" (pack input) in
          -- case p of
          --   Left s -> do{outputStrLn $ show s; loop k}
          --   Right a -> do
          --   {
            case parseTerm $ pack input of
              Left err -> do{outputStrLn err; loop k}
              Right tm -> do{
                outputStrLn $ "Obtained AST:" ++ Prelude.show tm;
                outputStrLn "";
                typ <- runStderrLoggingT $ showTyp k emptyEnv tm;
                outputStrLn (Prelude.show (fst typ) ++ "|-" ++ Prelude.show tm ++ ":" ++ Prelude.show (snd typ)); loop k;
            -- inferType k a >>= \t -> outputStrLn $ "|-" ++ show t;
}
}
