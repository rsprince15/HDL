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
	signal H : std_logic_vector(7 downto 0) := "10001001";
	signal E : std_logic_vector(7 downto 0) := "10000110";
	signal L : std_logic_vector(7 downto 0) := "11000111";
	signal O : std_logic_vector(7 downto 0) := "11000000";
	signal A : std_logic_vector(7 downto 0) := "10001000";
	signal D : std_logic_vector(7 downto 0) := "10100001";
	signal Y : std_logic_vector(7 downto 0) := "10011001";
    
	signal one    : std_logic_vector(7 downto 0) := "01111111";
	signal two    : std_logic_vector(7 downto 0) := "10111111";
	signal three  : std_logic_vector(7 downto 0) := "11011111";
	signal four   : std_logic_vector(7 downto 0) := "11101111";
	signal five   : std_logic_vector(7 downto 0) := "11110111";
	signal six    : std_logic_vector(7 downto 0) := "11111011";
	signal seven  : std_logic_vector(7 downto 0) := "11111101";
	signal eight  : std_logic_vector(7 downto 0) := "11111110";

	--signal cnt: std_logic_vector(19 downto 0); -- divider counter for ~95.3Hz refresh rate (with 100MHz main clock)
	
begin

  -- clockDivider: process(clk)
  -- begin
   --    if clk'event and clk = '1' then
  --         cnt <= cnt + '1';
  --     end if;
  -- end process clockDivider;

	process(clk)
		variable count : integer := 0;
	begin
        --while not btnC loop
			if count = 0 then
				seg <= H(6 downto 0); --h
				dp <= H(7);
				an <= one;
				count := count + 1;
				--wait until clk = '1';
			elsif count = 1 then
				seg <= E(6 downto 0); --e
                dp <= H(7);
                an <= two;
				count := count + 1;
				--wait until clk = '1';
			elsif count = 2 then
				seg <= L(6 downto 0); --l
				dp <= H(7);
				an <= three;
				count := count + 1;
				--wait until clk = '1';
			elsif count = 3 then
				seg <= L(6 downto 0); --l
				dp <= H(7);
				an <= four;
				count := count + 1;
				--wait until clk = '1';
			elsif count = 4 then
				seg <= O(6 downto 0); --o
				dp <= H(7);
				an <= five;
				count := count + 1;
				--wait until clk = '1';
			elsif count = 5 then
				seg <= "1111111"; --space
				dp <= H(7);
				an <= six;
				count := count + 1;
				--wait until clk = '1';
			elsif count = 6 then
				seg <= L(6 downto 0); --l
				dp <= H(7);
				an <= seven;
				count := count + 1;
				--wait until clk = '1';
			elsif count = 7 then
				seg <= A(6 downto 0); --a
				dp <= H(7);
				an <= eight;
				count := 0;
				--wait until clk = '1';
			end if;
	--	wait until clk = '1';
	end process;
end behavioral;

