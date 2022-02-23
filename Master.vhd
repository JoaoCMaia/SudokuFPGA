----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2022 06:16:53
-- Design Name: 
-- Module Name: Master - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Master is
    Port ( 
           clk : in  STD_LOGIC;
           reset: in STD_LOGIC;
           num: in std_logic_vector(3 downto 0);
           row: in std_logic_vector(3 downto 0);
           col: in std_logic_vector(3 downto 0);
           lvl: in std_logic;
           autocorrect: in std_logic;
           update: in std_logic;
           -- to VGA ports
           HSync : out  STD_LOGIC;
           VSync : out  STD_LOGIC;
           -- VGA ports
           vgaRed : out  STD_LOGIC_VECTOR(3 DOWNTO 0);
           vgaGreen : out  STD_LOGIC_VECTOR(3 DOWNTO 0);
           vgaBlue : out  STD_LOGIC_VECTOR(3 DOWNTO 0);
           --- 7Seg bus
            seg : out std_logic_vector(6 downto 0);    
            an: out std_logic_vector(3 downto 0);
            --dp: out std_logic
            second:out std_logic_vector(3 downto 0);
            win: out std_logic
            );
end Master;

architecture Behavioral of Master is
 component NumberGen 
    Port ( 
         clk : in  STD_LOGIC;
         rst: in STD_LOGIC;         
         colorOutNumber: out  std_logic_vector(11 downto 0);
         win: out std_logic;
         current_x: in STD_LOGIC_VECTOR(9 downto 0);
         current_y: in STD_LOGIC_VECTOR(9 downto 0);
         ---------------
         lvl: in std_logic;
         autocorrect: in std_logic;
         update: in std_logic;
         num: in std_logic_vector(3 downto 0);
         row: in std_logic_vector(3 downto 0);
         col: in std_logic_vector(3 downto 0)
           );
end component;
component FrameGen 
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           current_x: in std_logic_vector(9 downto 0);
           current_y: in std_logic_vector(9 downto 0);
           onDisplay: in STD_LOGIC;
           -- VGA ports
           colorOutFrame: out  std_logic_vector(11 downto 0)
);
end component;
component Cronometer is
     PORT (
         clk : in  STD_LOGIC;
         rst: in STD_LOGIC;         
         colorOutClock : out  STD_LOGIC_VECTOR(11 DOWNTO 0);
         current_x: in STD_LOGIC_VECTOR(9 downto 0);
         current_y: in STD_LOGIC_VECTOR(9 downto 0);
         second:out std_logic_vector(3 downto 0);
         finish: in std_logic
 );
 end component;
component Control is
    port(
        rst :in std_logic;
        row :in std_logic_vector(3 downto 0 );
        col :in std_logic_vector(3 downto 0 );
        Hex4_plus : out std_logic_vector (4 downto 0); 
        Hex3_plus : out std_logic_vector (4 downto 0); 
        Hex2_plus : out std_logic_vector (4 downto 0); 
        Hex1_plus : out std_logic_vector (4 downto 0) 
    );
end component;
    
component Hex2ssd is
    port(Hex_plus : in std_logic_vector (4 downto 0); 
        seg : out std_logic_vector(6 downto 0)
    );
end component;

component vga_sync 
    Port ( 
           clk : in  STD_LOGIC;
           rst: in STD_LOGIC;
           -- to VGA ports
           HSync : out  STD_LOGIC;
           VSync : out  STD_LOGIC;
           -- to Graphics Engine
           current_x: out STD_LOGIC_VECTOR(9 downto 0);
           current_y: out STD_LOGIC_VECTOR(9 downto 0);
           onDisplay: out STD_LOGIC;
           endOfFrame: out STD_LOGIC;
           clk_vga: out STD_LOGIC
           );
end component;
     -- Sync related
    signal clk_vga: STD_LOGIC;
    signal current_x: STD_LOGIC_VECTOR(9 downto 0);
    signal current_y: STD_LOGIC_VECTOR(9 downto 0);
    signal onDisplay :  STD_LOGIC;
    signal endOfFrame: STD_LOGIC;
    
    signal colorOutNumber, colorOutFrame, colorOutClock : std_logic_vector(11 downto 0);
    signal finish: std_logic;
--signals for 7segDisplay
signal ssd1: std_logic_vector(6 downto 0);
signal ssd2: std_logic_vector(6 downto 0);
signal ssd3: std_logic_vector(6 downto 0);
signal ssd4: std_logic_vector(6 downto 0);
signal Hex4_plus : std_logic_vector (4 downto 0);
signal Hex3_plus : std_logic_vector (4 downto 0);
signal Hex2_plus : std_logic_vector (4 downto 0);
signal Hex1_plus : std_logic_vector (4 downto 0);
signal refresh_counter: std_logic_vector  (25 downto 0);
signal Display_Active: std_logic_vector  (1 downto 0);
--state machine
    TYPE STATE_TYPE IS (init,play,won);
    SIGNAL state_reg, state_next   : STATE_TYPE;
