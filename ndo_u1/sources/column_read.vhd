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
entity column_read is
    port(
        clk_in     : in STD_LOGIC; -- 1khz
        column_in  : in STD_LOGIC_VECTOR(3 downto 0);
        column_out : out STD_LOGIC_VECTOR(3 downto 0) := "0000";
        led_out    : out STD_LOGIC
    );
end column_read;
----------------------------------------------------------------------------------
architecture Behavioral of column_read is 
    signal reg_column_s : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    ----------------------------------------------------------------------------------
        begin
    
            process (clk_in) begin
                if rising_edge(clk_in) then
                    reg_column_s <= column_in;
                end if;        
            end process;
    
            process (reg_column_s) begin
                if reg_column_s(0) = '1' then 
                    column_out <= "0001";
                    led_out <= '1';
                elsif reg_column_s(1)  = '1' then
                    column_out <= "0010";
                    led_out <= '1';
                elsif reg_column_s(2)  = '1' then
                    column_out <= "0100";
                    led_out <= '1';
                elsif reg_column_s(3)  = '1' then
                    column_out <= "1000";
                    led_out <= '1';
                else
                    column_out <= "0000";
                    led_out <= '0';
                end if;
            end process;
    
end Behavioral;

