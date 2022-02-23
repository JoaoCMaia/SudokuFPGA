----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2022 06:20:18
-- Design Name: 
-- Module Name: NumberGen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-----Image generator:-------------------------------------------------
 LIBRARY ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
 ----------------------------------------------------------------------
 ENTITY NumberGen IS
     PORT (
         clk : in  STD_LOGIC;
         rst: in STD_LOGIC;         
         colorOutNumber : out  STD_LOGIC_VECTOR(11 DOWNTO 0);
         current_x: in STD_LOGIC_VECTOR(9 downto 0);
         current_y: in STD_LOGIC_VECTOR(9 downto 0);
         win: out std_logic;
         ---------------
         lvl: in std_logic;
         autocorrect: in std_logic;
         update: in std_logic;
         num: in std_logic_vector(3 downto 0);
         row: in std_logic_vector(3 downto 0);
         col: in std_logic_vector(3 downto 0)
 );
 END NumberGen;
 ----------------------------------------------------------------------
 ARCHITECTURE Behavioral OF NumberGen IS

     -- Sync related
    signal colorOut : STD_LOGIC_VECTOR(11 DOWNTO 0);
    signal clNum: std_logic_vector(3 downto 0):= "1111";
     ---Type/signal/constant declarations:---         
    TYPE digit18x24 IS ARRAY (1 TO 24, 1 TO 18) OF STD_LOGIC;
    SIGNAL
    digit_11,digit_12, digit_13, digit_14, digit_15, digit_16, digit_17, digit_18, digit_19,
    digit_21,digit_22, digit_23, digit_24, digit_25, digit_26, digit_27, digit_28, digit_29,
    digit_31,digit_32, digit_33, digit_34, digit_35, digit_36, digit_37, digit_38, digit_39,
    digit_41,digit_42, digit_43, digit_44, digit_45, digit_46, digit_47, digit_48, digit_49,
    digit_51,digit_52, digit_53, digit_54, digit_55, digit_56, digit_57, digit_58, digit_59,
    digit_61,digit_62, digit_63, digit_64, digit_65, digit_66, digit_67, digit_68, digit_69,
    digit_71,digit_72, digit_73, digit_74, digit_75, digit_76, digit_77, digit_78, digit_79,
    digit_81,digit_82, digit_83, digit_84, digit_85, digit_86, digit_87, digit_88, digit_89,
    digit_91,digit_92, digit_93, digit_94, digit_95, digit_96, digit_97, digit_98, digit_99,
    digit_11a,digit_12a, digit_13a, digit_14a, digit_15a, digit_16a, digit_17a, digit_18a, digit_19a,
    digit_21a,digit_22a, digit_23a, digit_24a, digit_25a, digit_26a, digit_27a, digit_28a, digit_29a,
    digit_31a,digit_32a, digit_33a, digit_34a, digit_35a, digit_36a, digit_37a, digit_38a, digit_39a,
    digit_41a,digit_42a, digit_43a, digit_44a, digit_45a, digit_46a, digit_47a, digit_48a, digit_49a,
    digit_51a,digit_52a, digit_53a, digit_54a, digit_55a, digit_56a, digit_57a, digit_58a, digit_59a,
    digit_61a,digit_62a, digit_63a, digit_64a, digit_65a, digit_66a, digit_67a, digit_68a, digit_69a,
    digit_71a,digit_72a, digit_73a, digit_74a, digit_75a, digit_76a, digit_77a, digit_78a, digit_79a,
    digit_81a,digit_82a, digit_83a, digit_84a, digit_85a, digit_86a, digit_87a, digit_88a, digit_89a,
    digit_91a,digit_92a, digit_93a, digit_94a, digit_95a, digit_96a, digit_97a, digit_98a, digit_99a: std_logic_vector(3 downto 0);
    
    constant DIGITHIGH: natural:=23;
    constant DIGITLENGHT: natural:=17;
    constant SPACEUP: natural:=6;
    constant SPACELEFT: natural:=9;
     
    CONSTANT one: digit18x24 := (
	    ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
	    ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','1','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0'),
        ('0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'));
        
    CONSTANT two: digit18x24 := (
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'));    
    CONSTANT three: digit18x24 := (
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'));
    CONSTANT four: digit18x24 := (
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),        
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')); 
    CONSTANT five: digit18x24 := (
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'));
    CONSTANT six: digit18x24 := (
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'));
    CONSTANT seven: digit18x24 := (
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'));
    CONSTANT eight: digit18x24 := (
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'));  
    CONSTANT nine: digit18x24 := (
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')); 
    CONSTANT noNum: digit18x24 := (
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
        ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')); 

---Function construction:----------------
     FUNCTION bcd_to_digit6x8 (SIGNAL input: std_logic_vector(3 downto 0)) RETURN digit18x24 IS
     BEGIN

         CASE input IS
             WHEN "0001" => return one;
             WHEN "0010" => return two;
             WHEN "0011" => return three;
             WHEN "0100" => return four;
             WHEN "0101" => return five;
             WHEN "0110" => return six;
             WHEN "0111" => return seven;
             WHEN "1000" => return eight;
             WHEN "1001" => return nine;
             when others => return noNum;
         END CASE;
     END bcd_to_digit6x8;
    -------------------------------------------
 BEGIN
colorOutNumber<=colorOut;
DISPLAY:process(current_x, current_y, num, rst, row, col, lvl,
                digit_11,digit_12, digit_13, digit_14, digit_15, digit_16, digit_17, digit_18, digit_19,
                digit_21,digit_22, digit_23, digit_24, digit_25, digit_26, digit_27, digit_28, digit_29,
                digit_31,digit_32, digit_33, digit_34, digit_35, digit_36, digit_37, digit_38, digit_39,
                digit_41,digit_42, digit_43, digit_44, digit_45, digit_46, digit_47, digit_48, digit_49,
                digit_51,digit_52, digit_53, digit_54, digit_55, digit_56, digit_57, digit_58, digit_59,
                digit_61,digit_62, digit_63, digit_64, digit_65, digit_66, digit_67, digit_68, digit_69,
                digit_71,digit_72, digit_73, digit_74, digit_75, digit_76, digit_77, digit_78, digit_79,
                digit_81,digit_82, digit_83, digit_84, digit_85, digit_86, digit_87, digit_88, digit_89,
                digit_91,digit_92, digit_93, digit_94, digit_95, digit_96, digit_97, digit_98, digit_99
                )
 
     BEGIN
     
     ---Make BCD to digit6x8 conversion:----
     colorOut(7 downto 4) <= (others =>'0');
     colorOut(3 downto 0) <= (OTHERS => '0');
     colorOut(11 downto 8)<= (OTHERS => '0');    
     
    if(rst='0')then
            ---Create image (w/ digits in red):----
            --Primeira Linha
            IF (current_x >= (x"7C"+SPACELEFT) AND current_x < (x"7C"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <= (OTHERS => bcd_to_digit6x8(digit_11)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"7C"+SPACELEFT))))); 
            elsIF (current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_12)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));     
            elsIF (lvl='0' and current_x >= (x"D4"+SPACELEFT) AND current_x < (x"D4"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_13)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"D4"+SPACELEFT)))));
            elsIF (lvl='1' and current_x >= (x"D4"+SPACELEFT) AND current_x < (x"D4"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_13)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"D4"+SPACELEFT)))));        
            elsIF (lvl = '0' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_14)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));
	    elsIF (lvl = '1' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_14)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));          
            elsIF (lvl = '0' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_15)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));
            elsIF (lvl = '1' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_15)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT))))); 				
            elsIF (lvl='1' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_16)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
            elsif(lvl='0' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_16)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
            elsIF (current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_17)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));     
            elsIF (lvl='1' and current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_18)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));     
            elsif(lvl='0' and current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_18)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));
            elsIF (lvl='1' and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_19)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));     
            elsif(lvl='0' and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"35"+SPACEUP) AND current_y < (x"35"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_19)(to_Integer(UNSIGNED(current_y-(x"35"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));

            --Segunda Linha
            elsif (current_x >= (x"7C"+SPACELEFT) AND current_x < (x"7C"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <= (OTHERS => bcd_to_digit6x8(digit_21)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"7C"+SPACELEFT))))); 
            elsIF (lvl='1' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_22)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));     
            elsif(lvl='0'and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_22)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));
            elsIF (current_x >= (x"D4"+SPACELEFT) AND current_x < (x"D4"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_23)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"D4"+SPACELEFT)))));     
            elsIF (lvl='1' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_24)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));     
            elsif(lvl='0' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_24)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT))))); 
            elsIF (lvl='1' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_25)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));     
            elsif(lvl='0' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH))then
                    colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_25)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));
            elsIF (lvl = '0' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_26)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_26)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
            elsIF (lvl = '0' and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_27)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_27)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));				
            elsIF (current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_28)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));     
            elsIF (lvl='1' and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_29)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));				
            elsif(lvl='0' and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"5E"+SPACEUP) AND current_y < (x"5E"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_29)(to_Integer(UNSIGNED(current_y-(x"5E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT))))); 
            --terceira Linha
            elsif (lvl = '0' and current_x >= (x"7C"+SPACELEFT) AND current_x < (x"7C"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <= (OTHERS => bcd_to_digit6x8(digit_31)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"7C"+SPACELEFT)))));
			elsif (lvl = '1' and current_x >= (x"7C"+SPACELEFT) AND current_x < (x"7C"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <= (OTHERS => bcd_to_digit6x8(digit_31)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"7C"+SPACELEFT)))));				
            elsIF (lvl = '0' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_32)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT))))); 
			elsIF (lvl = '1' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_32)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));				
            elsIF (current_x >= (x"D4"+SPACELEFT) AND current_x < (x"D4"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_33)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"D4"+SPACELEFT)))));     
            elsIF (lvl = '0' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_34)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));     
			elsIF (lvl = '1' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_34)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));     
            elsIF (current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_35)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));     
            elsIF (lvl='1' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_36)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
            elsif(lvl='0' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_36)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));             
            elsIF (current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_37)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));     
            elsIF (lvl='1' and current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_38)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));     
            elsif(lvl='0' and current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_38)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));
            elsIF (lvl='1' and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_39)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));
            elsif(lvl='0'and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"87"+SPACEUP) AND current_y < (x"87"+SPACEUP+DIGITHIGH))then
                    colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_39)(to_Integer(UNSIGNED(current_y-(x"87"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));
            --Quarta Linha
            elsif (current_x >= (x"7C"+SPACELEFT) AND current_x < (x"7C"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <= (OTHERS => bcd_to_digit6x8(digit_41)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"7C"+SPACELEFT))))); 
            elsIF (lvl = '0' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_42)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_42)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT))))); 				
            elsIF (current_x >= (x"D4"+SPACELEFT) AND current_x < (x"D4"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_43)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"D4"+SPACELEFT)))));     
            elsIF (lvl = '0' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_44)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));  
			elsIF (lvl = '1' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_44)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));				
            elsIF (current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_45)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));     
            elsIF (lvl = '0' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_46)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_46)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
            elsIF (lvl = '0' and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_47)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_47)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));				
            elsIF (lvl = '0' and current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_48)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_48)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));				
            elsIF (current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"B5"+SPACEUP) AND current_y < (x"B5"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_49)(to_Integer(UNSIGNED(current_y-(x"B5"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));     
            --Quinta Linha
            elsif (lvl='1' and current_x >= (x"7C"+SPACELEFT) AND current_x < (x"7C"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <= (OTHERS => bcd_to_digit6x8(digit_51)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"7C"+SPACELEFT))))); 
            elsif(lvl='0'and current_x >= (x"7C"+SPACELEFT) AND current_x < (x"7C"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_51)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"7C"+SPACELEFT)))));
            elsIF (lvl='1' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_52)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));     
            elsif(lvl='0' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_52)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));
            elsIF (current_x >= (x"D4"+SPACELEFT) AND current_x < (x"D4"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_53)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"D4"+SPACELEFT)))));     
            elsIF (lvl='1' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_54)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));     
            elsif(lvl='0' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_54)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));
            elsIF (lvl='1' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_55)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));     
            elsif(lvl='0' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH))then
                    colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_55)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));
            elsIF (lvl='1' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_56)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
            elsif(lvl='0' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_56)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
            elsIF (lvl = '0' and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_57)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_57)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));				
            elsIF (current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_58)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));     
            elsIF (current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"DE"+SPACEUP) AND current_y < (x"DE"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_59)(to_Integer(UNSIGNED(current_y-(x"DE"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));             
            --Sexta Linha
             elsif (lvl = '0' and current_x >= (x"7C"+SPACELEFT) AND current_x < (x"7C"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <= (OTHERS => bcd_to_digit6x8(digit_61)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"7C"+SPACELEFT)))));
             elsif (lvl = '1' and current_x >= (x"7C"+SPACELEFT) AND current_x < (x"7C"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <= (OTHERS => bcd_to_digit6x8(digit_61)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"7C"+SPACELEFT))))); 				
             elsIF (lvl='1' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_62)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));     
             elsif(lvl='0' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH))then
                    colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_62)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));              
             elsIF (lvl='1' and current_x >= (x"D4"+SPACELEFT) AND current_x < (x"D4"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_63)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"D4"+SPACELEFT)))));     
             elsif(lvl='0' and current_x >= (x"D4"+SPACELEFT) AND current_x < (x"D4"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH))then
                    colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_63)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"D4"+SPACELEFT)))));
             elsIF (lvl='1' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_64)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));     
             elsif(lvl='0' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH))then
                    colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_64)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));
             elsIF (lvl = '0' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_65)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_65)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));				
            elsIF (lvl='1' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_66)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
            elsif(lvl='0' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_66)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
            elsIF (lvl = '0' and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_67)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_67)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));				
            elsIF (lvl='1' and current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_68)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));     
            elsif(lvl='0' and current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_68)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));
            elsIF (lvl = '0' and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_69)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"107"+SPACEUP) AND current_y < (x"107"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_69)(to_Integer(UNSIGNED(current_y-(x"107"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));
            --Setima Linha
             elsif (current_x >= (x"7C"+SPACELEFT) AND current_x < (x"7C"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <= (OTHERS => bcd_to_digit6x8(digit_71)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"7C"+SPACELEFT))))); 
             elsIF (lvl = '0' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_72)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT))))); 
			elsIF (lvl = '1' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_72)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));     				
             elsIF (lvl='1' and current_x >= (x"D4"+SPACELEFT) AND current_x < (x"D4"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_73)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"D4"+SPACELEFT)))));     
             elsif(lvl='0' and current_x >= (x"D4"+SPACELEFT) AND current_x < (x"D4"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH))then
                    colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_73)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"D4"+SPACELEFT)))));
             elsIF (current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_74)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));     
             elsIF (lvl='1' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_75)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));     
             elsif(lvl='0' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_75)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));
             elsIF (lvl = '0' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_76)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_76)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
             elsIF (lvl='1' and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_77)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));     
             elsif(lvl='0' and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH))then
                    colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_77)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));
             elsIF (current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_78)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));     
             elsIF (lvl='1' and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_79)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));     
             elsif(lvl='0' and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"135"+SPACEUP) AND current_y < (x"135"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_79)(to_Integer(UNSIGNED(current_y-(x"135"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));
             --Oitava Linha
             elsif (lvl = '0' and current_x >= (x"7C"+SPACELEFT) AND current_x < (x"7C"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <= (OTHERS => bcd_to_digit6x8(digit_81)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"7C"+SPACELEFT)))));
			elsif (lvl = '1' and current_x >= (x"7C"+SPACELEFT) AND current_x < (x"7C"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <= (OTHERS => bcd_to_digit6x8(digit_81)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"7C"+SPACELEFT)))));				
             elsIF (lvl='1' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_82)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));     
             elsif(lvl='0'and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH))then
                    colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_82)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));
             elsIF (current_x >= (x"D4"+SPACELEFT) AND current_x < (x"D4"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_83)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"D4"+SPACELEFT)))));     
             elsIF (lvl='1' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_84)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));     
             elsif(lvl='0' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_84)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));
             elsIF (lvl = '0' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_85)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_85)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));				
             elsIF (lvl='1' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_86)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
             elsif(lvl='0' and current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_86)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
             elsIF (lvl = '0' and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_87)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_87)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));				
             elsIF (lvl='1' and current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_88)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));     
             elsif(lvl='0' and current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_88)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT))))); 
             elsIF (lvl = '0' and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_89)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"15E"+SPACEUP) AND current_y < (x"15E"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_89)(to_Integer(UNSIGNED(current_y-(x"15E"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));
             --nove Linha
             elsif (current_x >= (x"7C"+SPACELEFT) AND current_x < (x"7C"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <= (OTHERS => bcd_to_digit6x8(digit_91)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"7C"+SPACELEFT))))); 
             elsIF (lvl = '0' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_92)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"A8"+SPACELEFT) AND current_x < (x"A8"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_92)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"A8"+SPACELEFT)))));				
             elsIF (current_x >= (x"D4"+SPACELEFT) AND current_x < (x"D4"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_93)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"D5"+SPACELEFT)))));     
             elsIF (lvl = '0' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_94)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT))))); 
			elsIF (lvl = '1' and current_x >= (x"105"+SPACELEFT) AND current_x < (x"105"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_94)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"105"+SPACELEFT)))));				
             elsIF (lvl = '0' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_95)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"131"+SPACELEFT) AND current_x < (x"131"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_95)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"131"+SPACELEFT)))));				
             elsIF (current_x >= (x"15D"+SPACELEFT) AND current_x < (x"15D"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_96)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"15D"+SPACELEFT)))));
             elsIF (lvl='1' and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_97)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));     
             elsif(lvl='0'and current_x >= (x"18E"+SPACELEFT) AND current_x < (x"18E"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH))then
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_97)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"18E"+SPACELEFT)))));
             elsIF (lvl = '0' and current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_98)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"1BA"+SPACELEFT) AND current_x < (x"1BA"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_98)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1BA"+SPACELEFT)))));				
             elsIF (lvl = '0' and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 8) <=(OTHERS => bcd_to_digit6x8(digit_99)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));
			elsIF (lvl = '1' and current_x >= (x"1E6"+SPACELEFT) AND current_x < (x"1E6"+SPACELEFT+DIGITLENGHT) AND current_y >= (x"187"+SPACEUP) AND current_y < (x"187"+SPACEUP+DIGITHIGH)) THEN
                colorOut(11 downto 4) <=(OTHERS => bcd_to_digit6x8(digit_99)(to_Integer(UNSIGNED(current_y-(x"187"+SPACEUP))),to_Integer(UNSIGNED(current_x-(x"1E6"+SPACELEFT)))));
             ELSE
                colorOut(11 downto 8) <= (OTHERS => '0');
             END IF;   
       end if;      
  END PROCESS;
  
