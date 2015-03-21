----------------------------------------------------------------------------
--	GPIO_Demo.vhd -- Nexys4 GPIO/UART Demonstration Project
----------------------------------------------------------------------------
-- Author:  Marshall Wingerson Adapted from Sam Bobrowicz
--          Copyright 2013 Digilent, Inc.
----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
--	The GPIO/UART Demo project demonstrates a simple usage of the Nexys4's 
--  GPIO and UART. The behavior is as follows:
--
--	      *The 16 User LEDs are tied to the 16 User Switches. While the center
--			 User button is pressed, the LEDs are instead tied to GND
--	      *The 7-Segment display counts from 0 to 9 on each of its 8
--        digits. This count is reset when the center button is pressed.
--        Also, single anodes of the 7-Segment display are blanked by
--	       holding BTNU, BTNL, BTND, or BTNR. Holding the center button 
--        blanks all the 7-Segment anodes.
--       *An introduction message is sent across the UART when the device
--        is finished being configured, and after the center User button
--        is pressed.
--       *A message is sent over UART whenever BTNU, BTNL, BTND, or BTNR is
--        pressed.
--       *The Tri-Color LEDs cycle through several colors in a ~4 second loop
--       *Data from the microphone is collected and transmitted over the mono
--        audio out port.
--       *Note that the center user button behaves as a user reset button
--        and is referred to as such in the code comments below
--
-- All UART communication can be captured by attaching the UART port to a
-- computer running a Terminal program with 9600 Baud Rate, 8 data bits, no
-- parity, and 1 stop bit.
----------------------------------------------------------------------------
--
----------------------------------------------------------------------------
-- Revision History:
--  08/08/2011(SamB): Created using Xilinx Tools 13.2
--  08/27/2013(MarshallW): Modified for the Nexys4 with Xilinx ISE 14.4\
--  --added RGB and microphone
----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--The IEEE.std_logic_unsigned contains definitions that allow
--std_logic_vector types to be used with the + operator to instantiate a
--counter.
use IEEE.std_logic_unsigned.all;

entity GPIO_demo is
    Port ( SW   : in  STD_LOGIC_VECTOR (15 downto 0);
           BTN  : in  STD_LOGIC_VECTOR (4 downto 0);
           CLK       : in  STD_LOGIC;
           LED : out  STD_LOGIC_VECTOR (15 downto 0);
           SSEG_CA : out  STD_LOGIC_VECTOR (7 downto 0);
           SSEG_AN : out  STD_LOGIC_VECTOR (7 downto 0);
           UART_TXD     : out  STD_LOGIC;
           RGB1_Red: out  STD_LOGIC;
           RGB1_Green: out  STD_LOGIC;
           RGB1_Blue: out  STD_LOGIC;
           RGB2_Red: out  STD_LOGIC;
           RGB2_Green: out  STD_LOGIC;
           RGB2_Blue: out  STD_LOGIC;
           micClk       : out STD_LOGIC;
           micLRSel     : out STD_LOGIC;
           micData      : in STD_LOGIC;
           ampPWM       : out STD_LOGIC;
           ampSD        : out STD_LOGIC
         );
end GPIO_demo;

architecture Behavioral of GPIO_demo is

signal clk_cntr_reg : std_logic_vector (4 downto 0) := (others=>'0');

signal pwm_val_reg : std_logic := '0';

--this counter counts the amount of time paused in the UART reset state
signal reset_cntr : std_logic_vector (17 downto 0) := (others=>'0');

begin

----------------------------------------------------------
------              MIC Control                    -------
----------------------------------------------------------
--PDM data from the microphone is registered on the rising
--edge of every micClk, converting it to PWM. The PWM data
--is then connected to the mono audio out circuit, causing
--the sound captured by the microphone to be played over
--the audio out port.

process(CLK)
begin
  if (rising_edge(CLK)) then
    clk_cntr_reg <= clk_cntr_reg + 1;
  end if;
end process;

--micClk = 100MHz / 32 = 3.125 MHz
micClk <= clk_cntr_reg(4);

process(CLK)
begin
  if (rising_edge(CLK)) then
    if (clk_cntr_reg = "01111") then
      pwm_val_reg <= micData;
    end if;
  end if;
end process;

micLRSel <= '0';
ampPWM <= pwm_val_reg;
ampSD <= '1';

end Behavioral;
