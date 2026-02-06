# Typechecker for Milner-Mycroft calculus
![build status](https://github.com/RTomori/Typechecker/actions/workflows/haskell.yml/badge.svg)

再帰的定義において変数型の複数の具体化を許すMilner-Mycroft計算の決定可能な断片にHindley-Milner型システムを加えた体系($\vdash_{0}^{k,\rm{ML}}$，[1]pp.7-10)の実装．

## Getting Started
### Prerequisites
+ StackまたはCabal
  - ビルドツール．対応するGHCコンパイラ(ver9.4.8)および依存パッケージの導入に使う．
  - [GHCup](https://www.haskell.org/ghcup/)を経由すればインストールできる．
+ (optional)alex/happy
  - 字句解析器/構文解析器ジェネレータ．stackなどでインストールする．
  - 字句解析器と構文解析器はともに生成済みなので必須ではない．
  - `src`フォルダにスキャナの定義を置いたままビルドすると, Alexのバグにより既存の正しい`Lexer.hs`とは別の誤ったコードが生成される。そのため，字句解析器の仕様を記述したファイルは`src`ディレクトリの上に退避させてある．
### Installation
stackを使う場合は，このリポジトリをクローンしたフォルダ内で
```
stack build #依存ライブラリをインストールしビルドする
stack run #オプションは--の後に記述する e.g. stack run -- -v 10 
```
を実行する．Cabalを使う場合は，
```
cabal build
cabal run exe:typechecker-exe #対話環境を実行．オプションは--の後に記述する 
```
のようにする．

明示的に実行可能なバイナリファイルを生成する場合は`../TypeChecker/app`に移動し，
```
cabal ghc Main.hs #もしくはstack ghc Main.hs
```
を実行する．`cabal`または`stack`を経由せず`ghc`でコンパイルを試みると依存ライブラリのリンクに失敗する．

## Usage
型推論は対話環境の中で実行される．対話環境に対し，起動時に渡せるオプションは以下の3つ:
- `-v`または`--verbose`: 型推論の全過程を表示．
- `[1-9][0-9]*|0`: `fix`を含む項に対する多相再帰による型推論の反復回数の上限を設定(デフォルトは10回)
- `-h`または`--help`: ヘルプの表示

対話環境に対し，`-v`オプションを渡した場合の実行例を示す．
```
typechecker> rec{g = fun x -> g 2 + g False}

[Debug] Pair:(fromList [],v0->v1->(v0,v1))
[Debug] "g":(fromList [],v2)
[Debug] Substs:fromList [(2,int->v4),(3,int)]
[Debug] g 2:(fromList [],v4)
[Debug] Substs:fromList [(4,v0)]
[Debug] Pair g 2:(fromList [],v1->(v0,v1))
[Debug] "g":(fromList [],v5)
[Debug] Substs:fromList [(5,bool->v7),(6,bool)]
[Debug] g False:(fromList [],v7)
[Debug] Substs:fromList [(7,v1)]
[Debug] Pair (g 2) g False:(fromList [],(v0,v1))
[Debug] Substs:fromList [(0,int),(1,int)]
[Debug] Plus (Pair (g 2)) (g False):(fromList [],int)
[Debug] fun "x".Plus ((Pair (g 2)) (g False)):(fromList [],v8->int)
[Debug] iteration #1:Right (fromList [],v8->int)
[Debug] Pair:(fromList [],v0->v1->(v0,v1))
[Debug] "g":(fromList [],v2->int)
[Debug] Substs:fromList [(2,int)]
[Debug] g 2:(fromList [],int)
[Debug] Substs:fromList [(0,int)]
[Debug] Pair g 2:(fromList [],v1->(int,v1))
[Debug] "g":(fromList [],v3->int)
[Debug] Substs:fromList [(3,bool)]
[Debug] g False:(fromList [],int)
[Debug] Substs:fromList [(1,int)]
[Debug] Pair (g 2) g False:(fromList [],(int,int))
[Debug] Substs:fromList []
[Debug] Plus (Pair (g 2)) (g False):(fromList [],int)
[Debug] fun "x".Plus ((Pair (g 2)) (g False)):(fromList [],v4->int)
[Debug] iteration #2:Right (fromList [],v4->int)
fromList []|-rec"g".fun "x".Plus ((Pair (g 2)) (g False)):Right (fromList [],v8->int)
```
さきほどの例の項はrecで束縛された変数`g`が本体で異なる型でinstantiateされる(int -> int, int->bool)のでHindley-Milner型システムで型付け出来ないが，$\vdash_{0}^{k,\rm{ML}}(k\geq 2)$でprincipal typing $\langle \{\},\alpha\to \mathtt{bool}\rangle$をもつ．以下の例により，それが示される．
```
#繰返し上限を1としたときの実行結果．単相再帰のための規則で型付けされるため，単一化に失敗する
typechecker> rec{g = fun x -> g 2 + g False}

fromList []|-rec"g".fun "x".Plus ((Pair (g 2)) (g False)):Left (UnifyErr EUnsolvable)

#繰返し上限を4としたときの実行結果
typechecker>  rec{g = fun x -> g 2 + g False}

fromList []|-rec"g".fun "x".Plus ((Pair (g 2)) (g False)):Right (fromList [],v8->int)
```


対話環境内でヘルプを表示する場合は`:h`を，終了する場合は`:q`を入力する．
### Syntax
構文は以下の通り．入力を容易とするため，[1]の二項演算子はカリー化された中置演算子とした．
```
expr ::= let var = expr in expr
      | let rec var vars = expr in expr
       |fun vars -> expr
       |if expr then expr else expr
       |rec{var = expr}
       |aexpr
       |expr expr (application)

vars ::= var|var vars  (list of whitespace-separated variables)

aexpr ::= aexpr + aexpr|aexpr - aexpr|aexpr * aexpr (arithmetic operations)
        |aexpr == aexpr|aexpr < aexpr  (equality/inequality)
        |aexpr && aexpr|aexpr || aexpr (conjunction/disjunction)
        |not aexpr
        |atom

atom ::= n (integers)
       |x (variables)
       |true|false (boolean constants)
       |[[listexpr]   (list expression)
       |(expr,expr)  (tuple expression)
       |fst atom|snd atom (projection)
       |hd atom|tl atom (list operations) 
       |(expr)

listexpr ::=atom|atom,listexpr| (list expression)
```
たとえば，以下は構文的に正しい．
```
rec{f = fun g h1 y -> if false then y else g(f g h1(f h1 g y))};
rec{foldr = fun f e xs -> if (null xs) then e else f (hd xs) (foldr f e (tl xs)) };
```
ただし，Haskellなどと異なり，たとえばリスト`g(tl xs)`の先頭に`f (hd xs)`を付加した以下の項は構文的に正しくないとされることに注意．
```
f (hd xs): g(tl xs)
```

## References
[1]Comini, M., Damiani, F., Vrech, S. (2008). On Polymorphic Recursion, Type Systems, and Abstract Interpretation. In: Alpuente, M., Vidal, G. (eds) Static Analysis. SAS 2008. Lecture Notes in Computer Science, vol 5079. Springer, Berlin, Heidelberg. https://doi.org/10.1007/978-3-540-69166-2_10

[2]Ferruccio Damiani. 2007. Rank 2 Intersection for Recursive Definitions. Fundam. Inf. 77, 4 (August 2007), 451–488.
