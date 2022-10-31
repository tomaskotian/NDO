----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2022 16:41:35
-- Design Name: 
-- Module Name: jk - Behavioral
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
entity jk is
    port(   clk : in    std_logic;
            J   : in    std_logic;
            K   : in    std_logic;
            Q   : out   std_logic;
            QB  : out   std_logic);
end jk;
----------------------------------------------------------------------------------
architecture Behavioral of jk is
signal temp : std_logic := '0';
----------------------------------------------------------------------------------
    begin
        process (clk) begin
            if rising_edge(clk) then
                if J = '0' and K = '0' then
                    temp <= temp;
                elsif J = '0' and K = '1' then
                    temp <= '0';
                elsif J = '1' and K = '0' then
                    temp <= '1';
                elsif J = '1' and K = '1' then
                    temp <=  not temp;                 
                end if;
            end if;
        end process;
        Q <= temp;
        QB <= not temp;

end Behavioral;
