library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Hex2ssd is
	Port (Hex_plus : in STD_LOGIC_VECTOR (4 downto 0);
		seg	: out STD_LOGIC_VECTOR ( 6 downto 0));
end Hex2ssd;

architecture Behavioral of hex2ssd is

begin 
    with Hex_plus SELect
    seg<="1000000" when "00000",--0
  	 "1111001" when "00001", --1
	 "0100100" when "00010", --2
	 "0110000" when "00011", --3
	 "0011001" when "00100", --4
	 "0010010" when "00101", --5
	 "0000010" when "00110", --6
	 "1111000" when "00111", --7
	 "0000000" when "01000", --8
	 "0010000" when "01001", --9
     "1000110" when "10000", --C
     "0101111" when "10001", --R
	 "1111111" when others;
end Behavioral;

