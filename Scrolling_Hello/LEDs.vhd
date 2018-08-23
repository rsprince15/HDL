----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:57:25 02/15/2014 
-- Design Name: 
-- Module Name:    LEDs - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.std_logic_unsigned.all;

entity LEDs is
	port(   
	        clk  : in std_logic;
			dp   : out std_logic;
			seg  : out std_logic_vector (6 downto 0);
	        an   : out std_logic_vector (7 downto 0)
	    );
end LEDs;

architecture Behavioral of LEDs is
	signal dp_i : std_logic := '1';
	
	-- bits
	-- 6  5  4  3  2  1  0
	-- CG CF CE CD CC CB CA --
	
	--    ----- 
	--   |  A  |
	--   |F   B|
	--   |     |
	--    ----- 
  --   |  G  |
  --   |E   C|
  --   |  D  |
  --    -----
    
	signal H : std_logic_vector(6 downto 0) := "0001001";
	signal E : std_logic_vector(6 downto 0) := "0000110";
	signal L : std_logic_vector(6 downto 0) := "1000111";
	signal O : std_logic_vector(6 downto 0) := "1000000";
	signal A : std_logic_vector(6 downto 0) := "0001000";
	signal P : std_logic_vector(6 downto 0) := "0001100";
	signal n : std_logic_vector(6 downto 0) := "0101011";
	signal r : std_logic_vector(6 downto 0) := "0101111";
	signal S : std_logic_vector(6 downto 0) := "0010010";
	
	signal space : std_logic_vector(6 downto 0) := "1111111";
    
	signal one    : std_logic_vector(7 downto 0) := "01111111";
	signal two    : std_logic_vector(7 downto 0) := "10111111";
	signal three  : std_logic_vector(7 downto 0) := "11011111";
	signal four   : std_logic_vector(7 downto 0) := "11101111";
	signal five   : std_logic_vector(7 downto 0) := "11110111";
	signal six    : std_logic_vector(7 downto 0) := "11111011";
	signal seven  : std_logic_vector(7 downto 0) := "11111101";
	signal eight  : std_logic_vector(7 downto 0) := "11111110";
	
	signal all_an  : std_logic_vector(7 downto 0) := "00000000";
    signal cnt : integer := 0;
    signal cnt_1s : integer := 0;
    signal count : integer := 0;
    signal count_1s : integer := 0;
	--signal cnt: std_logic_vector(19 downto 0); -- divider counter for ~95.3Hz refresh rate (with 100MHz main clock)
	
