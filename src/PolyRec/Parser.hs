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
happyExpList = Happy_Data_Array.listArray (0,180) ([39424,17535,68,8,0,0,1024,0,0,0,0,0,947,0,510,272,0,0,0,0,1024,39424,17535,68,65024,4097,1,2040,1088,57344,31,17,32640,17408,0,0,0,0,0,0,0,0,0,0,0,65024,4113,1,1024,0,59008,4383,17,32640,17408,0,0,1024,0,0,8,0,16896,0,128,0,0,1,0,0,59,0,0,0,0,0,0,0,0,0,0,0,8,0,0,64,0,0,0,0,18424,1088,57344,287,17,32640,17412,0,4606,272,63488,16455,4,8160,4353,32768,1151,68,0,32,40960,18425,1092,0,32768,0,0,512,0,0,8,0,14336,0,0,224,0,45056,3,0,3776,0,32768,0,59008,4383,17,0,0,26624,4606,273,0,0,32768,8166,4369,0,0,0,65024,4097,1,0,0,0,0,2,0,0,0,1,0,63904,17479,4,1,0,39424,17535,68,0,32768,40960,18425,1092,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_termparser","Expr","Form","Vars","Fact","Atom","ListExpr","let","in","rec","if","then","else","hd","tl","fst","snd","True","False","int","var","'->'","'&&'","'||'","not","'='","'=='","'<'","fun","'+'","'-'","'*'","'('","')'","'{'","'}'","'['","']'","','","%eof"]
        bit_start = st Prelude.* 42
        bit_end = (st Prelude.+ 1) Prelude.* 42
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..41]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (10) = happyShift action_2
action_0 (12) = happyShift action_7
action_0 (13) = happyShift action_8
action_0 (16) = happyShift action_9
action_0 (17) = happyShift action_10
action_0 (18) = happyShift action_11
action_0 (19) = happyShift action_12
action_0 (20) = happyShift action_13
action_0 (21) = happyShift action_14
action_0 (22) = happyShift action_15
action_0 (23) = happyShift action_16
action_0 (27) = happyShift action_17
action_0 (31) = happyShift action_18
action_0 (35) = happyShift action_19
action_0 (39) = happyShift action_20
action_0 (4) = happyGoto action_3
action_0 (5) = happyGoto action_4
action_0 (7) = happyGoto action_5
action_0 (8) = happyGoto action_6
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (10) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (23) = happyShift action_41
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (42) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (25) = happyShift action_34
action_4 (26) = happyShift action_35
action_4 (29) = happyShift action_36
action_4 (30) = happyShift action_37
action_4 (32) = happyShift action_38
action_4 (33) = happyShift action_39
action_4 (34) = happyShift action_40
action_4 _ = happyReduce_5

action_5 (16) = happyShift action_9
action_5 (17) = happyShift action_10
action_5 (18) = happyShift action_11
action_5 (19) = happyShift action_12
action_5 (20) = happyShift action_13
action_5 (21) = happyShift action_14
action_5 (22) = happyShift action_15
action_5 (23) = happyShift action_16
action_5 (35) = happyShift action_19
action_5 (39) = happyShift action_20
action_5 (8) = happyGoto action_33
action_5 _ = happyReduce_14

action_6 _ = happyReduce_18

action_7 (37) = happyShift action_32
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (10) = happyShift action_2
action_8 (12) = happyShift action_7
action_8 (13) = happyShift action_8
action_8 (16) = happyShift action_9
action_8 (17) = happyShift action_10
action_8 (18) = happyShift action_11
action_8 (19) = happyShift action_12
action_8 (20) = happyShift action_13
action_8 (21) = happyShift action_14
action_8 (22) = happyShift action_15
action_8 (23) = happyShift action_16
action_8 (27) = happyShift action_17
action_8 (31) = happyShift action_18
action_8 (35) = happyShift action_19
action_8 (39) = happyShift action_20
action_8 (4) = happyGoto action_31
action_8 (5) = happyGoto action_4
action_8 (7) = happyGoto action_5
action_8 (8) = happyGoto action_6
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (16) = happyShift action_9
action_9 (17) = happyShift action_10
action_9 (18) = happyShift action_11
action_9 (19) = happyShift action_12
action_9 (20) = happyShift action_13
action_9 (21) = happyShift action_14
action_9 (22) = happyShift action_15
action_9 (23) = happyShift action_16
action_9 (35) = happyShift action_19
action_9 (39) = happyShift action_20
action_9 (8) = happyGoto action_30
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (16) = happyShift action_9
action_10 (17) = happyShift action_10
action_10 (18) = happyShift action_11
action_10 (19) = happyShift action_12
action_10 (20) = happyShift action_13
action_10 (21) = happyShift action_14
action_10 (22) = happyShift action_15
action_10 (23) = happyShift action_16
action_10 (35) = happyShift action_19
action_10 (39) = happyShift action_20
action_10 (8) = happyGoto action_29
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (16) = happyShift action_9
action_11 (17) = happyShift action_10
action_11 (18) = happyShift action_11
action_11 (19) = happyShift action_12
action_11 (20) = happyShift action_13
action_11 (21) = happyShift action_14
action_11 (22) = happyShift action_15
action_11 (23) = happyShift action_16
action_11 (35) = happyShift action_19
action_11 (39) = happyShift action_20
action_11 (8) = happyGoto action_28
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (16) = happyShift action_9
action_12 (17) = happyShift action_10
action_12 (18) = happyShift action_11
action_12 (19) = happyShift action_12
action_12 (20) = happyShift action_13
action_12 (21) = happyShift action_14
action_12 (22) = happyShift action_15
action_12 (23) = happyShift action_16
action_12 (35) = happyShift action_19
action_12 (39) = happyShift action_20
action_12 (8) = happyGoto action_27
action_12 _ = happyFail (happyExpListPerState 12)

action_13 _ = happyReduce_22

action_14 _ = happyReduce_23

action_15 _ = happyReduce_20

action_16 _ = happyReduce_21

action_17 (16) = happyShift action_9
action_17 (17) = happyShift action_10
action_17 (18) = happyShift action_11
action_17 (19) = happyShift action_12
action_17 (20) = happyShift action_13
action_17 (21) = happyShift action_14
action_17 (22) = happyShift action_15
action_17 (23) = happyShift action_16
action_17 (27) = happyShift action_17
action_17 (35) = happyShift action_19
action_17 (39) = happyShift action_20
action_17 (5) = happyGoto action_26
action_17 (7) = happyGoto action_5
action_17 (8) = happyGoto action_6
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (23) = happyShift action_25
action_18 (6) = happyGoto action_24
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (10) = happyShift action_2
action_19 (12) = happyShift action_7
action_19 (13) = happyShift action_8
action_19 (16) = happyShift action_9
action_19 (17) = happyShift action_10
action_19 (18) = happyShift action_11
action_19 (19) = happyShift action_12
action_19 (20) = happyShift action_13
action_19 (21) = happyShift action_14
action_19 (22) = happyShift action_15
action_19 (23) = happyShift action_16
action_19 (27) = happyShift action_17
action_19 (31) = happyShift action_18
action_19 (35) = happyShift action_19
action_19 (39) = happyShift action_20
action_19 (4) = happyGoto action_23
action_19 (5) = happyGoto action_4
action_19 (7) = happyGoto action_5
action_19 (8) = happyGoto action_6
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (16) = happyShift action_9
action_20 (17) = happyShift action_10
action_20 (18) = happyShift action_11
action_20 (19) = happyShift action_12
action_20 (20) = happyShift action_13
action_20 (21) = happyShift action_14
action_20 (22) = happyShift action_15
action_20 (23) = happyShift action_16
action_20 (35) = happyShift action_19
action_20 (39) = happyShift action_20
action_20 (8) = happyGoto action_21
action_20 (9) = happyGoto action_22
action_20 _ = happyReduce_30

action_21 (41) = happyShift action_57
action_21 _ = happyReduce_31

action_22 (40) = happyShift action_56
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (36) = happyShift action_54
action_23 (41) = happyShift action_55
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (24) = happyShift action_53
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (23) = happyShift action_25
action_25 (6) = happyGoto action_52
action_25 _ = happyReduce_15

action_26 (29) = happyShift action_36
action_26 (30) = happyShift action_37
action_26 (32) = happyShift action_38
action_26 (33) = happyShift action_39
action_26 (34) = happyShift action_40
action_26 _ = happyReduce_13

action_27 _ = happyReduce_25

action_28 _ = happyReduce_24

action_29 _ = happyReduce_27

action_30 _ = happyReduce_26

action_31 (14) = happyShift action_51
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (23) = happyShift action_50
action_32 _ = happyFail (happyExpListPerState 32)

action_33 _ = happyReduce_17

action_34 (16) = happyShift action_9
action_34 (17) = happyShift action_10
action_34 (18) = happyShift action_11
action_34 (19) = happyShift action_12
action_34 (20) = happyShift action_13
action_34 (21) = happyShift action_14
action_34 (22) = happyShift action_15
action_34 (23) = happyShift action_16
action_34 (27) = happyShift action_17
action_34 (35) = happyShift action_19
action_34 (39) = happyShift action_20
action_34 (5) = happyGoto action_49
action_34 (7) = happyGoto action_5
action_34 (8) = happyGoto action_6
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (16) = happyShift action_9
action_35 (17) = happyShift action_10
action_35 (18) = happyShift action_11
action_35 (19) = happyShift action_12
action_35 (20) = happyShift action_13
action_35 (21) = happyShift action_14
action_35 (22) = happyShift action_15
action_35 (23) = happyShift action_16
action_35 (27) = happyShift action_17
action_35 (35) = happyShift action_19
action_35 (39) = happyShift action_20
action_35 (5) = happyGoto action_48
action_35 (7) = happyGoto action_5
action_35 (8) = happyGoto action_6
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (16) = happyShift action_9
action_36 (17) = happyShift action_10
action_36 (18) = happyShift action_11
action_36 (19) = happyShift action_12
action_36 (20) = happyShift action_13
action_36 (21) = happyShift action_14
action_36 (22) = happyShift action_15
action_36 (23) = happyShift action_16
action_36 (27) = happyShift action_17
action_36 (35) = happyShift action_19
action_36 (39) = happyShift action_20
action_36 (5) = happyGoto action_47
action_36 (7) = happyGoto action_5
action_36 (8) = happyGoto action_6
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (16) = happyShift action_9
action_37 (17) = happyShift action_10
action_37 (18) = happyShift action_11
action_37 (19) = happyShift action_12
action_37 (20) = happyShift action_13
action_37 (21) = happyShift action_14
action_37 (22) = happyShift action_15
action_37 (23) = happyShift action_16
action_37 (27) = happyShift action_17
action_37 (35) = happyShift action_19
action_37 (39) = happyShift action_20
action_37 (5) = happyGoto action_46
action_37 (7) = happyGoto action_5
action_37 (8) = happyGoto action_6
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (16) = happyShift action_9
action_38 (17) = happyShift action_10
action_38 (18) = happyShift action_11
action_38 (19) = happyShift action_12
action_38 (20) = happyShift action_13
action_38 (21) = happyShift action_14
action_38 (22) = happyShift action_15
action_38 (23) = happyShift action_16
action_38 (27) = happyShift action_17
action_38 (35) = happyShift action_19
action_38 (39) = happyShift action_20
action_38 (5) = happyGoto action_45
action_38 (7) = happyGoto action_5
action_38 (8) = happyGoto action_6
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (16) = happyShift action_9
action_39 (17) = happyShift action_10
action_39 (18) = happyShift action_11
action_39 (19) = happyShift action_12
action_39 (20) = happyShift action_13
action_39 (21) = happyShift action_14
action_39 (22) = happyShift action_15
action_39 (23) = happyShift action_16
action_39 (27) = happyShift action_17
action_39 (35) = happyShift action_19
action_39 (39) = happyShift action_20
action_39 (5) = happyGoto action_44
action_39 (7) = happyGoto action_5
action_39 (8) = happyGoto action_6
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (16) = happyShift action_9
action_40 (17) = happyShift action_10
action_40 (18) = happyShift action_11
action_40 (19) = happyShift action_12
action_40 (20) = happyShift action_13
action_40 (21) = happyShift action_14
action_40 (22) = happyShift action_15
action_40 (23) = happyShift action_16
action_40 (27) = happyShift action_17
action_40 (35) = happyShift action_19
action_40 (39) = happyShift action_20
action_40 (5) = happyGoto action_43
action_40 (7) = happyGoto action_5
action_40 (8) = happyGoto action_6
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (28) = happyShift action_42
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (10) = happyShift action_2
action_42 (12) = happyShift action_7
action_42 (13) = happyShift action_8
action_42 (16) = happyShift action_9
action_42 (17) = happyShift action_10
action_42 (18) = happyShift action_11
action_42 (19) = happyShift action_12
action_42 (20) = happyShift action_13
action_42 (21) = happyShift action_14
action_42 (22) = happyShift action_15
action_42 (23) = happyShift action_16
action_42 (27) = happyShift action_17
action_42 (31) = happyShift action_18
action_42 (35) = happyShift action_19
action_42 (39) = happyShift action_20
action_42 (4) = happyGoto action_63
action_42 (5) = happyGoto action_4
action_42 (7) = happyGoto action_5
action_42 (8) = happyGoto action_6
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (34) = happyShift action_40
action_43 _ = happyReduce_8

action_44 (34) = happyShift action_40
action_44 _ = happyReduce_7

action_45 (34) = happyShift action_40
action_45 _ = happyReduce_6

action_46 (32) = happyShift action_38
action_46 (33) = happyShift action_39
action_46 (34) = happyShift action_40
action_46 _ = happyReduce_10

action_47 (32) = happyShift action_38
action_47 (33) = happyShift action_39
action_47 (34) = happyShift action_40
action_47 _ = happyReduce_9

action_48 (29) = happyShift action_36
action_48 (30) = happyShift action_37
action_48 (32) = happyShift action_38
action_48 (33) = happyShift action_39
action_48 (34) = happyShift action_40
action_48 _ = happyReduce_12

action_49 (29) = happyShift action_36
action_49 (30) = happyShift action_37
action_49 (32) = happyShift action_38
action_49 (33) = happyShift action_39
action_49 (34) = happyShift action_40
action_49 _ = happyReduce_11

action_50 (28) = happyShift action_62
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (10) = happyShift action_2
action_51 (12) = happyShift action_7
action_51 (13) = happyShift action_8
action_51 (16) = happyShift action_9
action_51 (17) = happyShift action_10
action_51 (18) = happyShift action_11
action_51 (19) = happyShift action_12
action_51 (20) = happyShift action_13
action_51 (21) = happyShift action_14
action_51 (22) = happyShift action_15
action_51 (23) = happyShift action_16
action_51 (27) = happyShift action_17
action_51 (31) = happyShift action_18
action_51 (35) = happyShift action_19
action_51 (39) = happyShift action_20
action_51 (4) = happyGoto action_61
action_51 (5) = happyGoto action_4
action_51 (7) = happyGoto action_5
action_51 (8) = happyGoto action_6
action_51 _ = happyFail (happyExpListPerState 51)

action_52 _ = happyReduce_16

action_53 (10) = happyShift action_2
action_53 (12) = happyShift action_7
action_53 (13) = happyShift action_8
action_53 (16) = happyShift action_9
action_53 (17) = happyShift action_10
action_53 (18) = happyShift action_11
action_53 (19) = happyShift action_12
action_53 (20) = happyShift action_13
action_53 (21) = happyShift action_14
action_53 (22) = happyShift action_15
action_53 (23) = happyShift action_16
action_53 (27) = happyShift action_17
action_53 (31) = happyShift action_18
action_53 (35) = happyShift action_19
action_53 (39) = happyShift action_20
action_53 (4) = happyGoto action_60
action_53 (5) = happyGoto action_4
action_53 (7) = happyGoto action_5
action_53 (8) = happyGoto action_6
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_19

action_55 (10) = happyShift action_2
action_55 (12) = happyShift action_7
action_55 (13) = happyShift action_8
action_55 (16) = happyShift action_9
action_55 (17) = happyShift action_10
action_55 (18) = happyShift action_11
action_55 (19) = happyShift action_12
action_55 (20) = happyShift action_13
action_55 (21) = happyShift action_14
action_55 (22) = happyShift action_15
action_55 (23) = happyShift action_16
action_55 (27) = happyShift action_17
action_55 (31) = happyShift action_18
action_55 (35) = happyShift action_19
action_55 (39) = happyShift action_20
action_55 (4) = happyGoto action_59
action_55 (5) = happyGoto action_4
action_55 (7) = happyGoto action_5
action_55 (8) = happyGoto action_6
action_55 _ = happyFail (happyExpListPerState 55)

action_56 _ = happyReduce_28

action_57 (16) = happyShift action_9
action_57 (17) = happyShift action_10
action_57 (18) = happyShift action_11
action_57 (19) = happyShift action_12
action_57 (20) = happyShift action_13
action_57 (21) = happyShift action_14
action_57 (22) = happyShift action_15
action_57 (23) = happyShift action_16
action_57 (35) = happyShift action_19
action_57 (39) = happyShift action_20
action_57 (8) = happyGoto action_21
action_57 (9) = happyGoto action_58
action_57 _ = happyReduce_30

action_58 _ = happyReduce_32

action_59 (36) = happyShift action_67
action_59 _ = happyFail (happyExpListPerState 59)

action_60 _ = happyReduce_2

action_61 (15) = happyShift action_66
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (10) = happyShift action_2
action_62 (12) = happyShift action_7
action_62 (13) = happyShift action_8
action_62 (16) = happyShift action_9
action_62 (17) = happyShift action_10
action_62 (18) = happyShift action_11
action_62 (19) = happyShift action_12
action_62 (20) = happyShift action_13
action_62 (21) = happyShift action_14
action_62 (22) = happyShift action_15
action_62 (23) = happyShift action_16
action_62 (27) = happyShift action_17
action_62 (31) = happyShift action_18
action_62 (35) = happyShift action_19
action_62 (39) = happyShift action_20
action_62 (4) = happyGoto action_65
action_62 (5) = happyGoto action_4
action_62 (7) = happyGoto action_5
action_62 (8) = happyGoto action_6
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (11) = happyShift action_64
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (10) = happyShift action_2
action_64 (12) = happyShift action_7
action_64 (13) = happyShift action_8
action_64 (16) = happyShift action_9
action_64 (17) = happyShift action_10
action_64 (18) = happyShift action_11
action_64 (19) = happyShift action_12
action_64 (20) = happyShift action_13
action_64 (21) = happyShift action_14
action_64 (22) = happyShift action_15
action_64 (23) = happyShift action_16
action_64 (27) = happyShift action_17
action_64 (31) = happyShift action_18
action_64 (35) = happyShift action_19
action_64 (39) = happyShift action_20
action_64 (4) = happyGoto action_70
action_64 (5) = happyGoto action_4
action_64 (7) = happyGoto action_5
action_64 (8) = happyGoto action_6
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (38) = happyShift action_69
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (10) = happyShift action_2
action_66 (12) = happyShift action_7
action_66 (13) = happyShift action_8
action_66 (16) = happyShift action_9
action_66 (17) = happyShift action_10
action_66 (18) = happyShift action_11
action_66 (19) = happyShift action_12
action_66 (20) = happyShift action_13
action_66 (21) = happyShift action_14
action_66 (22) = happyShift action_15
action_66 (23) = happyShift action_16
action_66 (27) = happyShift action_17
action_66 (31) = happyShift action_18
action_66 (35) = happyShift action_19
action_66 (39) = happyShift action_20
action_66 (4) = happyGoto action_68
action_66 (5) = happyGoto action_4
action_66 (7) = happyGoto action_5
action_66 (8) = happyGoto action_6
action_66 _ = happyFail (happyExpListPerState 66)

action_67 _ = happyReduce_29

action_68 _ = happyReduce_3

action_69 _ = happyReduce_4

action_70 _ = happyReduce_1

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

happyReduce_2 = happyReduce 4 4 happyReduction_2
happyReduction_2 ((HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (foldr (\x e -> TmAbs x e) happy_var_4 happy_var_2
	) `HappyStk` happyRest

happyReduce_3 = happyReduce 6 4 happyReduction_3
happyReduction_3 ((HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (TmApp (TmApp (TmApp (TmConst Ifc) happy_var_2) happy_var_4) happy_var_6
	) `HappyStk` happyRest

happyReduce_4 = happyReduce 6 4 happyReduction_4
happyReduction_4 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSym happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (TmRec happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_5 = happySpecReduce_1  4 happyReduction_5
happyReduction_5 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_3  5 happyReduction_6
happyReduction_6 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Plus) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  5 happyReduction_7
happyReduction_7 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Minus) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  5 happyReduction_8
happyReduction_8 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Times) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  5 happyReduction_9
happyReduction_9 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Equiv) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  5 happyReduction_10
happyReduction_10 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Lt) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  5 happyReduction_11
happyReduction_11 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst And) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  5 happyReduction_12
happyReduction_12 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (TmApp (TmConst Or) (TmApp (TmApp (TmConst Pair) happy_var_1) happy_var_3)
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_2  5 happyReduction_13
happyReduction_13 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (TmApp (TmConst Not) happy_var_2
	)
happyReduction_13 _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  5 happyReduction_14
happyReduction_14 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  6 happyReduction_15
happyReduction_15 (HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2  6 happyReduction_16
happyReduction_16 (HappyAbsSyn6  happy_var_2)
	(HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn6
		 (happy_var_1:happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_2  7 happyReduction_17
happyReduction_17 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (TmApp happy_var_1 happy_var_2
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  7 happyReduction_18
happyReduction_18 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  8 happyReduction_19
happyReduction_19 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  8 happyReduction_20
happyReduction_20 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn8
		 (TmLit (LInt happy_var_1)
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  8 happyReduction_21
happyReduction_21 (HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn8
		 (TmVar happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  8 happyReduction_22
happyReduction_22 _
	 =  HappyAbsSyn8
		 (TmLit (LBool True)
	)

happyReduce_23 = happySpecReduce_1  8 happyReduction_23
happyReduction_23 _
	 =  HappyAbsSyn8
		 (TmLit (LBool False)
	)

happyReduce_24 = happySpecReduce_2  8 happyReduction_24
happyReduction_24 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Fst) happy_var_2
	)
happyReduction_24 _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_2  8 happyReduction_25
happyReduction_25 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Snd) happy_var_2
	)
happyReduction_25 _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_2  8 happyReduction_26
happyReduction_26 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Hd) happy_var_2
	)
happyReduction_26 _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_2  8 happyReduction_27
happyReduction_27 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (TmApp (TmConst Tl) happy_var_2
	)
happyReduction_27 _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  8 happyReduction_28
happyReduction_28 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happyReduce 5 8 happyReduction_29
happyReduction_29 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (TmApp (TmApp (TmConst Pair) happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_30 = happySpecReduce_0  9 happyReduction_30
happyReduction_30  =  HappyAbsSyn9
		 (TmConst Nil
	)

happyReduce_31 = happySpecReduce_1  9 happyReduction_31
happyReduction_31 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 (TmApp(TmApp (TmConst Cons) happy_var_1) (TmConst Nil)
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  9 happyReduction_32
happyReduction_32 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 (TmApp (TmApp (TmConst Cons) happy_var_1) happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	TokenEOF -> action 42 42 tk (HappyState action) sts stk;
	TokenLet -> cont 10;
	TokenIn -> cont 11;
	TokenRec -> cont 12;
	TokenIf -> cont 13;
	TokenThen -> cont 14;
	TokenElse -> cont 15;
	TokenHd -> cont 16;
	TokenTl -> cont 17;
	TokenFst -> cont 18;
	TokenSnd -> cont 19;
	TokenTrue -> cont 20;
	TokenFalse -> cont 21;
	TokenInt happy_dollar_dollar -> cont 22;
	TokenSym happy_dollar_dollar -> cont 23;
	TokenArrow -> cont 24;
	TokenAnd -> cont 25;
	TokenOr -> cont 26;
	TokenNot -> cont 27;
	TokenEq -> cont 28;
	TokenEquiv -> cont 29;
	TokenLt -> cont 30;
	TokenLam -> cont 31;
	TokenAdd -> cont 32;
	TokenSub -> cont 33;
	TokenMul -> cont 34;
	TokenLParen -> cont 35;
	TokenRParen -> cont 36;
	TokenLBrace -> cont 37;
	TokenRBrace -> cont 38;
	TokenLSqBrack -> cont 39;
	TokenRSqBrack -> cont 40;
	TokenComma -> cont 41;
	_ -> happyError' (tk, [])
	})

happyError_ explist 42 tk = happyError' (tk, explist)
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
