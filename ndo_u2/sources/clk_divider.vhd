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
entity clk_divider is
    generic(
        div_factor : positive := 5
    );
    port(
        clk_in : in STD_LOGIC;
        clk_out : out STD_LOGIC
    );
end clk_divider;
----------------------------------------------------------------------------------
architecture Behavioral of clk_divider is
    signal cnt : positive := 1;
----------------------------------------------------------------------------------
begin
    process (clk_in) begin
        if rising_edge(clk_in) then
            if cnt = div_factor then
                cnt <= 1;
                clk_out <= '1';
            else
                cnt <= cnt + 1;
                clk_out <= '0';
            end if;
        end if;
    end process;
end Behavioral;
