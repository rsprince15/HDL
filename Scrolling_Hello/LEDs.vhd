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
--                       count_1s should refresh every 100 ms
--
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
    --
    --    H       E       L       L       O       _       P       E       n       S       A       r
    -- 0001001 0000110 1000111 1000111 1000000 1111111 0001100 0000110 0101011 0010010 0001000 0101111

	signal H : std_logic_vector(6 downto 0) := "0001001"; -- 0x09
	signal E : std_logic_vector(6 downto 0) := "0000110"; -- 0x06
	signal L : std_logic_vector(6 downto 0) := "1000111"; -- 0x47
	signal O : std_logic_vector(6 downto 0) := "1000000"; -- 0x40
	signal A : std_logic_vector(6 downto 0) := "0001000"; -- 0x08
	signal P : std_logic_vector(6 downto 0) := "0001100"; -- 0x0C
	signal n : std_logic_vector(6 downto 0) := "0101011"; -- 0x2B
	signal r : std_logic_vector(6 downto 0) := "0101111"; -- 0x2F
	signal S : std_logic_vector(6 downto 0) := "0010010"; -- 0x12
	
	signal space : std_logic_vector(6 downto 0) := "1111111"; -- 0x7f
	                                                     
	                                                     
	signal led_segments : std_logic_vector(83 downto 0) := "000100100001101000111100011110000001111111000110000001100101011001001000010000101111";
                                                         --|___H__|__E___|__L___|__L___|___0__|______|__P___|__E___|__n___|__S___|___A__|__r____|
    signal dp_i : std_logic := '1';
    
    signal seg0_i : std_logic_vector(6 downto 0) := "1111111";
    signal seg1_i : std_logic_vector(6 downto 0) := "1111111";
    signal seg2_i : std_logic_vector(6 downto 0) := "1111111";
    signal seg3_i : std_logic_vector(6 downto 0) := "1111111";
    signal seg4_i : std_logic_vector(6 downto 0) := "1111111";
    signal seg5_i : std_logic_vector(6 downto 0) := "1111111";
    signal seg6_i : std_logic_vector(6 downto 0) := "1111111";
    signal seg7_i : std_logic_vector(6 downto 0) := "1111111";
    
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
              
              -- turn on anodes
              case cnt is
                when 0      => an <= "01111111"; seg <= seg0_i;
                when 1      => an <= "10111111"; seg <= seg1_i;
                when 2      => an <= "11011111"; seg <= seg2_i;
                when 3      => an <= "11101111"; seg <= seg3_i;
                when 4      => an <= "11110111"; seg <= seg4_i;
                when 5      => an <= "11111011"; seg <= seg5_i;
                when 6      => an <= "11111101"; seg <= seg6_i;
                when 7      => an <= "11111110"; seg <= seg7_i;
                when others => an <= "11111111"; seg <= space;
              end case;
           
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
                    cnt_1s <= 0;
           elsif (count_1s mod 25000000) = 0 then
                    count_1s <= count_1s + 1;
                    cnt_1s <= cnt_1s + 1;
                    
                    case cnt_1s is
                        when 0      => seg0_i <= space; seg1_i <= space; seg2_i <= space; seg3_i <= space; seg4_i <= space; seg5_i <= space; seg6_i <= space; seg7_i <= space;
                        when 1      => seg0_i <= space; seg1_i <= space; seg2_i <= space; seg3_i <= space; seg4_i <= space; seg5_i <= space; seg6_i <= space; seg7_i <= H;
                        when 2      => seg0_i <= space; seg1_i <= space; seg2_i <= space; seg3_i <= space; seg4_i <= space; seg5_i <= space; seg6_i <= H;     seg7_i <= E;
                        when 3      => seg0_i <= space; seg1_i <= space; seg2_i <= space; seg3_i <= space; seg4_i <= space; seg5_i <= H;     seg6_i <= E;     seg7_i <= L;
                        when 4      => seg0_i <= space; seg1_i <= space; seg2_i <= space; seg3_i <= space; seg4_i <= H;     seg5_i <= E;     seg6_i <= L;     seg7_i <= L;
                        when 5      => seg0_i <= space; seg1_i <= space; seg2_i <= space; seg3_i <= H;     seg4_i <= E;     seg5_i <= L;     seg6_i <= L;     seg7_i <= O;
                        when 6      => seg0_i <= space; seg1_i <= space; seg2_i <= H;     seg3_i <= E;     seg4_i <= L;     seg5_i <= L;     seg6_i <= O;     seg7_i <= space;
                        when 7      => seg0_i <= space; seg1_i <= H;     seg2_i <= E;     seg3_i <= L;     seg4_i <= L;     seg5_i <= O;     seg6_i <= space; seg7_i <= P;
                        when 8      => seg0_i <= H;     seg1_i <= E;     seg2_i <= L;     seg3_i <= L;     seg4_i <= O;     seg5_i <= space; seg6_i <= P;     seg7_i <= E;
                        when 9      => seg0_i <= E;     seg1_i <= L;     seg2_i <= L;     seg3_i <= O;     seg4_i <= space; seg5_i <= P;     seg6_i <= E;     seg7_i <= n;
                        when 10     => seg0_i <= L;     seg1_i <= L;     seg2_i <= O;     seg3_i <= space; seg4_i <= P;     seg5_i <= E;     seg6_i <= n;     seg7_i <= S;
                        when 11     => seg0_i <= L;     seg1_i <= O;     seg2_i <= space; seg3_i <= P;     seg4_i <= E;     seg5_i <= n;     seg6_i <= S;     seg7_i <= A;
                        when 12     => seg0_i <= O;     seg1_i <= space; seg2_i <= P;     seg3_i <= E;     seg4_i <= n;     seg5_i <= S;     seg6_i <= A;     seg7_i <= r;
                        when 13     => seg0_i <= space; seg1_i <= P;     seg2_i <= E;     seg3_i <= n;     seg4_i <= S;     seg5_i <= A;     seg6_i <= r;     seg7_i <= space;
                        when 14     => seg0_i <= P;     seg1_i <= E;     seg2_i <= n;     seg3_i <= S;     seg4_i <= A;     seg5_i <= r;     seg6_i <= space; seg7_i <= space;
                        when 15     => seg0_i <= E;     seg1_i <= n;     seg2_i <= S;     seg3_i <= A;     seg4_i <= r;     seg5_i <= space; seg6_i <= space; seg7_i <= space;
                        when 16     => seg0_i <= n;     seg1_i <= S;     seg2_i <= A;     seg3_i <= r;     seg4_i <= space; seg5_i <= space; seg6_i <= space; seg7_i <= space;
                        when 17     => seg0_i <= S;     seg1_i <= A;     seg2_i <= r;     seg3_i <= space; seg4_i <= space; seg5_i <= space; seg6_i <= space; seg7_i <= space;
                        when 18     => seg0_i <= A;     seg1_i <= r;     seg2_i <= space; seg3_i <= space; seg4_i <= space; seg5_i <= space; seg6_i <= space; seg7_i <= space;
                        when 19     => seg0_i <= r;     seg1_i <= space; seg2_i <= space; seg3_i <= space; seg4_i <= space; seg5_i <= space; seg6_i <= space; seg7_i <= space;
                        when 20     => seg0_i <= space; seg1_i <= space; seg2_i <= space; seg3_i <= space; seg4_i <= space; seg5_i <= space; seg6_i <= space; seg7_i <= space;
                        when others => seg0_i <= space; seg1_i <= space; seg2_i <= space; seg3_i <= space; seg4_i <= space; seg5_i <= space; seg6_i <= space; seg7_i <= space;
                   end case;     
           else 
                    count_1s <= count_1s + 1;
           end if;
      end if;
   end process clockDivider_1s;

end behavioral;
