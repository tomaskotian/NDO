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
entity column_read_tb is
end column_read_tb;
----------------------------------------------------------------------------------
architecture Behavioral of column_read_tb is
    component column_read is
        port(
            clk_in    : in STD_LOGIC; 
            column_in : in STD_LOGIC_VECTOR(3 downto 0);
            column_out : out STD_LOGIC_VECTOR(3 downto 0);
            led_out    : out STD_LOGIC
        );
    end component;

    constant clk_period : time := 10 ns;

    signal clk_s : STD_LOGIC := '0';
    signal column_in_s : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal column_out_s : STD_LOGIC_VECTOR(3 downto 0);
    signal led_out_s : STD_LOGIC;

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
        column_in_s <= "0000";
        wait for 50 ns;
        column_in_s <= "1000";
        wait for 50 ns;
        column_in_s <= "0100";
        wait for 50 ns;
        column_in_s <= "0010";
        wait for 50 ns;
        column_in_s <= "0101";
        wait for 50 ns;
        column_in_s <= "0000";
        wait for 50 ns;
        column_in_s <= "1001";
        wait for 50 ns;

    end process;

    --column read
    column_read_i : column_read
    port map(
        clk_in => clk_s,
        column_in => column_in_s,
        column_out => column_out_s,
        led_out    => led_out_s
    );

end Behavioral;