process(clk,rst,
        digit_11,digit_12, digit_13, digit_14, digit_15, digit_16, digit_17, digit_18, digit_19,
        digit_21,digit_22, digit_23, digit_24, digit_25, digit_26, digit_27, digit_28, digit_29,
        digit_31,digit_32, digit_33, digit_34, digit_35, digit_36, digit_37, digit_38, digit_39,
        digit_41,digit_42, digit_43, digit_44, digit_45, digit_46, digit_47, digit_48, digit_49,
        digit_51,digit_52, digit_53, digit_54, digit_55, digit_56, digit_57, digit_58, digit_59,
        digit_61,digit_62, digit_63, digit_64, digit_65, digit_66, digit_67, digit_68, digit_69,
        digit_71,digit_72, digit_73, digit_74, digit_75, digit_76, digit_77, digit_78, digit_79,
        digit_81,digit_82, digit_83, digit_84, digit_85, digit_86, digit_87, digit_88, digit_89,
        digit_91,digit_92, digit_93, digit_94, digit_95, digit_96, digit_97, digit_98, digit_99
        )
begin 
      if (rising_edge(CLK)) then             
              IF RST = '1'THEN
                digit_11a<=clNum; digit_12a<=clNum; digit_13a<=clNum; digit_14a<=clNum; digit_15a<=clNum; digit_16a<=clNum; digit_17a<=clNum; digit_18a<=clNum; digit_19a<=clNum;
                digit_21a<=clNum; digit_22a<=clNum; digit_23a<=clNum; digit_24a<=clNum; digit_25a<=clNum; digit_26a<=clNum; digit_27a<=clNum; digit_28a<=clNum; digit_29a<=clNum;
                digit_31a<=clNum; digit_32a<=clNum; digit_33a<=clNum; digit_34a<=clNum; digit_35a<=clNum; digit_36a<=clNum; digit_37a<=clNum; digit_38a<=clNum; digit_39a<=clNum;
                digit_41a<=clNum; digit_42a<=clNum; digit_43a<=clNum; digit_44a<=clNum; digit_45a<=clNum; digit_46a<=clNum; digit_47a<=clNum; digit_48a<=clNum; digit_49a<=clNum;
                digit_51a<=clNum; digit_52a<=clNum; digit_53a<=clNum; digit_54a<=clNum; digit_55a<=clNum; digit_56a<=clNum; digit_57a<=clNum; digit_58a<=clNum; digit_59a<=clNum;
                digit_61a<=clNum; digit_62a<=clNum; digit_63a<=clNum; digit_64a<=clNum; digit_65a<=clNum; digit_66a<=clNum; digit_67a<=clNum; digit_68a<=clNum; digit_69a<=clNum;
                digit_71a<=clNum; digit_72a<=clNum; digit_73a<=clNum; digit_74a<=clNum; digit_75a<=clNum; digit_76a<=clNum; digit_77a<=clNum; digit_78a<=clNum; digit_79a<=clNum;
                digit_81a<=clNum; digit_82a<=clNum; digit_83a<=clNum; digit_84a<=clNum; digit_85a<=clNum; digit_86a<=clNum; digit_87a<=clNum; digit_88a<=clNum; digit_89a<=clNum;
                digit_91a<=clNum; digit_92a<=clNum; digit_93a<=clNum; digit_94a<=clNum; digit_95a<=clNum; digit_96a<=clNum; digit_97a<=clNum; digit_98a<=clNum; digit_99a<=clNum;
              ELSe
                digit_11a<=digit_11; digit_12a<=digit_12; digit_13a<=digit_13; digit_14a<=digit_14; digit_15a<=digit_15; digit_16a<=digit_16; digit_17a<=digit_17; digit_18a<=digit_18; digit_19a<=digit_19;
                digit_21a<=digit_21; digit_22a<=digit_22; digit_23a<=digit_23; digit_24a<=digit_24; digit_25a<=digit_25; digit_26a<=digit_26; digit_27a<=digit_27; digit_28a<=digit_28; digit_29a<=digit_29;
                digit_31a<=digit_31; digit_32a<=digit_32; digit_33a<=digit_33; digit_34a<=digit_34; digit_35a<=digit_35; digit_36a<=digit_36; digit_37a<=digit_37; digit_38a<=digit_38; digit_39a<=digit_39;
                digit_41a<=digit_41; digit_42a<=digit_42; digit_43a<=digit_43; digit_44a<=digit_44; digit_45a<=digit_45; digit_46a<=digit_46; digit_47a<=digit_47; digit_48a<=digit_48; digit_49a<=digit_49;
                digit_51a<=digit_51; digit_52a<=digit_52; digit_53a<=digit_53; digit_54a<=digit_54; digit_55a<=digit_55; digit_56a<=digit_56; digit_57a<=digit_57; digit_58a<=digit_58; digit_59a<=digit_59;
                digit_61a<=digit_61; digit_62a<=digit_62; digit_63a<=digit_63; digit_64a<=digit_64; digit_65a<=digit_65; digit_66a<=digit_66; digit_67a<=digit_67; digit_68a<=digit_68; digit_69a<=digit_69;
                digit_71a<=digit_71; digit_72a<=digit_72; digit_73a<=digit_73; digit_74a<=digit_74; digit_75a<=digit_75; digit_76a<=digit_76; digit_77a<=digit_77; digit_78a<=digit_78; digit_79a<=digit_79;
                digit_81a<=digit_81; digit_82a<=digit_82; digit_83a<=digit_83; digit_84a<=digit_84; digit_85a<=digit_85; digit_86a<=digit_86; digit_87a<=digit_87; digit_88a<=digit_88; digit_89a<=digit_89;
                digit_91a<=digit_91; digit_92a<=digit_92; digit_93a<=digit_93; digit_94a<=digit_94; digit_95a<=digit_95; digit_96a<=digit_96; digit_97a<=digit_97; digit_98a<=digit_98; digit_99a<=digit_99;
              END IF;           
         end if;
