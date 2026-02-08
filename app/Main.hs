{-# LANGUAGE OverloadedStrings #-}
module Main (main) where
import           Data.Text (Text,pack)                
import           PolyRec.Infer                    (showTyp,normalize)
import           System.Console.Haskeline (InputT, defaultSettings,
                                           getInputLine, outputStrLn, runInputT)
import           System.Environment       (getArgs)
import qualified PolyRec.Lexer as Lexer
import qualified PolyRec.Parser as Parser
import PolyRec.Syntax (emptyEnv,Term,Type)
import Control.Monad.Logger (runStderrLoggingT, runNoLoggingT)

parseTerm :: Text -> Either String Term
parseTerm s = Lexer.runAlex s Parser.termparser

main :: IO()
main = do{
  args <- getArgs;
  if args == ["-h"] || args == ["--help"] then putStrLn "Typechecker for the decidable fragment of Milner-Mycroft calculus\nAvailable arguments:\n\nAvailable flags:\n-h,--help\tShow this help text.\n-v, --verbose\tPrints out every step of type inference.Intended for debugging purposes.\n" else
  let (verbose, limit) = parseArgs args
  in if verbose
     then runInputT defaultSettings (loop limit True)
     else runInputT defaultSettings (loop limit False)}
  where
    parseArgs :: [String] -> (Bool, Int)
    parseArgs args =
      let v = "-v" `Prelude.elem` args || "--verbose" `Prelude.elem` args
          nums = Prelude.filter (\x -> x /= "-v" && x /= "--verbose") args
          k = case nums of { (x:_) -> read x; _ -> 10 }
      in (v, k)

    loop :: Int -> Bool -> InputT IO ()
    loop k verbose = do
      minput <- getInputLine "typechecker> "
      case minput of
        Nothing -> loop k verbose
        Just ":q" -> pure ()
        Just ":help" -> do{outputStrLn "\nTypechecks the decidable fragment of Milner-Mycroft calculus\n\nAvailable Options:\n:q\tExit interactive mode\n:help\tShow this help\n"; loop k verbose}
        Just input -> do{
            case parseTerm $ pack input of
              Left err -> do{outputStrLn err; loop k verbose}
              Right tm -> do{
                outputStrLn "";
                typ <- if verbose
                       then runStderrLoggingT $ showTyp k emptyEnv tm
                       else runNoLoggingT $ showTyp k emptyEnv tm;
                outputStrLn (Prelude.show (fst typ) ++ ":-" ++ Prelude.show tm ++ ":" ++ Prelude.show (snd typ));
                outputStrLn "";loop k verbose;
}
}
