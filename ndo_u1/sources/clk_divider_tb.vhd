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
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
entity clk_divider_tb is
end clk_divider_tb;
----------------------------------------------------------------------------------
architecture Behavioral of clk_divider_tb is
    component clk_divider is 
        generic(
            div_factor : positive := 5
        );
        port(clk_in : in STD_LOGIC;
            clk_out : out STD_LOGIC);
    end component;

    constant clk_period : time := 20 ns;

    signal clk_s : STD_LOGIC;
    
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

        --clk divider
        clk_divider_i : clk_divider
        generic map(
            div_factor => 5
        )
        port map(
            clk_in => clk_s
        );
end Behavioral;