begin
  --clk_slow <= clk / 1000000;
  
  -- refresh 7-seg every 10 ms
  clockDivider_10ms: process(clk)
   begin
      if clk'event and clk = '1' then
           --cnt <= "001";
           if count > 1000000 then
              count <= 0;
              cnt <= 0;
           elsif (count mod 125000) = 0 then
              count <= count + 1;
              cnt <= cnt + 1;
           else 
              count <= count + 1;
           end if;
      end if;
   end process clockDivider_10ms;

  -- refresh pattern every 5s
  clockDivider_1s: process(clk)
   begin
      if clk'event and clk = '1' then
           if count_1s > 500000000 then
                    count_1s <= 0;
                    cnt_1s <= 0;
           elsif (count_1s mod 25000000) = 0 then
                    count_1s <= count_1s + 1;
                    cnt_1s <= cnt_1s + 1;
           else 
                    count_1s <= count_1s + 1;
           end if;
      end if;
   end process clockDivider_1s;


	process(count)
	begin
       dp <= dp_i;

       case cnt_1s is
        when 1 =>
          case cnt is
          when 1 => 
              seg <= space;
              an  <= one;
          when 2 => 
              seg <= space;
              an  <= two;
          when 3 => 
              seg <= space;
              an  <= three;
          when 4 => 
              seg <= space;
              an  <= four;
          when 5 => 
              seg <= space;
              an  <= five;
          when 6 => 
              seg <= space;
              an  <= six;
          when 7 =>  
              seg <= space;
              an  <= seven;
          when 8 => 
              seg <= H;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 2 =>
          case cnt is
          when 1 => 
              seg <= space;
              an  <= one;
          when 2 => 
              seg <= space;
              an  <= two;
          when 3 => 
              seg <= space;
              an  <= three;
          when 4 => 
              seg <= space;
              an  <= four;
          when 5 => 
              seg <= space;
              an  <= five;
          when 6 => 
              seg <= space;
              an  <= six;
          when 7 =>  
              seg <= H;
              an  <= seven;
          when 8 => 
              seg <= E;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;

        when 3 =>
          case cnt is
          when 1 => 
              seg <= space;
              an  <= one;
          when 2 => 
              seg <= space;
              an  <= two;
          when 3 => 
              seg <= space;
              an  <= three;
          when 4 => 
              seg <= space;
              an  <= four;
          when 5 => 
              seg <= space;
              an  <= five;
          when 6 => 
              seg <= H;
              an  <= six;
          when 7 =>  
              seg <= E;
              an  <= seven;
          when 8 => 
              seg <= L;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 4 =>
          case cnt is
          when 1 => 
              seg <= space;
              an  <= one;
          when 2 => 
              seg <= space;
              an  <= two;
          when 3 => 
              seg <= space;
              an  <= three;
          when 4 => 
              seg <= space;
              an  <= four;
          when 5 => 
              seg <= H;
              an  <= five;
          when 6 => 
              seg <= E;
              an  <= six;
          when 7 =>  
              seg <= L;
              an  <= seven;
          when 8 => 
              seg <= L;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 5 =>
          case cnt is
          when 1 => 
              seg <= space;
              an  <= one;
          when 2 => 
              seg <= space;
              an  <= two;
          when 3 => 
              seg <= space;
              an  <= three;
          when 4 => 
              seg <= H;
              an  <= four;
          when 5 => 
              seg <= E;
              an  <= five;
          when 6 => 
              seg <= L;
              an  <= six;
          when 7 =>  
              seg <= L;
              an  <= seven;
          when 8 => 
              seg <= O;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 6 =>
          case cnt is
          when 1 => 
              seg <= space;
              an  <= one;
          when 2 => 
              seg <= space;
              an  <= two;
          when 3 => 
              seg <= H;
              an  <= three;
          when 4 => 
              seg <= E;
              an  <= four;
          when 5 => 
              seg <= L;
              an  <= five;
          when 6 => 
              seg <= L;
              an  <= six;
          when 7 =>  
              seg <= O;
              an  <= seven;
          when 8 => 
              seg <= space;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 7 =>
          case cnt is
          when 1 => 
              seg <= space;
              an  <= one;
          when 2 => 
              seg <= H;
              an  <= two;
          when 3 => 
              seg <= E;
              an  <= three;
          when 4 => 
              seg <= L;
              an  <= four;
          when 5 => 
              seg <= L;
              an  <= five;
          when 6 => 
              seg <= O;
              an  <= six;
          when 7 =>  
              seg <= space;
              an  <= seven;
          when 8 => 
              seg <= space;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 8 =>
          case cnt is
          when 1 => 
              seg <= H;
              an  <= one;
          when 2 => 
              seg <= E;
              an  <= two;
          when 3 => 
              seg <= L;
              an  <= three;
          when 4 => 
              seg <= L;
              an  <= four;
          when 5 => 
              seg <= O;
              an  <= five;
          when 6 => 
              seg <= space;
              an  <= six;
          when 7 =>  
              seg <= P;
              an  <= seven;
          when 8 => 
              seg <= E;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
          
        when 9 =>
          case cnt is
          when 1 => 
              seg <= E;
              an  <= one;
          when 2 => 
              seg <= L;
              an  <= two;
          when 3 => 
              seg <= L;
              an  <= three;
          when 4 => 
              seg <= O;
              an  <= four;
          when 5 => 
              seg <= space;
              an  <= five;
          when 6 => 
              seg <= P;
              an  <= six;
          when 7 =>  
              seg <= E;
              an  <= seven;
          when 8 => 
              seg <= n;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 10 =>
          case cnt is
          when 1 => 
              seg <= L;
              an  <= one;
          when 2 => 
              seg <= L;
              an  <= two;
          when 3 => 
              seg <= O;
              an  <= three;
          when 4 => 
              seg <= space;
              an  <= four;
          when 5 => 
              seg <= P;
              an  <= five;
          when 6 => 
              seg <= E;
              an  <= six;
          when 7 =>  
              seg <= n;
              an  <= seven;
          when 8 => 
              seg <= S;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 11 =>
          case cnt is
          when 1 => 
              seg <= L;
              an  <= one;
          when 2 => 
              seg <= O;
              an  <= two;
          when 3 => 
              seg <= space;
              an  <= three;
          when 4 => 
              seg <= P;
              an  <= four;
          when 5 => 
              seg <= E;
              an  <= five;
          when 6 => 
              seg <= n;
              an  <= six;
          when 7 =>  
              seg <= S;
              an  <= seven;
          when 8 => 
              seg <= A;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 12 =>
          case cnt is
          when 1 => 
              seg <= O;
              an  <= one;
          when 2 => 
              seg <= space;
              an  <= two;
          when 3 => 
              seg <= P;
              an  <= three;
          when 4 => 
              seg <= E;
              an  <= four;
          when 5 => 
              seg <= n;
              an  <= five;
          when 6 => 
              seg <= S;
              an  <= six;
          when 7 =>  
              seg <= A;
              an  <= seven;
          when 8 => 
              seg <= r;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 13 =>
          case cnt is
          when 1 => 
              seg <= space;
              an  <= one;
          when 2 => 
              seg <= P;
              an  <= two;
          when 3 => 
              seg <= E;
              an  <= three;
          when 4 => 
              seg <= n;
              an  <= four;
          when 5 => 
              seg <= S;
              an  <= five;
          when 6 => 
              seg <= A;
              an  <= six;
          when 7 =>  
              seg <= R;
              an  <= seven;
          when 8 => 
              seg <= space;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 14 =>
          case cnt is
          when 1 => 
              seg <= P;
              an  <= one;
          when 2 => 
              seg <= E;
              an  <= two;
          when 3 => 
              seg <= n;
              an  <= three;
          when 4 => 
              seg <= S;
              an  <= four;
          when 5 => 
              seg <= A;
              an  <= five;
          when 6 => 
              seg <= R;
              an  <= six;
          when 7 =>  
              seg <= space;
              an  <= seven;
          when 8 => 
              seg <= space;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 15 =>
          case cnt is
          when 1 => 
              seg <= E;
              an  <= one;
          when 2 => 
              seg <= n;
              an  <= two;
          when 3 => 
              seg <= S;
              an  <= three;
          when 4 => 
              seg <= A;
              an  <= four;
          when 5 => 
              seg <= r;
              an  <= five;
          when 6 => 
              seg <= space;
              an  <= six;
          when 7 =>  
              seg <= space;
              an  <= seven;
          when 8 => 
              seg <= space;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 16 =>
          case cnt is
          when 1 => 
              seg <= n;
              an  <= one;
          when 2 => 
              seg <= S;
              an  <= two;
          when 3 => 
              seg <= A;
              an  <= three;
          when 4 => 
              seg <= r;
              an  <= four;
          when 5 => 
              seg <= space;
              an  <= five;
          when 6 => 
              seg <= space;
              an  <= six;
          when 7 =>  
              seg <= space;
              an  <= seven;
          when 8 => 
              seg <= space;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 17 =>
          case cnt is
          when 1 => 
              seg <= S;
              an  <= one;
          when 2 => 
              seg <= A;
              an  <= two;
          when 3 => 
              seg <= r;
              an  <= three;
          when 4 => 
              seg <= space;
              an  <= four;
          when 5 => 
              seg <= space;
              an  <= five;
          when 6 => 
              seg <= space;
              an  <= six;
          when 7 =>  
              seg <= space;
              an  <= seven;
          when 8 => 
              seg <= space;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 18 =>
          case cnt is
          when 1 => 
              seg <= A;
              an  <= one;
          when 2 => 
              seg <= r;
              an  <= two;
          when 3 => 
              seg <= space;
              an  <= three;
          when 4 => 
              seg <= space;
              an  <= four;
          when 5 => 
              seg <= space;
              an  <= five;
          when 6 => 
              seg <= space;
              an  <= six;
          when 7 =>  
              seg <= space;
              an  <= seven;
          when 8 => 
              seg <= space;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
        when 19 =>
          case cnt is
          when 1 => 
              seg <= r;
              an  <= one;
          when 2 => 
              seg <= space;
              an  <= two;
          when 3 => 
              seg <= space;
              an  <= three;
          when 4 => 
              seg <= space;
              an  <= four;
          when 5 => 
              seg <= space;
              an  <= five;
          when 6 => 
              seg <= space;
              an  <= six;
          when 7 =>  
              seg <= space;
              an  <= seven;
          when 8 => 
              seg <= space;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
       when 20 =>
          case cnt is
          when 1 => 
              seg <= space;
              an  <= one;
          when 2 => 
              seg <= space;
              an  <= two;
          when 3 => 
              seg <= space;
              an  <= three;
          when 4 => 
              seg <= space;
              an  <= four;
          when 5 => 
              seg <= space;
              an  <= five;
          when 6 => 
              seg <= space;
              an  <= six;
          when 7 =>  
              seg <= space;
              an  <= seven;
          when 8 => 
              seg <= space;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;

        -- Empty 
        when others =>
          case cnt is
          when 1 => 
              seg <= space;
              an  <= one;
          when 2 => 
              seg <= space;
              an  <= two;
          when 3 => 
              seg <= space;
              an  <= three;
          when 4 => 
              seg <= space;
              an  <= four;
          when 5 => 
              seg <= space;
              an  <= five;
          when 6 => 
              seg <= space;
              an  <= six;
          when 7 =>  
              seg <= space;
              an  <= seven;
          when 8 => 
              seg <= space;
              an  <= eight;
          when others =>
              seg <= space;
              an  <= eight;
          end case;
       end case;
	end process;
end behavioral;

