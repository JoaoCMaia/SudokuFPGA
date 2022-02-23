
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
  Port ( 
        rst :in std_logic;
        row :in std_logic_vector(3 downto 0 );
        col :in std_logic_vector(3 downto 0 );
        Hex4_plus: out STD_LOGIC_VECTOR (4 downto 0);
        Hex3_plus: out STD_LOGIC_VECTOR (4 downto 0);
        Hex2_plus: out STD_LOGIC_VECTOR (4 downto 0);
        Hex1_plus: out STD_LOGIC_VECTOR (4 downto 0)
        );
end Control;

architecture Behavioral of Control is
begin 
process(row,col,rst)
	begin
	       if(rst='1')then
                Hex4_plus <= (others=>'1'); 
                Hex3_plus <= (others=>'1');
                Hex2_plus <= (others=>'1');
                Hex1_plus <= (others=>'1');
           else 
                Hex4_plus(4) <= '0';
                Hex4_plus(3 downto 0) <= row;  
                Hex3_plus <= "10001"; 
                Hex2_plus(4) <= '0';
                Hex2_plus(3 downto 0) <= col; 
                Hex1_plus <= "10000"; 
           end if;      
  end process;
end Behavioral;