end process;   
 
process(lvl,
        digit_11,digit_12, digit_13, digit_14, digit_15, digit_16, digit_17, digit_18, digit_19,
        digit_21,digit_22, digit_23, digit_24, digit_25, digit_26, digit_27, digit_28, digit_29,
        digit_31,digit_32, digit_33, digit_34, digit_35, digit_36, digit_37, digit_38, digit_39,
        digit_41,digit_42, digit_43, digit_44, digit_45, digit_46, digit_47, digit_48, digit_49,
        digit_51,digit_52, digit_53, digit_54, digit_55, digit_56, digit_57, digit_58, digit_59,
        digit_61,digit_62, digit_63, digit_64, digit_65, digit_66, digit_67, digit_68, digit_69,
        digit_71,digit_72, digit_73, digit_74, digit_75, digit_76, digit_77, digit_78, digit_79,
        digit_81,digit_82, digit_83, digit_84, digit_85, digit_86, digit_87, digit_88, digit_89,
        digit_91,digit_92, digit_93, digit_94, digit_95, digit_96, digit_97, digit_98, digit_99
        )
begin
	if(lvl='0')then
		if(
		digit_11="0100" and digit_12="0001" and digit_13 ="0101" and digit_14 ="0111" and digit_15="0011" and digit_16="1000" and digit_17 ="0010" and digit_18 ="0110" and digit_19="1001" and
		digit_21="0111" and digit_22="0110" and digit_23="0011" and digit_24="0010" and digit_25="0100" and digit_26="1001" and digit_27="0101" and digit_28="1000" and digit_29="0001" and 
		digit_31="1001" and digit_32="0010" and digit_33="1000" and digit_34="0110" and digit_35="0101" and digit_36="0001" and digit_37="0100" and digit_38="0111" and digit_39="0011" and
		digit_41="0011" and digit_42="1001" and digit_43="0110" and digit_44="0100" and digit_45="0111" and digit_46="0101" and digit_47="1000" and digit_48="0001" and digit_49="0010" and
		digit_51="0001" and digit_52="0101" and digit_53="0111" and digit_54="0011" and digit_55="1000" and digit_56="0010" and digit_57="0110" and digit_58="1001" and digit_59="0100" and
		digit_61="0010" and digit_62="1000" and digit_63="0100" and digit_64="1001" and digit_65="0001" and digit_66="0110" and digit_67="0011" and digit_68="0101" and digit_69="0111" and
		digit_71="1000" and digit_72="0011" and digit_73="0001" and digit_74="0101" and digit_75="0010" and digit_76="0111" and digit_77="1001" and digit_78="0100" and digit_79="0110" and 
		digit_81="0110" and digit_82="0111" and digit_83="0010" and digit_84="1000" and digit_85="1001" and digit_86="0100" and digit_87="0001" and digit_88="0011" and digit_89="0101" and 
		digit_91="0101" and digit_92="0100" and digit_93="1001" and digit_94="0001" and digit_95="0110" and digit_96="0011" and digit_97="0111" and digit_98="0010" and digit_99="1000"
		)then
		  win<='1';
		else
		  win<='0';
		end if; 
	else
		if(
        digit_11="0011" and digit_12="0111" and digit_13 ="0100" and digit_14 ="1001" and digit_15="1000" and digit_16="0010" and digit_17 ="0101" and digit_18 ="0110" and digit_19="0001" and
        digit_21="0001" and digit_22="1000" and digit_23="0101" and digit_24="0111" and digit_25="0011" and digit_26="0110" and digit_27="0100" and digit_28="0010" and digit_29="1001" and 
        digit_31="1001" and digit_32="0110" and digit_33="0010" and digit_34="0100" and digit_35="0101" and digit_36="0001" and digit_37="0011" and digit_38="0111" and digit_39="1000" and
        digit_41="1000" and digit_42="0010" and digit_43="0111" and digit_44="0101" and digit_45="1001" and digit_46="0100" and digit_47="0110" and digit_48="0001" and digit_49="0011" and
        digit_51="0110" and digit_52="0100" and digit_53="1001" and digit_54="1000" and digit_55="0001" and digit_56="0011" and digit_57="0010" and digit_58="0101" and digit_59="0111" and
        digit_61="0101" and digit_62="0011" and digit_63="0001" and digit_64="0110" and digit_65="0010" and digit_66="0111" and digit_67="1001" and digit_68="1000" and digit_69="0100" and
        digit_71="0100" and digit_72="1001" and digit_73="0110" and digit_74="0001" and digit_75="0111" and digit_76="0101" and digit_77="1000" and digit_78="0011" and digit_79="0010" and 
        digit_81="0010" and digit_82="0001" and digit_83="1000" and digit_84="0011" and digit_85="0110" and digit_86="1001" and digit_87="0111" and digit_88="0100" and digit_89="0101" and 
        digit_91="0111" and digit_92="0101" and digit_93="0011" and digit_94="0010" and digit_95="0100" and digit_96="1000" and digit_97="0001" and digit_98="1001" and digit_99="0110" 
        )then
		  win<='1';
		else
		  win<='0';
		end if; 
	end if;
