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
happyExpList = Happy_Data_Array.listArray (0,203) ([39424,35071,136,16,0,0,8192,0,0,0,0,0,30304,0,32704,17408,0,0,0,256,16,0,0,8192,53248,18428,1092,57344,63,34,65280,4097,1,4088,2176,49152,127,68,65024,8195,2,0,0,0,0,0,0,0,0,0,0,0,4607,272,0,8,0,32717,17476,0,1022,544,0,0,64,0,0,1,0,4224,0,64,0,0,1,0,0,118,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,256,0,0,8,0,0,8,0,0,0,61440,287,17,65408,34824,0,18428,1088,57344,575,34,65280,4113,1,36856,2176,49152,1151,68,0,4096,0,0,128,0,0,4,0,14336,0,0,448,0,49152,14,0,30208,0,32717,17476,0,512,0,0,512,0,65434,34952,0,0,0,59008,8767,34,0,0,40960,36857,2184,0,0,0,65024,8195,2,0,0,0,0,16,0,0,0,16,0,13312,4607,273,0,256,0,2,0,26624,9214,546,62272,4383,17,0,16384,53248,18428,1092,0,0,0,0,0,0,0,0,512,0,0,0,0,16384,8179,4369,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_termparser","Expr","Form","Vars","Fact","Atom","ListExpr","let","in","rec","if","then","else","null","hd","tl","fst","snd","True","False","int","var","'->'","'&&'","'||'","not","'='","'=='","'<'","fun","'+'","'-'","'*'","'('","')'","'{'","'}'","'['","']'","','","%eof"]
        bit_start = st Prelude.* 43
        bit_end = (st Prelude.+ 1) Prelude.* 43
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..42]
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

action_2 (24) = happyShift action_37
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (43) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (26) = happyShift action_39
action_4 (27) = happyShift action_40
action_4 (30) = happyShift action_41
action_4 (31) = happyShift action_42
action_4 (33) = happyShift action_43
action_4 (34) = happyShift action_44
action_4 (35) = happyShift action_45
action_4 _ = happyReduce_6

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
action_5 (8) = happyGoto action_38
action_5 _ = happyReduce_15

action_6 _ = happyReduce_19

action_7 (12) = happyShift action_36
action_7 (24) = happyShift action_37
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (38) = happyShift action_35
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
action_9 (4) = happyGoto action_34
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
action_10 (8) = happyGoto action_33
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
action_11 (8) = happyGoto action_32
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
action_12 (8) = happyGoto action_31
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
action_13 (8) = happyGoto action_30
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
action_14 (8) = happyGoto action_29
action_14 _ = happyFail (happyExpListPerState 14)

action_15 _ = happyReduce_23

action_16 _ = happyReduce_24

action_17 _ = happyReduce_21

action_18 _ = happyReduce_22

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
action_19 (8) = happyGoto action_6
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
action_22 _ = happyReduce_32

action_23 (42) = happyShift action_62
action_23 _ = happyReduce_33

action_24 (41) = happyShift action_61
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (37) = happyShift action_59
action_25 (42) = happyShift action_60
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (25) = happyShift action_58
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (24) = happyShift action_27
action_27 (6) = happyGoto action_57
action_27 _ = happyReduce_16

action_28 (30) = happyShift action_41
action_28 (31) = happyShift action_42
action_28 (33) = happyShift action_43
action_28 (34) = happyShift action_44
action_28 (35) = happyShift action_45
action_28 _ = happyReduce_14

action_29 _ = happyReduce_26

action_30 _ = happyReduce_25

action_31 _ = happyReduce_28

action_32 _ = happyReduce_27

action_33 _ = happyReduce_29

action_34 (14) = happyShift action_56
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (24) = happyShift action_55
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (24) = happyShift action_54
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (29) = happyShift action_53
action_37 _ = happyFail (happyExpListPerState 37)

action_38 _ = happyReduce_18

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
action_39 (36) = happyShift action_21
action_39 (40) = happyShift action_22
action_39 (5) = happyGoto action_52
action_39 (7) = happyGoto action_5
action_39 (8) = happyGoto action_6
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (16) = happyShift action_10
action_40 (17) = happyShift action_11
action_40 (18) = happyShift action_12
action_40 (19) = happyShift action_13
action_40 (20) = happyShift action_14
action_40 (21) = happyShift action_15
action_40 (22) = happyShift action_16
action_40 (23) = happyShift action_17
action_40 (24) = happyShift action_18
action_40 (28) = happyShift action_19
action_40 (36) = happyShift action_21
action_40 (40) = happyShift action_22
action_40 (5) = happyGoto action_51
action_40 (7) = happyGoto action_5
action_40 (8) = happyGoto action_6
action_40 _ = happyFail (happyExpListPerState 40)

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
action_41 (5) = happyGoto action_50
action_41 (7) = happyGoto action_5
action_41 (8) = happyGoto action_6
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
action_42 (5) = happyGoto action_49
action_42 (7) = happyGoto action_5
action_42 (8) = happyGoto action_6
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
action_43 (5) = happyGoto action_48
action_43 (7) = happyGoto action_5
action_43 (8) = happyGoto action_6
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
action_44 (5) = happyGoto action_47
action_44 (7) = happyGoto action_5
action_44 (8) = happyGoto action_6
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
action_45 (5) = happyGoto action_46
action_45 (7) = happyGoto action_5
action_45 (8) = happyGoto action_6
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (35) = happyShift action_45
action_46 _ = happyReduce_9

action_47 (35) = happyShift action_45
action_47 _ = happyReduce_8

action_48 (35) = happyShift action_45
action_48 _ = happyReduce_7

action_49 (33) = happyShift action_43
action_49 (34) = happyShift action_44
action_49 (35) = happyShift action_45
action_49 _ = happyReduce_11

action_50 (33) = happyShift action_43
action_50 (34) = happyShift action_44
action_50 (35) = happyShift action_45
action_50 _ = happyReduce_10

action_51 (30) = happyShift action_41
action_51 (31) = happyShift action_42
action_51 (33) = happyShift action_43
action_51 (34) = happyShift action_44
action_51 (35) = happyShift action_45
action_51 _ = happyReduce_13

action_52 (30) = happyShift action_41
action_52 (31) = happyShift action_42
action_52 (33) = happyShift action_43
action_52 (34) = happyShift action_44
action_52 (35) = happyShift action_45
action_52 _ = happyReduce_12

action_53 (10) = happyShift action_7
action_53 (12) = happyShift action_8
action_53 (13) = happyShift action_9
action_53 (16) = happyShift action_10
action_53 (17) = happyShift action_11
action_53 (18) = happyShift action_12
action_53 (19) = happyShift action_13
action_53 (20) = happyShift action_14
action_53 (21) = happyShift action_15
action_53 (22) = happyShift action_16
action_53 (23) = happyShift action_17
action_53 (24) = happyShift action_18
action_53 (28) = happyShift action_19
action_53 (32) = happyShift action_20
action_53 (36) = happyShift action_21
action_53 (40) = happyShift action_22
action_53 (4) = happyGoto action_69
action_53 (5) = happyGoto action_4
action_53 (7) = happyGoto action_5
action_53 (8) = happyGoto action_6
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (24) = happyShift action_27
action_54 (6) = happyGoto action_68
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (29) = happyShift action_67
action_55 _ = happyFail (happyExpListPerState 55)

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
action_56 (4) = happyGoto action_66
action_56 (5) = happyGoto action_4
action_56 (7) = happyGoto action_5
action_56 (8) = happyGoto action_6
action_56 _ = happyFail (happyExpListPerState 56)

action_57 _ = happyReduce_17

action_58 (10) = happyShift action_7
action_58 (12) = happyShift action_8
action_58 (13) = happyShift action_9
action_58 (16) = happyShift action_10
action_58 (17) = happyShift action_11
action_58 (18) = happyShift action_12
action_58 (19) = happyShift action_13
action_58 (20) = happyShift action_14
action_58 (21) = happyShift action_15
action_58 (22) = happyShift action_16
action_58 (23) = happyShift action_17
action_58 (24) = happyShift action_18
action_58 (28) = happyShift action_19
action_58 (32) = happyShift action_20
action_58 (36) = happyShift action_21
action_58 (40) = happyShift action_22
action_58 (4) = happyGoto action_65
action_58 (5) = happyGoto action_4
action_58 (7) = happyGoto action_5
action_58 (8) = happyGoto action_6
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_20

action_60 (10) = happyShift action_7
action_60 (12) = happyShift action_8
action_60 (13) = happyShift action_9
action_60 (16) = happyShift action_10
action_60 (17) = happyShift action_11
action_60 (18) = happyShift action_12
action_60 (19) = happyShift action_13
action_60 (20) = happyShift action_14
action_60 (21) = happyShift action_15
action_60 (22) = happyShift action_16
action_60 (23) = happyShift action_17
action_60 (24) = happyShift action_18
action_60 (28) = happyShift action_19
action_60 (32) = happyShift action_20
action_60 (36) = happyShift action_21
action_60 (40) = happyShift action_22
action_60 (4) = happyGoto action_64
action_60 (5) = happyGoto action_4
action_60 (7) = happyGoto action_5
action_60 (8) = happyGoto action_6
action_60 _ = happyFail (happyExpListPerState 60)

action_61 _ = happyReduce_30

action_62 (16) = happyShift action_10
action_62 (17) = happyShift action_11
action_62 (18) = happyShift action_12
action_62 (19) = happyShift action_13
action_62 (20) = happyShift action_14
action_62 (21) = happyShift action_15
action_62 (22) = happyShift action_16
action_62 (23) = happyShift action_17
action_62 (24) = happyShift action_18
action_62 (36) = happyShift action_21
action_62 (40) = happyShift action_22
action_62 (8) = happyGoto action_23
action_62 (9) = happyGoto action_63
action_62 _ = happyReduce_32

action_63 _ = happyReduce_34

action_64 (37) = happyShift action_74
action_64 _ = happyFail (happyExpListPerState 64)

action_65 _ = happyReduce_3

action_66 (15) = happyShift action_73
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (10) = happyShift action_7
action_67 (12) = happyShift action_8
action_67 (13) = happyShift action_9
action_67 (16) = happyShift action_10
action_67 (17) = happyShift action_11
action_67 (18) = happyShift action_12
action_67 (19) = happyShift action_13
action_67 (20) = happyShift action_14
action_67 (21) = happyShift action_15
action_67 (22) = happyShift action_16
action_67 (23) = happyShift action_17
action_67 (24) = happyShift action_18
action_67 (28) = happyShift action_19
action_67 (32) = happyShift action_20
action_67 (36) = happyShift action_21
action_67 (40) = happyShift action_22
action_67 (4) = happyGoto action_72
action_67 (5) = happyGoto action_4
action_67 (7) = happyGoto action_5
action_67 (8) = happyGoto action_6
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (29) = happyShift action_71
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (11) = happyShift action_70
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
action_70 (4) = happyGoto action_78
action_70 (5) = happyGoto action_4
action_70 (7) = happyGoto action_5
action_70 (8) = happyGoto action_6
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (10) = happyShift action_7
action_71 (12) = happyShift action_8
action_71 (13) = happyShift action_9
action_71 (16) = happyShift action_10
action_71 (17) = happyShift action_11
action_71 (18) = happyShift action_12
action_71 (19) = happyShift action_13
action_71 (20) = happyShift action_14
action_71 (21) = happyShift action_15
action_71 (22) = happyShift action_16
action_71 (23) = happyShift action_17
action_71 (24) = happyShift action_18
action_71 (28) = happyShift action_19
action_71 (32) = happyShift action_20
action_71 (36) = happyShift action_21
action_71 (40) = happyShift action_22
action_71 (4) = happyGoto action_77
action_71 (5) = happyGoto action_4
action_71 (7) = happyGoto action_5
action_71 (8) = happyGoto action_6
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (39) = happyShift action_76
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
action_73 (4) = happyGoto action_75
action_73 (5) = happyGoto action_4
action_73 (7) = happyGoto action_5
action_73 (8) = happyGoto action_6
action_73 _ = happyFail (happyExpListPerState 73)

action_74 _ = happyReduce_31

action_75 _ = happyReduce_4

action_76 _ = happyReduce_5

action_77 (11) = happyShift action_79
action_77 _ = happyFail (happyExpListPerState 77)

action_78 _ = happyReduce_1

action_79 (10) = happyShift action_7
action_79 (12) = happyShift action_8
action_79 (13) = happyShift action_9
action_79 (16) = happyShift action_10
action_79 (17) = happyShift action_11
action_79 (18) = happyShift action_12
action_79 (19) = happyShift action_13
action_79 (20) = happyShift action_14
action_79 (21) = happyShift action_15
action_79 (22) = happyShift action_16
action_79 (23) = happyShift action_17
action_79 (24) = happyShift action_18
action_79 (28) = happyShift action_19
action_79 (32) = happyShift action_20
action_79 (36) = happyShift action_21
action_79 (40) = happyShift action_22
action_79 (4) = happyGoto action_80
action_79 (5) = happyGoto action_4
action_79 (7) = happyGoto action_5
action_79 (8) = happyGoto action_6
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_2

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

happyReduce_5 = happyReduce 6 4 happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSym happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (TmRec happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_1  4 happyReduction_6
happyReduction_6 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  5 happyReduction_7
happyReduction_7 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Plus) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  5 happyReduction_8
happyReduction_8 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Minus) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  5 happyReduction_9
happyReduction_9 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Times) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  5 happyReduction_10
happyReduction_10 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Equiv) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  5 happyReduction_11
happyReduction_11 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Lt) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  5 happyReduction_12
happyReduction_12 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst And) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  5 happyReduction_13
happyReduction_13 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Or) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_2  5 happyReduction_14
happyReduction_14 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (TmApp (TmConst Not) happy_var_2
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  5 happyReduction_15
happyReduction_15 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  6 happyReduction_16
happyReduction_16 (HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_2  6 happyReduction_17
happyReduction_17 (HappyAbsSyn6  happy_var_2)
	(HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn6
		 (happy_var_1:happy_var_2
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_2  7 happyReduction_18
happyReduction_18 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (TmApp happy_var_1 happy_var_2
	)
happyReduction_18 _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  7 happyReduction_19
happyReduction_19 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  8 happyReduction_20
happyReduction_20 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  8 happyReduction_21
happyReduction_21 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn8
		 (TmLit (LInt happy_var_1)
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  8 happyReduction_22
happyReduction_22 (HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn8
		 (TmVar happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  8 happyReduction_23
happyReduction_23 _
	 =  HappyAbsSyn8
		 (TmLit (LBool True)
	)

happyReduce_24 = happySpecReduce_1  8 happyReduction_24
happyReduction_24 _
	 =  HappyAbsSyn8
		 (TmLit (LBool False)
	)

happyReduce_25 = happySpecReduce_2  8 happyReduction_25
happyReduction_25 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Fst) happy_var_2
	)
happyReduction_25 _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_2  8 happyReduction_26
happyReduction_26 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Snd) happy_var_2
	)
happyReduction_26 _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_2  8 happyReduction_27
happyReduction_27 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Hd) happy_var_2
	)
happyReduction_27 _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_2  8 happyReduction_28
happyReduction_28 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Tl) happy_var_2
	)
happyReduction_28 _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_2  8 happyReduction_29
happyReduction_29 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Null) happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  8 happyReduction_30
happyReduction_30 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happyReduce 5 8 happyReduction_31
happyReduction_31 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (TmApp (TmApp (TmConst Pair) happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_32 = happySpecReduce_0  9 happyReduction_32
happyReduction_32  =  HappyAbsSyn9
		 (TmConst Nil
	)

happyReduce_33 = happySpecReduce_1  9 happyReduction_33
happyReduction_33 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 (TmApp(TmApp (TmConst Cons) happy_var_1) (TmConst Nil)
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  9 happyReduction_34
happyReduction_34 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 (TmApp (TmApp (TmConst Cons) happy_var_1) happy_var_3
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	TokenEOF -> action 43 43 tk (HappyState action) sts stk;
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
	_ -> happyError' (tk, [])
	})

happyError_ explist 43 tk = happyError' (tk, explist)
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
