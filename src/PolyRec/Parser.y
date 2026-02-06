{
{-# LANGUAGE OverloadedStrings #-}
module PolyRec.Parser (termparser) where
import PolyRec.Syntax
import PolyRec.Lexer (Token(..),Alex,AlexPosn(AlexPn),alexMonadScan,alexError,alexGetInput)
}

%name termparser
%tokentype {Token}
%error {parseError}
%monad {Alex} {>>=} {return}
%lexer {lexer} {TokenEOF}

%token
	let {TokenLet}
	in {TokenIn}
	rec {TokenRec}
	if {TokenIf}
	then {TokenThen}
	else {TokenElse}
    null {TokenNull}
	hd {TokenHd }
	tl {TokenTl}
	fst {TokenFst}
	snd {TokenSnd }
	true {TokenTrue}
	false {TokenFalse}
	int {TokenInt $$}
	var {TokenSym $$}
	'->' {TokenArrow  }
	'&&' {TokenAnd  }
	'||' {TokenOr  }
     not {TokenNot}
	'=' {TokenEq  }
    '==' {TokenEquiv}
	'<' {TokenLt  }
	fun {TokenLam }
	'+' {TokenAdd  }
	'-' {TokenSub  }
	'*' {TokenMul  }
	'(' {TokenLParen  }
	')' {TokenRParen }
	'{' {TokenLBrace  }
	'}' {TokenRBrace }
	'[' {TokenLSqBrack }
	']' {TokenRSqBrack}
	',' {TokenComma }
    ':' {TokenColon}

%right in
%left '&&' '||'
%right not
%left '<' '=='
%left '+' '-'
%right '*' 
%right ':'
%%

Expr : let var '=' Expr in Expr { TmLet $2 $4 $6 }
     | let rec var Vars '=' Expr in Expr { TmLet $3 (TmRec $3 (foldr (\x e -> TmAbs x e) $6 $4)) $8 }
     | fun Vars '->' Expr { foldr (\x e -> TmAbs x e) $4 $2 }
     | if Expr then Expr else Expr { TmApp (TmApp (TmApp (TmConst Ifc) $2) $4) $6 }
	 | Atom ':' Expr {TmApp (TmApp (TmConst Cons) $1) $3 }
	 | rec '{' var '=' Expr '}' { TmRec $3 $5 }
	 | Form { $1 }

Form : Form '+' Form { TmApp (TmConst Plus) (TmApp (TmApp (TmConst Pair) $1) $3) }
     | Form '-' Form { TmApp (TmConst Minus) (TmApp (TmApp (TmConst Pair) $1) $3) }
	 | Form '*' Form { TmApp (TmConst Times) (TmApp (TmApp (TmConst Pair) $1) $3) }
     | Form '==' Form { TmApp (TmConst Equiv) (TmApp (TmApp (TmConst Pair) $1) $3) }
     | Form '<' Form { TmApp (TmConst Lt) (TmApp (TmApp (TmConst Pair) $1) $3) }
     | Form '&&' Form { TmApp (TmConst And) (TmApp (TmApp (TmConst Pair) $1) $3) }
     | Form '||' Form { TmApp (TmConst Or) (TmApp (TmApp (TmConst Pair) $1) $3) }
     | not Form { TmApp (TmConst Not) $2 }
	 | Fact { $1 }


Vars : var { [$1] }
     | var Vars { $1:$2 }

Fact : Fact Atom { TmApp $1 $2 }
     | Atom { $1 }

Atom : '(' Expr ')' { $2 }
     | int { TmLit (LInt $1) }
	 | var { TmVar $1 }
	 | true { TmLit (LBool True) }
	 | false { TmLit (LBool False) }
     | fst Atom { TmApp (TmConst Fst) $2 }
     | snd Atom { TmApp (TmConst Snd) $2 }
     | hd Atom { TmApp (TmConst Hd) $2 }
     | tl Atom { TmApp (TmConst Tl) $2 }
     | null Atom {TmApp (TmConst Null) $2 }
     | '[' ListExpr ']' { $2 }
     | '(' Expr ',' Expr ')' { TmApp (TmApp (TmConst Pair) $2) $4 }

ListExpr : {- if empty -}  { TmConst Nil }
         | Atom { TmApp(TmApp (TmConst Cons) $1) (TmConst Nil) }
         | Atom ',' ListExpr { TmApp (TmApp (TmConst Cons) $1) $3 }
{
parseError :: Token -> Alex a
parseError _ = do{
  ((AlexPn _ line column), _, _,_) <- alexGetInput;
  alexError ("Parse error at line: " ++ (show line) ++ ", column " ++ (show column));
}
lexer :: (Token -> Alex a) -> Alex a
lexer = (alexMonadScan >>=)
}