end process;	 
  
PROCESS(row,lvl,col, num,update,
        digit_11a,digit_12a, digit_13a, digit_14a, digit_15a, digit_16a, digit_17a, digit_18a, digit_19a,
        digit_21a,digit_22a, digit_23a, digit_24a, digit_25a, digit_26a, digit_27a, digit_28a, digit_29a,
        digit_31a,digit_32a, digit_33a, digit_34a, digit_35a, digit_36a, digit_37a, digit_38a, digit_39a,
        digit_41a,digit_42a, digit_43a, digit_44a, digit_45a, digit_46a, digit_47a, digit_48a, digit_49a,
        digit_51a,digit_52a, digit_53a, digit_54a, digit_55a, digit_56a, digit_57a, digit_58a, digit_59a,
        digit_61a,digit_62a, digit_63a, digit_64a, digit_65a, digit_66a, digit_67a, digit_68a, digit_69a,
        digit_71a,digit_72a, digit_73a, digit_74a, digit_75a, digit_76a, digit_77a, digit_78a, digit_79a,
        digit_81a,digit_82a, digit_83a, digit_84a, digit_85a, digit_86a, digit_87a, digit_88a, digit_89a,
        digit_91a,digit_92a, digit_93a, digit_94a, digit_95a, digit_96a, digit_97a, digit_98a, digit_99a 
        )
