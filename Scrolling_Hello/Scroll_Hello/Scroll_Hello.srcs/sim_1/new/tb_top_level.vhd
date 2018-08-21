LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY tb IS
END tb;

ARCHITECTURE behavior OF tb IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT LEDs
    PORT(
         clk : IN  std_logic;
         dp   : out std_logic;
         seg : OUT  std_logic_vector(6 downto 0);
         an : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;


   --Inputs
   signal clk : std_logic := '0';
        --Outputs
   signal seg : std_logic_vector(6 downto 0);
   signal an : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
BEGIN

        -- Instantiate the Unit Under Test (UUT)
   uut: LEDs PORT MAP (
          clk => clk,
          seg => seg,
          an => an
        );

   -- Clock process definitions
   clk_process :process
   begin
                clk <= '0';
                wait for clk_period/2;
                clk <= '1';
                wait for clk_period/2;
   end process;


   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
