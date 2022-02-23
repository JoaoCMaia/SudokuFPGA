library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
entity FrameGen is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           current_x: in std_logic_vector(9 downto 0);
           current_y: in std_logic_vector(9 downto 0);
           onDisplay: in std_logic;
           -- VGA ports
           colorOutFrame: out std_logic_vector(11 downto 0)
);
end FrameGen;

architecture behavioral of FrameGen is

signal rst: STD_LOGIC;
signal colorOut: STD_LOGIC_VECTOR(11 downto 0); -- One signal to concatanate the
                   -- RGB. R is the MS nibble.

-- constants
constant top_border: STD_LOGIC_VECTOR(9 downto 0):=std_logic_vector(to_unsigned(53, current_y'length));
constant bottom_border: STD_LOGIC_VECTOR(9 downto 0):= std_logic_vector(to_unsigned(427, current_y'length));
constant left_border: STD_LOGIC_VECTOR(9 downto 0):=std_logic_vector(to_unsigned(123, current_x'length));
constant right_border: STD_LOGIC_VECTOR(9 downto 0):= std_logic_vector(to_unsigned(527, current_x'length));
constant border_thickness: STD_LOGIC_VECTOR(9 downto 0):= "0000000101";
constant timer_trial: STD_LOGIC_VECTOR(11 downto 0):= x"213";

-- color constants
constant RED: STD_LOGIC_VECTOR(11 downto 0) := "111100000000";
constant GREEN: STD_LOGIC_VECTOR(11 downto 0) := "000011110000";
constant BLUE: STD_LOGIC_VECTOR(11 downto 0) := "000000001111";
constant Random: STD_LOGIC_VECTOR(11 downto 0) := "000011111111";
constant BLACK: STD_LOGIC_VECTOR(11 downto 0) := "000000000000";
constant WHITE: STD_LOGIC_VECTOR(11 downto 0) := "111111111111";

 
begin

-- GPIO init
rst <= reset;
colorOutFrame <= colorOut;

DISPLAY:process(current_x, current_y, onDisplay)
   begin
    --Backdrop    
    if(onDisplay = '1') then  

     --Background not in the game
     if(current_y <= top_border - border_thickness or current_y >= bottom_border + border_thickness or
        current_x <= left_border - border_thickness or current_x >= right_border + border_thickness) then
      colorOut <= BLACK;
     
     -- Borders  
     elsif(
        (current_y < top_border and current_y > top_border - border_thickness) or
        (current_y > bottom_border and current_y < bottom_border + border_thickness) or
          (current_x < left_border and current_x > left_border - border_thickness) or 
      (current_x > right_border and current_x < right_border + border_thickness)
         ) then
       colorOut <= WHITE;
                     
        --GAME BACKGROUND WITH PLAYER
        else
            colorOut <= BLUE;
        end if; 
        
  --top left x = 77
  --bot x = 1AF
  --bot right x= 213 

--Linha grossas horizontais
     if(current_y > x"AB" and current_y <= x"B5" and current_x >= x"77" and current_x <= x"213") then --vertical 7f/3f
        colorOut <= WHITE;
     end if;
     if(current_y > x"12B" and current_y <= x"135" and current_x >= x"77" and current_x <= x"213") then --vertical 7f/3f
           colorOut <= WHITE;
     end if;   
--Linha grossas verticais
     if(current_y > x"30" and current_y <= x"1AF" and current_x >= x"184" and current_x <= x"18E") then --vertical 7f/3f
        colorOut <= WHITE;
     end if;
     if(current_y > x"30" and current_y <= x"1AF" and current_x >= x"FB" and current_x <= x"105") then --vertical 7f/3f
           colorOut <= WHITE;
     end if;   
--Linha FINAS horizontais
     if(current_y > x"59" and current_y <= x"59"+border_thickness and current_x >= x"77" and current_x <= x"213") then --vertical 7f/3f
        colorOut <= WHITE;
     end if;
     if(current_y > x"82" and current_y <= x"82"+border_thickness and current_x >= x"77" and current_x <= x"213") then --vertical 7f/3f
           colorOut <= WHITE;
     end if; 
     if(current_y > x"D9" and current_y <= x"D9"+border_thickness and current_x >= x"77" and current_x <= x"213") then --vertical 7f/3f
        colorOut <= WHITE;
     end if;
     if(current_y > x"102" and current_y <= x"102"+border_thickness and current_x >= x"77" and current_x <= x"213") then --vertical 7f/3f
           colorOut <= WHITE;
     end if; 
     if(current_y > x"159" and current_y <= x"159"+border_thickness and current_x >= x"77" and current_x <= x"213") then --vertical 7f/3f
        colorOut <= WHITE;
     end if;
     if(current_y > x"182" and current_y <= x"182"+border_thickness and current_x >= x"77" and current_x <= x"213") then --vertical 7f/3f
           colorOut <= WHITE;
     end if; 
--Linha FINAS verticais
     if(current_y > x"30" and current_y <= x"1AF" and current_x >= x"A3" and current_x <= x"A3"+border_thickness) then --vertical 7f/3f
        colorOut <= WHITE;
     end if;
     if(current_y > x"30" and current_y <= x"1AF" and current_x >= x"CF" and current_x <= x"CF"+border_thickness) then --vertical 7f/3f
        colorOut <= WHITE;
     end if;
     if(current_y > x"30" and current_y <= x"1AF" and current_x >= x"12C" and current_x <= x"12C"+border_thickness) then --vertical 7f/3f
        colorOut <= WHITE;
     end if;
     if(current_y > x"30" and current_y <= x"1AF" and current_x >= x"158" and current_x <= x"158"+border_thickness) then --vertical 7f/3f
        colorOut <= WHITE;
     end if;
     if(current_y > x"30" and current_y <= x"1AF" and current_x >= x"1B5" and current_x <= x"1B5"+border_thickness) then --vertical 7f/3f
        colorOut <= WHITE;
     end if;
     if(current_y > x"30" and current_y <= x"1AF" and current_x >= x"1E1" and current_x <= x"1E1"+border_thickness) then --vertical 7f/3f
        colorOut <= WHITE;
     end if; 
    
     else -- Off display
        colorOut <= BLUE;
    end if;      
   end process;

end behavioral;