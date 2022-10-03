----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
entity debouncer_tb is
end debouncer_tb;
----------------------------------------------------------------------------------
architecture Behavioral of debouncer_tb is
    component debouncer is
        generic(
            period : positive := 1    
        );
        port(
            clk         : in std_logic;
            ce          : in std_logic; --1.6ms/20ns=80000, 10us doba kmitu dole
            button_in   : in std_logic;
            button_out  : out std_logic
        );
    end component;

    constant clk_periode : time := 20 ns;
    signal clk_s : std_logic;
    signal button_in_s : std_logic;
    signal button_out_s : std_logic;
    signal ce_s : std_logic;
----------------------------------------------------------------------------------
    begin

        debouncer_i : debouncer
        generic map(
            period => 2   --1.6ms/20ns=80000
        )
        port map(
            clk         => clk_s,
            ce          => ce_s,
            button_in   => button_in_s,
            button_out  => button_out_s
        );

        gen_clk : process
            begin
                clk_s <= '0';
                wait for clk_periode/2;
                clk_s <= '1';
                wait for clk_periode/2;
        end process;
        
        gen_ce : process
            begin
                ce_s <= '0';
                wait for clk_periode;
                ce_s <= '1';
                wait for clk_periode;
        end process;

        process 
            begin
                button_in_s <= '0';
                wait for 30 ns;
                button_in_s <= '1';
                wait for 15 ns;
                button_in_s <= '0';
                wait for 5 ns;
                button_in_s <= '1';
                wait for 200 ns;
                button_in_s <= '0';

        end process;

end Behavioral;
