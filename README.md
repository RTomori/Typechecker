# Typechecker for Milner-Mycroft calculus
![build status](https://github.com/RTomori/Typechecker/actions/workflows/haskell.yml/badge.svg)

Milner-Mycroft計算の決定可能な断片にHindley-Milner型システムを加えた体系($\vdash_{0}^{k,\rm{ML}}$，[1]pp.7-10)の実装．

## Getting Started
### Prerequisites
+ StackまたはCabal
  - ビルドツール．対応するGHCコンパイラ(ver9.4.8)および依存パッケージの導入に使う．
  - [GHCup](https://www.haskell.org/ghcup/)を経由すればインストールできる．
+ Happy
  - パーザジェネレータ．stackなどでインストールする．

### Setup
stackを使う場合は，このリポジトリをクローンしたフォルダ内で
```
stack build #依存ライブラリをインストールしビルドする
stack run #オプションは--の後に記述する e.g. stack run -- -v 10 
```
を実行する．Cabalを使う場合は，
```
cabal build
cabal run exe:typechecker-exe #オプションは--の後に記述する e.g. cabal run exe:typechecker-exe -- -v 10
```
のようにする．

明示的に実行可能なバイナリファイルを生成する場合は`../TypeChecker/app`に移動し，
```
cabal ghc Main.hs #もしくはstack ghc Main.hs
```
を実行する．`cabal`または`stack`を経由せず`ghc`でコンパイルを試みると依存ライブラリのリンクに失敗する．

## Usages&Examples
型推論は対話環境の中で実行される: 項を入力し，主要型付けが存在するならばそれを返し，存在しなければ対応するエラーを出力する．対話環境に対し，起動時に渡せるオプションは以下の3つ:
- `-v`または`--verbose`: 型推論の全過程を表示．
- `[1-9][0-9]*|0`: `fix`を含む項に対する型推論の反復回数の上限を設定(デフォルトは10回)
- `-h`または`--help`: ヘルプの表示

対話環境内でヘルプを表示する場合は`:h`を，終了する場合は`:q`を入力する．

対話環境に対し，`-v`オプションを渡した場合の実行例を示す．
```
typechecker> rec{g = fun x -> g 2 + g false}

[Debug] Plus:(fromList [],(int,int)->int)
[Debug] Pair:(fromList [],v0->v1->(v0,v1))
[Debug] "g":(fromList [],v2)
[Debug] 2:(fromList [],int)
[Debug] Substs:fromList [(2,int->v4),(3,int)]
[Debug] g 2:(fromList [],v4)
[Debug] Substs:fromList [(4,v0)]
[Debug] Pair g 2:(fromList [],v1->(v0,v1))
[Debug] "g":(fromList [],v5)
[Debug] False:(fromList [],bool)
[Debug] Substs:fromList [(5,bool->v7),(6,bool)]
[Debug] g False:(fromList [],v7)
[Debug] Substs:fromList [(7,v1)]
[Debug] Pair (g 2) g False:(fromList [],(v0,v1))
[Debug] Substs:fromList [(0,int),(1,int)]
[Debug] Plus (Pair (g 2)) (g False):(fromList [],int)
[Debug] fun "x".Plus ((Pair (g 2)) (g False)):(fromList [],v8->int)
[Debug] iteration #1:Right (fromList [],v8->int)
[Debug] Plus:(fromList [],(int,int)->int)
[Debug] Pair:(fromList [],v0->v1->(v0,v1))
[Debug] "g":(fromList [],v2->int)
[Debug] 2:(fromList [],int)
[Debug] Substs:fromList [(2,int)]
[Debug] g 2:(fromList [],int)
[Debug] Substs:fromList [(0,int)]
[Debug] Pair g 2:(fromList [],v1->(int,v1))
[Debug] "g":(fromList [],v3->int)
[Debug] False:(fromList [],bool)
[Debug] Substs:fromList [(3,bool)]
[Debug] g False:(fromList [],int)
[Debug] Substs:fromList [(1,int)]
[Debug] Pair (g 2) g False:(fromList [],(int,int))
[Debug] Substs:fromList []
[Debug] Plus (Pair (g 2)) (g False):(fromList [],int)
[Debug] fun "x".Plus ((Pair (g 2)) (g False)):(fromList [],v4->int)
[Debug] iteration #2:Right (fromList [],v4->int)
[Info] Principal typing before normalization: (fromList [],v8->int)
fromList []:-rec"g".fun "x".Plus ((Pair (g 2)) (g False)):Right (fromList [],v0->int)
```
さきほどの例では，recで束縛された変数`g`の型が本体の2つの出現で相異なる型で具体化される($\tt{int \to int, bool \to int}$)．そのためHindley-Milner型システムで型付け出来ないが， $\vdash_{0}^{k,\rm{ML}}(k\geq 2)$ でprincipal typing $\langle\emptyset;\alpha\to \mathtt{int}\rangle$をもつ．このことは，以下の例から示される．
```
#繰返し上限を1としたときの実行結果．繰返し上限までに型が収束しないので単相再帰のための規則で型付けされ，単一化に失敗する
typechecker> rec{g = fun x -> g 2 + g false}

fromList []|-rec"g".fun "x".Plus ((Pair (g 2)) (g False)):Left (UnifyErr EUnsolvable)

#繰返し上限を4としたときの実行結果
typechecker>  rec{g = fun x -> g 2 + g false}

fromList []|-rec"g".fun "x".Plus ((Pair (g 2)) (g False)):Right (fromList [],v0->int)
```

MLで型付けできる項をMilner-Mycroft計算の規則で型付けしてみよう．たとえば，`rec{f= fun g h1 y -> if false then y else g(f g h1(f h1 g y))}`を考える．[1]によれば，この項は4回の繰返しで型付けできる．これを確かめる．
```
typechecker> rec{f = fun g h1 y -> if false then y else g(f g h1(f h1 g y))}
(省略)
[Debug] fun "g".fun "h1".fun "y".((Ifc False) y) (g (((f g) h1) (((f h1) g) y))):(fromList [],(v24->v20)->v14->v20->v20)
[Debug] iteration #1:Right (fromList [],(v24->v20)->v14->v20->v20)
(省略)
[Debug] fun "g".fun "h1".fun "y".((Ifc False) y) (g (((f g) h1) (((f h1) g) y))):(fromList [],(v3->v3)->(v13->v3)->v3->v3)
[Debug] iteration #2:Right (fromList [],(v3->v3)->(v13->v3)->v3->v3)
(省略)
[Debug] fun "g".fun "h1".fun "y".((Ifc False) y) (g (((f g) h1) (((f h1) g) y))):(fromList [],(v3->v3)->(v3->v3)->v3->v3)
[Debug] iteration #3:Right (fromList [],(v3->v3)->(v3->v3)->v3->v3)
(省略)
[Debug] fun "g".fun "h1".fun "y".((Ifc False) y) (g (((f g) h1) (((f h1) g) y))):(fromList [],(v3->v3)->(v3->v3)->v3->v3)
[Debug] iteration #4:Right (fromList [],(v3->v3)->(v3->v3)->v3->v3)
[Info] Principal typing before normalization: (fromList [],(v3->v3)->(v3->v3)->v3->v3)
fromList []:-rec"f".fun "g".fun "h1".fun "y".((Ifc False) y) (g (((f g) h1) (((f h1) g) y))):Right (fromList [],(v0->v0)->(v0->v0)->v0->v0)
```


let多相は[2]の型付け規則$(\rm{LetPS})$([2]p.416, Fig. 5)によりサポートしている．たとえば，以下の項はprincipal typing $\langle \emptyset;\mathtt{int \to bool \to (int, bool)\rangle}$をもつ:`fun x -> let y = x + 1 in fun z-> (y, not z)`．また，これと $\alpha$ 同値で変数の捕獲が起こる `fun x -> let y = x + 1 in fun x -> (y, not x)`も型付け可能となるように変更を加えている．([2]p.412, fig.4)

この拡張は型変数の(一斉の)シフトを伴なうのみなので， この型体系は $\vdash_{0}^{k, \rm{ML}}$ を真に包含する．じっさい，[1]p.8, Proposition 9より，環境 $D$ のもとでの式 $e$ の principal typing $(U; u)$ とtyping $(U'; u')$ に対し，$(U'; u')$ が環境 $D$ のもとでの式 $e$ のprincipal typing であることの必要十分条件は， $s(U) = U' \land s(u) = u'$ となる全単射 $s$ が存在することである．型変数の一斉シフトはこのような全単射を定める．

型推論のトレースを出力しない場合は，型の"正規形"として，異なる型変数に0から順番にインデックスを振ったものを出力するようにしてある．
## Syntax
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

aexpr ::= aexpr + aexpr|aexpr - aexpr|aexpr * aexpr 
        |aexpr == aexpr|aexpr < aexpr 
        |aexpr && aexpr|aexpr || aexpr
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
rec{f = fun g h1 y -> if false then y else g(f g h1(f h1 g y))}
rec{foldr = fun f e xs -> if (null xs) then e else f (hd xs) (foldr f e (tl xs)) }
```
ただし，OcamlやHaskellなどと異なり，たとえばリスト`g(tl xs)`の先頭に`f (hd xs)`を付加した以下の項は構文的に正しくないとされることに注意．
```
f (hd xs): g(tl xs)
```

## References
[1]Comini, M., Damiani, F., Vrech, S. (2008). On Polymorphic Recursion, Type Systems, and Abstract Interpretation. In: Alpuente, M., Vidal, G. (eds) Static Analysis. SAS 2008. Lecture Notes in Computer Science, vol 5079. Springer, Berlin, Heidelberg. https://doi.org/10.1007/978-3-540-69166-2_10

[2]Ferruccio Damiani. 2007. Rank 2 Intersection for Recursive Definitions. Fundam. Inf. 77, 4 (August 2007), 451–488.