BEGIN

     digit_11<=digit_11a; digit_12<=digit_12a; digit_13<=digit_13a; digit_14<=digit_14a; digit_15<=digit_15a; digit_16<=digit_16a; digit_17<=digit_17a; digit_18<=digit_18a; digit_19<=digit_19a;
     digit_21<=digit_21a; digit_22<=digit_22a; digit_23<=digit_23a; digit_24<=digit_24a; digit_25<=digit_25a; digit_26<=digit_26a; digit_27<=digit_27a; digit_28<=digit_28a; digit_29<=digit_29a;
     digit_31<=digit_31a; digit_32<=digit_32a; digit_33<=digit_33a; digit_34<=digit_34a; digit_35<=digit_35a; digit_36<=digit_36a; digit_37<=digit_37a; digit_38<=digit_38a; digit_39<=digit_39a;
     digit_41<=digit_41a; digit_42<=digit_42a; digit_43<=digit_43a; digit_44<=digit_44a; digit_45<=digit_45a; digit_46<=digit_46a; digit_47<=digit_47a; digit_48<=digit_48a; digit_49<=digit_49a;
     digit_51<=digit_51a; digit_52<=digit_52a; digit_53<=digit_53a; digit_54<=digit_54a; digit_55<=digit_55a; digit_56<=digit_56a; digit_57<=digit_57a; digit_58<=digit_58a; digit_59<=digit_59a;
     digit_61<=digit_61a; digit_62<=digit_62a; digit_63<=digit_63a; digit_64<=digit_64a; digit_65<=digit_65a; digit_66<=digit_66a; digit_67<=digit_67a; digit_68<=digit_68a; digit_69<=digit_69a;
     digit_71<=digit_71a; digit_72<=digit_72a; digit_73<=digit_73a; digit_74<=digit_74a; digit_75<=digit_75a; digit_76<=digit_76a; digit_77<=digit_77a; digit_78<=digit_78a; digit_79<=digit_79a;
     digit_81<=digit_81a; digit_82<=digit_82a; digit_83<=digit_83a; digit_84<=digit_84a; digit_85<=digit_85a; digit_86<=digit_86a; digit_87<=digit_87a; digit_88<=digit_88a; digit_89<=digit_89a;
     digit_91<=digit_91a; digit_92<=digit_92a; digit_93<=digit_93a; digit_94<=digit_94a; digit_95<=digit_95a; digit_96<=digit_96a; digit_97<=digit_97a; digit_98<=digit_98a; digit_99<=digit_99a;

    --CADEIA DE IFS QUE ESTRAGA O TEMPO DE SYNTESE  
    if(update='1')then
        if(row = "0001" and col="0001") then
            digit_11 <= (num);
        elsif(row = "0001" and col = "0010") then
            digit_12 <= (num);
        elsif(row = "0001" and col = "0011") then
            digit_13 <= (num);
        elsif(row = "0001" and col = "0100") then
            digit_14 <= (num);
        elsif(row = "0001" and col = "0101") then
            digit_15 <= (num);
        elsif(row = "0001" and col = "0110") then
            digit_16 <= (num);
        elsif(row = "0001" and col = "0111") then
            digit_17 <= (num);
        elsif(row = "0001" and col = "1000") then
            digit_18 <= (num);
        elsif(row = "0001" and col = "1001") then
            digit_19 <= (num);
        end if;
        if(row = "0010" and col="0001") then
            digit_21 <= (num);
        elsif(row = "0010" and col = "0010") then
            digit_22 <= (num);
        elsif(row = "0010" and col = "0011") then
            digit_23 <= (num);
        elsif(row = "0010" and col = "0100") then
            digit_24 <= (num);
        elsif(row = "0010" and col = "0101") then
            digit_25 <= (num);
        elsif(row = "0010" and col = "0110") then
            digit_26 <= (num);
        elsif(row = "0010" and col = "0111") then
            digit_27 <= (num);
        elsif(row = "0010" and col = "1000") then
            digit_28 <= (num);
        elsif(row = "0010" and col = "1001") then
            digit_29 <= (num);
        end if;
        if(row = "0011" and col="0001") then
            digit_31 <= (num);
        elsif(row = "0011" and col = "0010") then
            digit_32 <= (num);
        elsif(row = "0011" and col = "0011") then
            digit_33 <= (num);
        elsif(row = "0011" and col = "0100") then
            digit_34 <= (num);
        elsif(row = "0011" and col = "0101") then
            digit_35 <= (num);
        elsif(row = "0011" and col = "0110") then
            digit_36 <= (num);
        elsif(row = "0011" and col = "0111") then
            digit_37 <= (num);
        elsif(row = "0011" and col = "1000") then
            digit_38 <= (num);
        elsif(row = "0011" and col = "1001") then
            digit_39 <= (num);
        end if;
        if(row = "0100" and col="0001") then
            digit_41 <= (num);
        elsif(row = "0100" and col = "0010") then
            digit_42 <= (num);
        elsif(row = "0100" and col = "0011") then
            digit_43 <= (num);
        elsif(row = "0100" and col = "0100") then
            digit_44 <= (num);
        elsif(row = "0100" and col = "0101") then
            digit_45 <= (num);
        elsif(row = "0100" and col = "0110") then
            digit_46 <= (num);
        elsif(row = "0100" and col = "0111") then
            digit_47 <= (num);
        elsif(row = "0100" and col = "1000") then
            digit_48 <= (num);
        elsif(row = "0100" and col = "1001") then
            digit_49 <= (num);
        end if;
        if(row = "0101" and col="0001") then
            digit_51 <= (num);
        elsif(row = "0101" and col = "0010") then
            digit_52 <= (num);
        elsif(row = "0101" and col = "0011") then
            digit_53 <= (num);
        elsif(row = "0101" and col = "0100") then
            digit_54 <= (num);
        elsif(row = "0101" and col = "0101") then
            digit_55 <= (num);
        elsif(row = "0101" and col = "0110") then
            digit_56 <= (num);
        elsif(row = "0101" and col = "0111") then
            digit_57 <= (num);
        elsif(row = "0101" and col = "1000") then
            digit_58 <= (num);
        elsif(row = "0101" and col = "1001") then
            digit_59 <= (num);
        end if;
        if(row = "0110" and col="0001") then
            digit_61 <= (num);
        elsif(row = "0110" and col = "0010") then
            digit_62 <= (num);
        elsif(row = "0110" and col = "0011") then
            digit_63 <= (num);
        elsif(row = "0110" and col = "0100") then
            digit_64 <= (num);
        elsif(row = "0110" and col = "0101") then
            digit_65 <= (num);
        elsif(row = "0110" and col = "0110") then
            digit_66 <= (num);
        elsif(row = "0110" and col = "0111") then
            digit_67 <= (num);
        elsif(row = "0110" and col = "1000") then
            digit_68 <= (num);
        elsif(row = "0110" and col = "1001") then
            digit_69 <= (num);
        end if;
        if(row = "0111" and col="0001") then
            digit_71 <= (num);
        elsif(row = "0111" and col = "0010") then
            digit_72 <= (num);
        elsif(row = "0111" and col = "0011") then
            digit_73 <= (num);
        elsif(row = "0111" and col = "0100") then
            digit_74 <= (num);
        elsif(row = "0111" and col = "0101") then
            digit_75 <= (num);
        elsif(row = "0111" and col = "0110") then
            digit_76 <= (num);
        elsif(row = "0111" and col = "0111") then
            digit_77 <= (num);
        elsif(row = "0111" and col = "1000") then
            digit_78 <= (num);
        elsif(row = "0111" and col = "1001") then
            digit_79 <= (num);
        end if;
        if(row = "1000" and col="0001") then
            digit_81 <= (num);
        elsif(row = "1000" and col = "0010") then
            digit_82 <= (num);
        elsif(row = "1000" and col = "0011") then
            digit_83 <= (num);
        elsif(row = "1000" and col = "0100") then
            digit_84 <= (num);
        elsif(row = "1000" and col = "0101") then
            digit_85 <= (num);
        elsif(row = "1000" and col = "0110") then
            digit_86 <= (num);
        elsif(row = "1000" and col = "0111") then
            digit_87 <= (num);
        elsif(row = "1000" and col = "1000") then
            digit_88 <= (num);
        elsif(row = "1000" and col = "1001") then
            digit_89 <= (num);
        end if;
        if(row = "1001" and col="0001") then
            digit_91 <= (num);
        elsif(row = "1001" and col = "0010") then
            digit_92 <= (num);
        elsif(row = "1001" and col = "0011") then
            digit_93 <= (num);
        elsif(row = "1001" and col = "0100") then
            digit_94 <= (num);
        elsif(row = "1001" and col = "0101") then
            digit_95 <= (num);
        elsif(row = "1001" and col = "0110") then
            digit_96 <= (num);
        elsif(row = "1001" and col = "0111") then
            digit_97 <= (num);
        elsif(row = "1001" and col = "1000") then
            digit_98 <= (num);
        elsif(row = "1001" and col = "1001") then
            digit_99 <= (num);
        end if;
    end if;
    --FIM CADEIA DE IFS QUE ESTRAGA O TEMPO DE SYNTESE  
    
        
    if(lvl='0')then
    	 digit_13<="0101"; digit_16<="1000"; digit_18<="0110"; digit_19<="1001";
         digit_22<="0110"; digit_24<="0010"; digit_25<="0100"; digit_29<="0001";
         digit_36<="0001"; digit_38<="0111"; digit_39<="0011"; digit_51<="0001";
         digit_52<="0101"; digit_54<="0011"; digit_55<="1000"; digit_56<="0010";
         digit_62<="1000"; digit_63<="0100"; digit_64<="1001"; digit_66<="0110";
         digit_68<="0101"; digit_73<="0001"; digit_75<="0010"; digit_77<="1001";
         digit_79<="0110"; digit_82<="0111"; digit_84<="1000"; digit_86<="0100";
         digit_88<="0011"; digit_97<="0111";
    else
         digit_14<="1001"; digit_15<="1000"; digit_16<="0010"; 
         digit_22<="1000"; digit_26<="0110"; digit_27<="0100"; digit_29<="1001";
         digit_31<="1001"; digit_32<="0110"; digit_34<="0100"; digit_36<="0001";
         digit_42<="0010"; digit_44<="0101"; digit_46<="0100"; digit_47<="0110"; 
         digit_48<="0001"; digit_51<="0110"; digit_52<="0100"; digit_54<="1000";
         digit_56<="0011"; digit_57 <="0010";digit_61<="0101"; digit_62<="0011"; 
         digit_63<="0001"; digit_64<="0110"; digit_65 <= "0010"; digit_67 <= "1001"; 
         digit_69 <= "0100";digit_72<="1001"; digit_73<="0110"; digit_76<="0101"; 
         digit_79<="0010";digit_81<="0010"; digit_85 <= "0110"; digit_87 <= "0111"; 
         digit_88 <= "0100"; digit_89 <= "0101";digit_92 <="0101"; digit_94 <= "0010"; 
         digit_95 <= "0100"; digit_98 <= "1001"; digit_99 <= "0110"; 
    end if;
    
END PROCESS;  
  
  
end Behavioral;