-- counter: std_logic_vector(1 downto 0) :=(others=>'0');
--signal all_ones: std_logic_vector(1 downto 0):=(others=>'1');
begin

I0 : Control
port map(
        rst=>reset,
        row=>row,
        col=>col,
        Hex1_plus => Hex1_plus,
        Hex2_plus => Hex2_plus,
        Hex3_plus => Hex3_plus,
        Hex4_plus => Hex4_plus
        );

I1 : Hex2ssd
port map(
        Hex_plus => Hex1_plus,
        seg => ssd1
        );
I2 : Hex2ssd
port map(
        Hex_plus => Hex2_plus,
        seg => ssd2
        );
I3 : Hex2ssd
port map(
        Hex_plus => Hex3_plus,
        seg => ssd3
        );      
I4 : Hex2ssd
port map(
        Hex_plus => Hex4_plus,
        seg => ssd4
        );

FrameImage: FrameGen port map(
           clk => clk,
           reset => reset,
           current_x=> current_x,
           current_y=> current_y,
           onDisplay=> onDisplay,
           -- VGA ports
           colorOutFrame=>colorOutFrame
);

NumImage: NumberGen port map(
         clk =>clk,
         rst => reset,     
         colorOutNumber=> colorOutNumber,
         win=>finish,
         current_x=> current_x,
         current_y=> current_y,
         update=>update,
         ---------------
         lvl=>lvl,
         autocorrect=>autocorrect,
         num => num,
         row => row,
         col => col
);
DigitalClock: Cronometer port map(
         clk => clk,
         rst => reset,        
         colorOutClock => colorOutClock,
         current_x=> current_x,
         current_y=> current_y,
         second=>second,
         --finish => autocorrect
         finish => finish
 );
  
SYNC: vga_sync port map(
        clk => clk,
        rst => reset,
        -- to VGA ports
        HSync => HSync,
        VSync => VSync,
        -- to Graphics Engine
        current_x => current_x,
        current_y => current_y,
        onDisplay => onDisplay,
        endOfFrame => endOfFrame,
        clk_vga   => clk_vga
);
-----------------------------
--State Machine Game Status--
-----------------------------
PROCESS (CLK , reset)
   BEGIN
    if rising_edge (CLK)then
          IF reset = '1' THEN
             state_reg <= init;  
          else
             state_reg <= state_next;
          end if;    
       end if;   
   END PROCESS;
   
   PROCESS (state_reg,colorOutFrame,colorOutNumber, onDisplay, finish, colorOutClock, reset)
   BEGIN
        win<='0';
        state_next<= state_reg;
        vgaRed <= (others=>'0');
        vgaGreen <= (others=>'0');
        vgaBlue <= (others=>'0'); 
        CASE state_reg  IS
            when init =>
                if(onDisplay='1')then
                    state_next<=play;
                end if;
            when play =>
                vgaRed <= colorOutFrame(11 downto 8);
                vgaGreen <= colorOutFrame(7 downto 4);
                vgaBlue <= colorOutFrame(3 downto 0);
                if(colorOutNumber /= "000000000000") then
                   vgaRed <= colorOutNumber(11 downto 8);
                   vgaGreen <= colorOutNumber(7 downto 4);
                   vgaBlue <= colorOutNumber(3 downto 0);       
                end if;
                if(colorOutClock /= "000000000000") then
                   vgaRed <= colorOutClock(11 downto 8);
                   vgaGreen <= colorOutClock(7 downto 4);
                   vgaBlue <= colorOutClock(3 downto 0);    
                end if;
                if(finish='1')then
                    state_next<=won;
                end if;
                if(reset='1' or onDisplay='0')then
                    state_next<=init;
                end if;    
            when won =>
                vgaRed <= colorOutClock(11 downto 8);
                vgaGreen <= colorOutClock(7 downto 4);
                vgaBlue <= colorOutClock(3 downto 0);
                win<='1'; 
                if(reset='1')then
                    state_next<=init;
                end if;
            when others =>
        end case;   
    end process;
----------------------------------------------- 
--anodo process
-----------------------------------------------       
anodetick: process(clk, reset)
    begin 
        if(reset='1')then
            refresh_counter<= (others =>'0');
        elsif(rising_edge(CLK))then
            refresh_counter <=refresh_counter +1;
        end if;
    end process;
    Display_Active<= refresh_counter(19 downto 18);--for reallife
    --Display_Active<= refresh_counter(8 downto 7);--for tb
anodeSel: process(Display_Active,ssd1,ssd2,ssd3,ssd4)
    begin
        --dp<='1';
        case Display_Active is
        when "00" =>
            an<="0111";
            --dp<='0';
            seg<=ssd4;   
        when "01" =>
            an<="1011";
            seg<=ssd3;   
        when "10" =>
            an<="1101";
            seg<=ssd2;
        when others =>
            an<="1110";
            seg<=ssd1;
        end case;                  
    end process;
------------------------------------------------


end Behavioral;

