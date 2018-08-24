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
--                       count should increment every 1 ms / 8
--                       count should refresh every 1 ms
--                       count_1s should increment every 25 ms
--                       count_1s should refresh every 500 ms
-- bits
-- 6  5  4  3  2  1  0
-- CG CF CE CD CC CB CA
--
--    ----- 
--   |  A  |
--   |F   B|
--   |     |
--    ----- 
--   |  G  |
--   |E   C|
--   |  D  |
--    -----
--
--    H       E       L       L       O       _       P       E       n       S       A       r
-- 0001001 0000110 1000111 1000111 1000000 1111111 0001100 0000110 0101011 0010010 0001000 0101111
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity LEDs is
	port(   
	        clk  : in std_logic;
			dp   : out std_logic;
			seg  : out std_logic_vector (6 downto 0);
	        an   : out std_logic_vector (7 downto 0)
	    );
end LEDs;

architecture Behavioral of LEDs is	

	CONSTANT H     : std_logic_vector(6 downto 0) := "0001001"; -- 0x09
	CONSTANT E     : std_logic_vector(6 downto 0) := "0000110"; -- 0x06
	CONSTANT L     : std_logic_vector(6 downto 0) := "1000111"; -- 0x47
	CONSTANT O     : std_logic_vector(6 downto 0) := "1000000"; -- 0x40
	CONSTANT A     : std_logic_vector(6 downto 0) := "0001000"; -- 0x08
	CONSTANT P     : std_logic_vector(6 downto 0) := "0001100"; -- 0x0C
	CONSTANT n     : std_logic_vector(6 downto 0) := "0101011"; -- 0x2B
	CONSTANT r     : std_logic_vector(6 downto 0) := "0101111"; -- 0x2F
	CONSTANT S     : std_logic_vector(6 downto 0) := "0010010"; -- 0x12
	CONSTANT space : std_logic_vector(6 downto 0) := "1111111"; -- 0x7f
     	                                                     
	type segments is array (25 downto 0) of std_logic_vector(6 downto 0);                                                     
	signal led_segments : segments := (space,space,space,space,space,space,space,
	                                   r,A,n,E,P,space,O,L,L,E,H,
	                                   space,space,space,space,space,space,space,space); 
	
    signal dp_i : std_logic := '1';

    type anodes is array (8 downto 0) of std_logic_vector(7 downto 0);    
    signal an_i : anodes := ("11111110", 
                             "11111101", 
                             "11111011", 
                             "11110111", 
                             "11101111",  
                             "11011111",
                             "10111111", 
                             "01111111",
                             "11111111"); 
   
    signal cnt      : integer := 0;
    signal cnt_1s   : integer := 0;
    signal count    : integer := 0;
    signal count_1s : integer := 0;
	
begin
    dp <= dp_i;
     
  -- refresh 7-seg every 1 ms.
  clockDivider_10ms: process(clk)
   begin
      if falling_edge(clk) and clk = '0' then
           
           if count = 999999 then
              count <= 0;
              cnt   <= 0;
              an    <= "01111111";
           elsif (count mod 125000) = 0 then
              
              count <= count + 1;
              cnt   <= cnt + 1;
              an <= an_i(cnt);
              seg <= led_segments(cnt+cnt_1s);
              
           else 
              count <= count + 1;
           end if;
           
      end if;
   end process clockDivider_10ms;

  -- refresh pattern every 25ms
  clockDivider_1s: process(clk)
   begin
      if falling_edge(clk) and clk = '0' then
           if count_1s = 499999999 then
                    count_1s <= 0;
                    cnt_1s   <= 0;
           elsif (count_1s mod 25000000) = 0 then
                    count_1s <= count_1s + 1;
                    cnt_1s   <= cnt_1s + 1;      
           else 
                    count_1s <= count_1s + 1;
           end if;
      end if;
   end process clockDivider_1s;

end behavioral;
