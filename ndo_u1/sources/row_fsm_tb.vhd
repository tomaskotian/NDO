----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.09.2022 10:25:47
-- Design Name: 
-- Module Name: clk_divider - Behavioral
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
----------------------------------------------------------------------------------
entity row_fsm_tb is
end row_fsm_tb;
----------------------------------------------------------------------------------
architecture Behavioral of row_fsm_tb is
    component row_fsm is
        port(
            clk_in : in STD_LOGIC;
            row    : out STD_LOGIC_VECTOR(3 downto 0);
            column : in STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    constant clk_period : time := 10 ns;

    signal clk_s : STD_LOGIC := '0';
    signal row_s : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal column_s : STD_LOGIC_VECTOR(3 downto 0);

----------------------------------------------------------------------------------
    begin

    --clk generator
    clk_gen : process
    begin
        clk_s <= '0';
        wait for clk_period/2;
        clk_s <= '1';
        wait for clk_period/2;
    end process;

    --signal column
    column_gen : process
    begin
        column_s <= "0000";
        wait for 50 ns;
        column_s <= "1000";
        wait for 50 ns;
        column_s <= "0100";
        wait for 50 ns;
        column_s <= "0010";
        wait for 50 ns;
        column_s <= "0001";
        wait for 50 ns;
        column_s <= "0000";
        wait for 50 ns;
        column_s <= "1001";
        wait for 50 ns;

    end process;

    --row fsm
    row_fsm_i : row_fsm
    port map(
        clk_in => clk_s,
        row => row_s,
        column => column_s
    );

end Behavioral;

