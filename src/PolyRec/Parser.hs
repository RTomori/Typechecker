{-# OPTIONS_GHC -w #-}
{-# LANGUAGE OverloadedStrings #-}
module PolyRec.Parser (termparser) where
import PolyRec.Syntax
import PolyRec.Lexer (Token(..),Alex,AlexPosn(AlexPn),alexMonadScan,alexError,alexGetInput)
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn t4 t5 t6 t7 t8 t9
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,209) ([39424,35071,136,32,0,0,32768,0,0,0,0,0,26112,7,63488,32783,8,0,0,32772,2048,0,0,0,32,63904,34959,8,65408,34816,0,4088,2176,32768,255,136,63488,32783,8,65408,34816,0,0,0,0,0,0,0,0,0,0,0,0,36856,2176,0,128,0,63904,34959,8,65408,34816,0,0,8192,0,0,256,0,0,33,0,1,0,2048,0,0,24576,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,128,0,0,8,0,0,16,40960,36857,2184,0,0,0,63488,32911,8,65408,34824,0,36856,2176,32768,2303,136,63488,32911,8,65408,34824,0,36856,2176,0,0,4,0,16384,0,0,1024,0,0,112,0,0,7,0,30208,0,0,1888,0,0,0,39424,35071,136,0,8,0,0,16,40960,36857,2184,0,0,0,63904,34959,8,0,0,40960,36857,2184,0,0,0,63488,32783,8,0,0,0,0,256,0,0,0,1024,0,0,65434,34952,0,0,1,1024,0,0,63904,34959,8,65434,34952,0,0,1024,39424,35071,136,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,65434,34952,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_termparser","Expr","Form","Vars","Fact","Atom","ListExpr","let","in","rec","if","then","else","null","hd","tl","fst","snd","true","false","int","var","'->'","'&&'","'||'","not","'='","'=='","'<'","fun","'+'","'-'","'*'","'('","')'","'{'","'}'","'['","']'","','","':'","%eof"]
        bit_start = st Prelude.* 44
        bit_end = (st Prelude.+ 1) Prelude.* 44
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..43]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (10) = happyShift action_7
action_0 (12) = happyShift action_8
action_0 (13) = happyShift action_9
action_0 (16) = happyShift action_10
action_0 (17) = happyShift action_11
action_0 (18) = happyShift action_12
action_0 (19) = happyShift action_13
action_0 (20) = happyShift action_14
action_0 (21) = happyShift action_15
action_0 (22) = happyShift action_16
action_0 (23) = happyShift action_17
action_0 (24) = happyShift action_18
action_0 (28) = happyShift action_19
action_0 (32) = happyShift action_20
action_0 (36) = happyShift action_21
action_0 (40) = happyShift action_22
action_0 (4) = happyGoto action_3
action_0 (5) = happyGoto action_4
action_0 (7) = happyGoto action_5
action_0 (8) = happyGoto action_6
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (10) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (24) = happyShift action_38
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (44) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (26) = happyShift action_41
action_4 (27) = happyShift action_42
action_4 (30) = happyShift action_43
action_4 (31) = happyShift action_44
action_4 (33) = happyShift action_45
action_4 (34) = happyShift action_46
action_4 (35) = happyShift action_47
action_4 _ = happyReduce_7

action_5 (16) = happyShift action_10
action_5 (17) = happyShift action_11
action_5 (18) = happyShift action_12
action_5 (19) = happyShift action_13
action_5 (20) = happyShift action_14
action_5 (21) = happyShift action_15
action_5 (22) = happyShift action_16
action_5 (23) = happyShift action_17
action_5 (24) = happyShift action_18
action_5 (36) = happyShift action_21
action_5 (40) = happyShift action_22
action_5 (8) = happyGoto action_40
action_5 _ = happyReduce_16

action_6 (43) = happyShift action_39
action_6 _ = happyReduce_20

action_7 (12) = happyShift action_37
action_7 (24) = happyShift action_38
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (38) = happyShift action_36
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (10) = happyShift action_7
action_9 (12) = happyShift action_8
action_9 (13) = happyShift action_9
action_9 (16) = happyShift action_10
action_9 (17) = happyShift action_11
action_9 (18) = happyShift action_12
action_9 (19) = happyShift action_13
action_9 (20) = happyShift action_14
action_9 (21) = happyShift action_15
action_9 (22) = happyShift action_16
action_9 (23) = happyShift action_17
action_9 (24) = happyShift action_18
action_9 (28) = happyShift action_19
action_9 (32) = happyShift action_20
action_9 (36) = happyShift action_21
action_9 (40) = happyShift action_22
action_9 (4) = happyGoto action_35
action_9 (5) = happyGoto action_4
action_9 (7) = happyGoto action_5
action_9 (8) = happyGoto action_6
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (16) = happyShift action_10
action_10 (17) = happyShift action_11
action_10 (18) = happyShift action_12
action_10 (19) = happyShift action_13
action_10 (20) = happyShift action_14
action_10 (21) = happyShift action_15
action_10 (22) = happyShift action_16
action_10 (23) = happyShift action_17
action_10 (24) = happyShift action_18
action_10 (36) = happyShift action_21
action_10 (40) = happyShift action_22
action_10 (8) = happyGoto action_34
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (16) = happyShift action_10
action_11 (17) = happyShift action_11
action_11 (18) = happyShift action_12
action_11 (19) = happyShift action_13
action_11 (20) = happyShift action_14
action_11 (21) = happyShift action_15
action_11 (22) = happyShift action_16
action_11 (23) = happyShift action_17
action_11 (24) = happyShift action_18
action_11 (36) = happyShift action_21
action_11 (40) = happyShift action_22
action_11 (8) = happyGoto action_33
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (16) = happyShift action_10
action_12 (17) = happyShift action_11
action_12 (18) = happyShift action_12
action_12 (19) = happyShift action_13
action_12 (20) = happyShift action_14
action_12 (21) = happyShift action_15
action_12 (22) = happyShift action_16
action_12 (23) = happyShift action_17
action_12 (24) = happyShift action_18
action_12 (36) = happyShift action_21
action_12 (40) = happyShift action_22
action_12 (8) = happyGoto action_32
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (16) = happyShift action_10
action_13 (17) = happyShift action_11
action_13 (18) = happyShift action_12
action_13 (19) = happyShift action_13
action_13 (20) = happyShift action_14
action_13 (21) = happyShift action_15
action_13 (22) = happyShift action_16
action_13 (23) = happyShift action_17
action_13 (24) = happyShift action_18
action_13 (36) = happyShift action_21
action_13 (40) = happyShift action_22
action_13 (8) = happyGoto action_31
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (16) = happyShift action_10
action_14 (17) = happyShift action_11
action_14 (18) = happyShift action_12
action_14 (19) = happyShift action_13
action_14 (20) = happyShift action_14
action_14 (21) = happyShift action_15
action_14 (22) = happyShift action_16
action_14 (23) = happyShift action_17
action_14 (24) = happyShift action_18
action_14 (36) = happyShift action_21
action_14 (40) = happyShift action_22
action_14 (8) = happyGoto action_30
action_14 _ = happyFail (happyExpListPerState 14)

action_15 _ = happyReduce_24

action_16 _ = happyReduce_25

action_17 _ = happyReduce_22

action_18 _ = happyReduce_23

action_19 (16) = happyShift action_10
action_19 (17) = happyShift action_11
action_19 (18) = happyShift action_12
action_19 (19) = happyShift action_13
action_19 (20) = happyShift action_14
action_19 (21) = happyShift action_15
action_19 (22) = happyShift action_16
action_19 (23) = happyShift action_17
action_19 (24) = happyShift action_18
action_19 (28) = happyShift action_19
action_19 (36) = happyShift action_21
action_19 (40) = happyShift action_22
action_19 (5) = happyGoto action_28
action_19 (7) = happyGoto action_5
action_19 (8) = happyGoto action_29
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (24) = happyShift action_27
action_20 (6) = happyGoto action_26
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (10) = happyShift action_7
action_21 (12) = happyShift action_8
action_21 (13) = happyShift action_9
action_21 (16) = happyShift action_10
action_21 (17) = happyShift action_11
action_21 (18) = happyShift action_12
action_21 (19) = happyShift action_13
action_21 (20) = happyShift action_14
action_21 (21) = happyShift action_15
action_21 (22) = happyShift action_16
action_21 (23) = happyShift action_17
action_21 (24) = happyShift action_18
action_21 (28) = happyShift action_19
action_21 (32) = happyShift action_20
action_21 (36) = happyShift action_21
action_21 (40) = happyShift action_22
action_21 (4) = happyGoto action_25
action_21 (5) = happyGoto action_4
action_21 (7) = happyGoto action_5
action_21 (8) = happyGoto action_6
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (16) = happyShift action_10
action_22 (17) = happyShift action_11
action_22 (18) = happyShift action_12
action_22 (19) = happyShift action_13
action_22 (20) = happyShift action_14
action_22 (21) = happyShift action_15
action_22 (22) = happyShift action_16
action_22 (23) = happyShift action_17
action_22 (24) = happyShift action_18
action_22 (36) = happyShift action_21
action_22 (40) = happyShift action_22
action_22 (8) = happyGoto action_23
action_22 (9) = happyGoto action_24
action_22 _ = happyReduce_33

action_23 (42) = happyShift action_65
action_23 _ = happyReduce_34

action_24 (41) = happyShift action_64
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (37) = happyShift action_62
action_25 (42) = happyShift action_63
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (25) = happyShift action_61
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (24) = happyShift action_27
action_27 (6) = happyGoto action_60
action_27 _ = happyReduce_17

action_28 (30) = happyShift action_43
action_28 (31) = happyShift action_44
action_28 (33) = happyShift action_45
action_28 (34) = happyShift action_46
action_28 (35) = happyShift action_47
action_28 _ = happyReduce_15

action_29 _ = happyReduce_20

action_30 _ = happyReduce_27

action_31 _ = happyReduce_26

action_32 _ = happyReduce_29

action_33 _ = happyReduce_28

action_34 _ = happyReduce_30

action_35 (14) = happyShift action_59
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (24) = happyShift action_58
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (24) = happyShift action_57
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (29) = happyShift action_56
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (10) = happyShift action_7
action_39 (12) = happyShift action_8
action_39 (13) = happyShift action_9
action_39 (16) = happyShift action_10
action_39 (17) = happyShift action_11
action_39 (18) = happyShift action_12
action_39 (19) = happyShift action_13
action_39 (20) = happyShift action_14
action_39 (21) = happyShift action_15
action_39 (22) = happyShift action_16
action_39 (23) = happyShift action_17
action_39 (24) = happyShift action_18
action_39 (28) = happyShift action_19
action_39 (32) = happyShift action_20
action_39 (36) = happyShift action_21
action_39 (40) = happyShift action_22
action_39 (4) = happyGoto action_55
action_39 (5) = happyGoto action_4
action_39 (7) = happyGoto action_5
action_39 (8) = happyGoto action_6
action_39 _ = happyFail (happyExpListPerState 39)

action_40 _ = happyReduce_19

action_41 (16) = happyShift action_10
action_41 (17) = happyShift action_11
action_41 (18) = happyShift action_12
action_41 (19) = happyShift action_13
action_41 (20) = happyShift action_14
action_41 (21) = happyShift action_15
action_41 (22) = happyShift action_16
action_41 (23) = happyShift action_17
action_41 (24) = happyShift action_18
action_41 (28) = happyShift action_19
action_41 (36) = happyShift action_21
action_41 (40) = happyShift action_22
action_41 (5) = happyGoto action_54
action_41 (7) = happyGoto action_5
action_41 (8) = happyGoto action_29
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (16) = happyShift action_10
action_42 (17) = happyShift action_11
action_42 (18) = happyShift action_12
action_42 (19) = happyShift action_13
action_42 (20) = happyShift action_14
action_42 (21) = happyShift action_15
action_42 (22) = happyShift action_16
action_42 (23) = happyShift action_17
action_42 (24) = happyShift action_18
action_42 (28) = happyShift action_19
action_42 (36) = happyShift action_21
action_42 (40) = happyShift action_22
action_42 (5) = happyGoto action_53
action_42 (7) = happyGoto action_5
action_42 (8) = happyGoto action_29
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (16) = happyShift action_10
action_43 (17) = happyShift action_11
action_43 (18) = happyShift action_12
action_43 (19) = happyShift action_13
action_43 (20) = happyShift action_14
action_43 (21) = happyShift action_15
action_43 (22) = happyShift action_16
action_43 (23) = happyShift action_17
action_43 (24) = happyShift action_18
action_43 (28) = happyShift action_19
action_43 (36) = happyShift action_21
action_43 (40) = happyShift action_22
action_43 (5) = happyGoto action_52
action_43 (7) = happyGoto action_5
action_43 (8) = happyGoto action_29
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (16) = happyShift action_10
action_44 (17) = happyShift action_11
action_44 (18) = happyShift action_12
action_44 (19) = happyShift action_13
action_44 (20) = happyShift action_14
action_44 (21) = happyShift action_15
action_44 (22) = happyShift action_16
action_44 (23) = happyShift action_17
action_44 (24) = happyShift action_18
action_44 (28) = happyShift action_19
action_44 (36) = happyShift action_21
action_44 (40) = happyShift action_22
action_44 (5) = happyGoto action_51
action_44 (7) = happyGoto action_5
action_44 (8) = happyGoto action_29
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (16) = happyShift action_10
action_45 (17) = happyShift action_11
action_45 (18) = happyShift action_12
action_45 (19) = happyShift action_13
action_45 (20) = happyShift action_14
action_45 (21) = happyShift action_15
action_45 (22) = happyShift action_16
action_45 (23) = happyShift action_17
action_45 (24) = happyShift action_18
action_45 (28) = happyShift action_19
action_45 (36) = happyShift action_21
action_45 (40) = happyShift action_22
action_45 (5) = happyGoto action_50
action_45 (7) = happyGoto action_5
action_45 (8) = happyGoto action_29
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (16) = happyShift action_10
action_46 (17) = happyShift action_11
action_46 (18) = happyShift action_12
action_46 (19) = happyShift action_13
action_46 (20) = happyShift action_14
action_46 (21) = happyShift action_15
action_46 (22) = happyShift action_16
action_46 (23) = happyShift action_17
action_46 (24) = happyShift action_18
action_46 (28) = happyShift action_19
action_46 (36) = happyShift action_21
action_46 (40) = happyShift action_22
action_46 (5) = happyGoto action_49
action_46 (7) = happyGoto action_5
action_46 (8) = happyGoto action_29
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (16) = happyShift action_10
action_47 (17) = happyShift action_11
action_47 (18) = happyShift action_12
action_47 (19) = happyShift action_13
action_47 (20) = happyShift action_14
action_47 (21) = happyShift action_15
action_47 (22) = happyShift action_16
action_47 (23) = happyShift action_17
action_47 (24) = happyShift action_18
action_47 (28) = happyShift action_19
action_47 (36) = happyShift action_21
action_47 (40) = happyShift action_22
action_47 (5) = happyGoto action_48
action_47 (7) = happyGoto action_5
action_47 (8) = happyGoto action_29
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (35) = happyShift action_47
action_48 _ = happyReduce_10

action_49 (35) = happyShift action_47
action_49 _ = happyReduce_9

action_50 (35) = happyShift action_47
action_50 _ = happyReduce_8

action_51 (33) = happyShift action_45
action_51 (34) = happyShift action_46
action_51 (35) = happyShift action_47
action_51 _ = happyReduce_12

action_52 (33) = happyShift action_45
action_52 (34) = happyShift action_46
action_52 (35) = happyShift action_47
action_52 _ = happyReduce_11

action_53 (30) = happyShift action_43
action_53 (31) = happyShift action_44
action_53 (33) = happyShift action_45
action_53 (34) = happyShift action_46
action_53 (35) = happyShift action_47
action_53 _ = happyReduce_14

action_54 (30) = happyShift action_43
action_54 (31) = happyShift action_44
action_54 (33) = happyShift action_45
action_54 (34) = happyShift action_46
action_54 (35) = happyShift action_47
action_54 _ = happyReduce_13

action_55 _ = happyReduce_5

action_56 (10) = happyShift action_7
action_56 (12) = happyShift action_8
action_56 (13) = happyShift action_9
action_56 (16) = happyShift action_10
action_56 (17) = happyShift action_11
action_56 (18) = happyShift action_12
action_56 (19) = happyShift action_13
action_56 (20) = happyShift action_14
action_56 (21) = happyShift action_15
action_56 (22) = happyShift action_16
action_56 (23) = happyShift action_17
action_56 (24) = happyShift action_18
action_56 (28) = happyShift action_19
action_56 (32) = happyShift action_20
action_56 (36) = happyShift action_21
action_56 (40) = happyShift action_22
action_56 (4) = happyGoto action_72
action_56 (5) = happyGoto action_4
action_56 (7) = happyGoto action_5
action_56 (8) = happyGoto action_6
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (24) = happyShift action_27
action_57 (6) = happyGoto action_71
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (29) = happyShift action_70
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (10) = happyShift action_7
action_59 (12) = happyShift action_8
action_59 (13) = happyShift action_9
action_59 (16) = happyShift action_10
action_59 (17) = happyShift action_11
action_59 (18) = happyShift action_12
action_59 (19) = happyShift action_13
action_59 (20) = happyShift action_14
action_59 (21) = happyShift action_15
action_59 (22) = happyShift action_16
action_59 (23) = happyShift action_17
action_59 (24) = happyShift action_18
action_59 (28) = happyShift action_19
action_59 (32) = happyShift action_20
action_59 (36) = happyShift action_21
action_59 (40) = happyShift action_22
action_59 (4) = happyGoto action_69
action_59 (5) = happyGoto action_4
action_59 (7) = happyGoto action_5
action_59 (8) = happyGoto action_6
action_59 _ = happyFail (happyExpListPerState 59)

action_60 _ = happyReduce_18

action_61 (10) = happyShift action_7
action_61 (12) = happyShift action_8
action_61 (13) = happyShift action_9
action_61 (16) = happyShift action_10
action_61 (17) = happyShift action_11
action_61 (18) = happyShift action_12
action_61 (19) = happyShift action_13
action_61 (20) = happyShift action_14
action_61 (21) = happyShift action_15
action_61 (22) = happyShift action_16
action_61 (23) = happyShift action_17
action_61 (24) = happyShift action_18
action_61 (28) = happyShift action_19
action_61 (32) = happyShift action_20
action_61 (36) = happyShift action_21
action_61 (40) = happyShift action_22
action_61 (4) = happyGoto action_68
action_61 (5) = happyGoto action_4
action_61 (7) = happyGoto action_5
action_61 (8) = happyGoto action_6
action_61 _ = happyFail (happyExpListPerState 61)

action_62 _ = happyReduce_21

action_63 (10) = happyShift action_7
action_63 (12) = happyShift action_8
action_63 (13) = happyShift action_9
action_63 (16) = happyShift action_10
action_63 (17) = happyShift action_11
action_63 (18) = happyShift action_12
action_63 (19) = happyShift action_13
action_63 (20) = happyShift action_14
action_63 (21) = happyShift action_15
action_63 (22) = happyShift action_16
action_63 (23) = happyShift action_17
action_63 (24) = happyShift action_18
action_63 (28) = happyShift action_19
action_63 (32) = happyShift action_20
action_63 (36) = happyShift action_21
action_63 (40) = happyShift action_22
action_63 (4) = happyGoto action_67
action_63 (5) = happyGoto action_4
action_63 (7) = happyGoto action_5
action_63 (8) = happyGoto action_6
action_63 _ = happyFail (happyExpListPerState 63)

action_64 _ = happyReduce_31

action_65 (16) = happyShift action_10
action_65 (17) = happyShift action_11
action_65 (18) = happyShift action_12
action_65 (19) = happyShift action_13
action_65 (20) = happyShift action_14
action_65 (21) = happyShift action_15
action_65 (22) = happyShift action_16
action_65 (23) = happyShift action_17
action_65 (24) = happyShift action_18
action_65 (36) = happyShift action_21
action_65 (40) = happyShift action_22
action_65 (8) = happyGoto action_23
action_65 (9) = happyGoto action_66
action_65 _ = happyReduce_33

action_66 _ = happyReduce_35

action_67 (37) = happyShift action_77
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_3

action_69 (15) = happyShift action_76
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (10) = happyShift action_7
action_70 (12) = happyShift action_8
action_70 (13) = happyShift action_9
action_70 (16) = happyShift action_10
action_70 (17) = happyShift action_11
action_70 (18) = happyShift action_12
action_70 (19) = happyShift action_13
action_70 (20) = happyShift action_14
action_70 (21) = happyShift action_15
action_70 (22) = happyShift action_16
action_70 (23) = happyShift action_17
action_70 (24) = happyShift action_18
action_70 (28) = happyShift action_19
action_70 (32) = happyShift action_20
action_70 (36) = happyShift action_21
action_70 (40) = happyShift action_22
action_70 (4) = happyGoto action_75
action_70 (5) = happyGoto action_4
action_70 (7) = happyGoto action_5
action_70 (8) = happyGoto action_6
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (29) = happyShift action_74
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (11) = happyShift action_73
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (10) = happyShift action_7
action_73 (12) = happyShift action_8
action_73 (13) = happyShift action_9
action_73 (16) = happyShift action_10
action_73 (17) = happyShift action_11
action_73 (18) = happyShift action_12
action_73 (19) = happyShift action_13
action_73 (20) = happyShift action_14
action_73 (21) = happyShift action_15
action_73 (22) = happyShift action_16
action_73 (23) = happyShift action_17
action_73 (24) = happyShift action_18
action_73 (28) = happyShift action_19
action_73 (32) = happyShift action_20
action_73 (36) = happyShift action_21
action_73 (40) = happyShift action_22
action_73 (4) = happyGoto action_81
action_73 (5) = happyGoto action_4
action_73 (7) = happyGoto action_5
action_73 (8) = happyGoto action_6
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (10) = happyShift action_7
action_74 (12) = happyShift action_8
action_74 (13) = happyShift action_9
action_74 (16) = happyShift action_10
action_74 (17) = happyShift action_11
action_74 (18) = happyShift action_12
action_74 (19) = happyShift action_13
action_74 (20) = happyShift action_14
action_74 (21) = happyShift action_15
action_74 (22) = happyShift action_16
action_74 (23) = happyShift action_17
action_74 (24) = happyShift action_18
action_74 (28) = happyShift action_19
action_74 (32) = happyShift action_20
action_74 (36) = happyShift action_21
action_74 (40) = happyShift action_22
action_74 (4) = happyGoto action_80
action_74 (5) = happyGoto action_4
action_74 (7) = happyGoto action_5
action_74 (8) = happyGoto action_6
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (39) = happyShift action_79
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (10) = happyShift action_7
action_76 (12) = happyShift action_8
action_76 (13) = happyShift action_9
action_76 (16) = happyShift action_10
action_76 (17) = happyShift action_11
action_76 (18) = happyShift action_12
action_76 (19) = happyShift action_13
action_76 (20) = happyShift action_14
action_76 (21) = happyShift action_15
action_76 (22) = happyShift action_16
action_76 (23) = happyShift action_17
action_76 (24) = happyShift action_18
action_76 (28) = happyShift action_19
action_76 (32) = happyShift action_20
action_76 (36) = happyShift action_21
action_76 (40) = happyShift action_22
action_76 (4) = happyGoto action_78
action_76 (5) = happyGoto action_4
action_76 (7) = happyGoto action_5
action_76 (8) = happyGoto action_6
action_76 _ = happyFail (happyExpListPerState 76)

action_77 _ = happyReduce_32

action_78 _ = happyReduce_4

action_79 _ = happyReduce_6

action_80 (11) = happyShift action_82
action_80 _ = happyFail (happyExpListPerState 80)

action_81 _ = happyReduce_1

action_82 (10) = happyShift action_7
action_82 (12) = happyShift action_8
action_82 (13) = happyShift action_9
action_82 (16) = happyShift action_10
action_82 (17) = happyShift action_11
action_82 (18) = happyShift action_12
action_82 (19) = happyShift action_13
action_82 (20) = happyShift action_14
action_82 (21) = happyShift action_15
action_82 (22) = happyShift action_16
action_82 (23) = happyShift action_17
action_82 (24) = happyShift action_18
action_82 (28) = happyShift action_19
action_82 (32) = happyShift action_20
action_82 (36) = happyShift action_21
action_82 (40) = happyShift action_22
action_82 (4) = happyGoto action_83
action_82 (5) = happyGoto action_4
action_82 (7) = happyGoto action_5
action_82 (8) = happyGoto action_6
action_82 _ = happyFail (happyExpListPerState 82)

action_83 _ = happyReduce_2

happyReduce_1 = happyReduce 6 4 happyReduction_1
happyReduction_1 ((HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (TmLet happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_2 = happyReduce 8 4 happyReduction_2
happyReduction_2 ((HappyAbsSyn4  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	(HappyTerminal (TokenSym happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (TmLet happy_var_3 (TmRec happy_var_3 (foldr (\x e -> TmAbs x e) happy_var_6 happy_var_4)) happy_var_8
	) `HappyStk` happyRest

happyReduce_3 = happyReduce 4 4 happyReduction_3
happyReduction_3 ((HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (foldr (\x e -> TmAbs x e) happy_var_4 happy_var_2
	) `HappyStk` happyRest

happyReduce_4 = happyReduce 6 4 happyReduction_4
happyReduction_4 ((HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (TmApp (TmApp (TmApp (TmConst Ifc) happy_var_2) happy_var_4) happy_var_6
	) `HappyStk` happyRest

happyReduce_5 = happySpecReduce_3  4 happyReduction_5
happyReduction_5 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn4
		 (TmApp (TmApp (TmConst Cons) happy_var_1) happy_var_3
	)
happyReduction_5 _ _ _  = notHappyAtAll 

happyReduce_6 = happyReduce 6 4 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSym happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (TmRec happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_7 = happySpecReduce_1  4 happyReduction_7
happyReduction_7 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  5 happyReduction_8
happyReduction_8 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Plus) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  5 happyReduction_9
happyReduction_9 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Minus) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  5 happyReduction_10
happyReduction_10 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Times) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  5 happyReduction_11
happyReduction_11 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Equiv) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  5 happyReduction_12
happyReduction_12 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Lt) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  5 happyReduction_13
happyReduction_13 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst And) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  5 happyReduction_14
happyReduction_14 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Or) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_2  5 happyReduction_15
happyReduction_15 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (TmApp (TmConst Not) happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  5 happyReduction_16
happyReduction_16 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  6 happyReduction_17
happyReduction_17 (HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_2  6 happyReduction_18
happyReduction_18 (HappyAbsSyn6  happy_var_2)
	(HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn6
		 (happy_var_1:happy_var_2
	)
happyReduction_18 _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_2  7 happyReduction_19
happyReduction_19 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (TmApp happy_var_1 happy_var_2
	)
happyReduction_19 _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  7 happyReduction_20
happyReduction_20 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  8 happyReduction_21
happyReduction_21 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  8 happyReduction_22
happyReduction_22 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn8
		 (TmLit (LInt happy_var_1)
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  8 happyReduction_23
happyReduction_23 (HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn8
		 (TmVar happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  8 happyReduction_24
happyReduction_24 _
	 =  HappyAbsSyn8
		 (TmLit (LBool True)
	)

happyReduce_25 = happySpecReduce_1  8 happyReduction_25
happyReduction_25 _
	 =  HappyAbsSyn8
		 (TmLit (LBool False)
	)

happyReduce_26 = happySpecReduce_2  8 happyReduction_26
happyReduction_26 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Fst) happy_var_2
	)
happyReduction_26 _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_2  8 happyReduction_27
happyReduction_27 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Snd) happy_var_2
	)
happyReduction_27 _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_2  8 happyReduction_28
happyReduction_28 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Hd) happy_var_2
	)
happyReduction_28 _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_2  8 happyReduction_29
happyReduction_29 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Tl) happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_2  8 happyReduction_30
happyReduction_30 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Null) happy_var_2
	)
happyReduction_30 _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  8 happyReduction_31
happyReduction_31 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happyReduce 5 8 happyReduction_32
happyReduction_32 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (TmApp (TmApp (TmConst Pair) happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_33 = happySpecReduce_0  9 happyReduction_33
happyReduction_33  =  HappyAbsSyn9
		 (TmConst Nil
	)

happyReduce_34 = happySpecReduce_1  9 happyReduction_34
happyReduction_34 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 (TmApp(TmApp (TmConst Cons) happy_var_1) (TmConst Nil)
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  9 happyReduction_35
happyReduction_35 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 (TmApp (TmApp (TmConst Cons) happy_var_1) happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	TokenEOF -> action 44 44 tk (HappyState action) sts stk;
	TokenLet -> cont 10;
	TokenIn -> cont 11;
	TokenRec -> cont 12;
	TokenIf -> cont 13;
	TokenThen -> cont 14;
	TokenElse -> cont 15;
	TokenNull -> cont 16;
	TokenHd -> cont 17;
	TokenTl -> cont 18;
	TokenFst -> cont 19;
	TokenSnd -> cont 20;
	TokenTrue -> cont 21;
	TokenFalse -> cont 22;
	TokenInt happy_dollar_dollar -> cont 23;
	TokenSym happy_dollar_dollar -> cont 24;
	TokenArrow -> cont 25;
	TokenAnd -> cont 26;
	TokenOr -> cont 27;
	TokenNot -> cont 28;
	TokenEq -> cont 29;
	TokenEquiv -> cont 30;
	TokenLt -> cont 31;
	TokenLam -> cont 32;
	TokenAdd -> cont 33;
	TokenSub -> cont 34;
	TokenMul -> cont 35;
	TokenLParen -> cont 36;
	TokenRParen -> cont 37;
	TokenLBrace -> cont 38;
	TokenRBrace -> cont 39;
	TokenLSqBrack -> cont 40;
	TokenRSqBrack -> cont 41;
	TokenComma -> cont 42;
	TokenColon -> cont 43;
	_ -> happyError' (tk, [])
	})

happyError_ explist 44 tk = happyError' (tk, explist)
happyError_ explist _ tk = happyError' (tk, explist)

happyThen :: () => Alex a -> (a -> Alex b) -> Alex b
happyThen = (>>=)
happyReturn :: () => a -> Alex a
happyReturn = (return)
happyThen1 :: () => Alex a -> (a -> Alex b) -> Alex b
happyThen1 = happyThen
happyReturn1 :: () => a -> Alex a
happyReturn1 = happyReturn
happyError' :: () => ((Token), [Prelude.String]) -> Alex a
happyError' tk = (\(tokens, _) -> parseError tokens) tk
termparser = happySomeParser where
 happySomeParser = happyThen (happyParse action_0) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: Token -> Alex a
parseError _ = do{
  ((AlexPn _ line column), _, _,_) <- alexGetInput;
  alexError ("Parse error at line: " ++ (show line) ++ ", column " ++ (show column));
}
lexer :: (Token -> Alex a) -> Alex a
lexer = (alexMonadScan >>=)
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
