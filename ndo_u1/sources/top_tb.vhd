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
entity top_tb is
end top_tb;
----------------------------------------------------------------------------------
architecture Structural of top_tb is

    component top is
        port(
            clk_in          : in  STD_LOGIC;                        -- 50Mhz
            row_out         : out STD_LOGIC_VECTOR(3 downto 0);
            column_in       : in  STD_LOGIC_VECTOR(3 downto 0);
            segment_out     : out STD_LOGIC_VECTOR(7 downto 0);     -- cathode 0 light
            digit_segment   : out STD_LOGIC_VECTOR(3 downto 0);      -- 0 light
            led_out         : out  STD_LOGIC
        );
    end component;

    constant clk_period : time := 20 ns;

    signal clk_s         : STD_LOGIC;
    signal row_out_s     : STD_LOGIC_VECTOR(3 downto 0);
    signal column_in_s   : STD_LOGIC_VECTOR(3 downto 0);
    signal segment_out_s : STD_LOGIC_VECTOR(7 downto 0);
    signal digit_segment : STD_LOGIC_VECTOR(3 downto 0);
    signal led_out_s     : STD_LOGIC;

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
            wait for 100 ns;
            column_in_s <= "1000";
            wait for 100 ns;
            column_in_s <= "0100";
            wait for 100 ns;
            column_in_s <= "0010";
            wait for 100 ns;
            column_in_s <= "0101";
            wait for 100 ns;
            column_in_s <= "0000";
            wait for 100 ns;
            column_in_s <= "1001";
            wait for 100 ns;
    
        end process;
        
        -- top
        top_i : top 
        port map(
            clk_in          => clk_s,
            row_out         => row_out_s,
            column_in       => column_in_s,
            segment_out     => segment_out_s,
            digit_segment   => digit_segment,
            led_out         => led_out_s
        );

end Structural;

