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
entity bcd_7_seg_tb is
end bcd_7_seg_tb;
----------------------------------------------------------------------------------
architecture Behavioral of bcd_7_seg_tb is
    component bcd_7_seg is
        port(
            en            : in STD_LOGIC; 
            row_in        : in STD_LOGIC_VECTOR(3 downto 0);
            column_in     : in STD_LOGIC_VECTOR(3 downto 0);
            segment_out   : out STD_LOGIC_VECTOR(7 downto 0);
            segment_anode : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    constant clk_period : time := 10 ns;

    signal en_s : STD_LOGIC;
    signal row_in_s : STD_LOGIC_VECTOR(3 downto 0);
    signal column_in_s : STD_LOGIC_VECTOR(3 downto 0);
    signal segment_out_s : STD_LOGIC_VECTOR(7 downto 0);
    signal segment_anode_s : STD_LOGIC_VECTOR(3 downto 0);

----------------------------------------------------------------------------------
    begin
    --signals for all columns and rows
    matrix_gen : process
    begin
        row_in_s <=  "0001";

        column_in_s <= "0000";
        wait for clk_period;
        column_in_s <= "0001";
        wait for clk_period;
        column_in_s <= "0010";
        wait for clk_period;
        column_in_s <= "0100";
        wait for clk_period;
        column_in_s <= "1000";
        wait for clk_period;
        column_in_s <= "0001";
        wait for clk_period;
        column_in_s <= "0010";
        wait for clk_period;

    end process;

    enable : process
    begin
        en_s <= '0';
        wait for 50 ns;
        en_s <= '1'; 
        wait;    
    end process;

    --7 segment driver
    bcd_7_seg_i : bcd_7_seg
    port map(
        en            => en_s,
        row_in        => row_in_s,
        column_in     => column_in_s,
        segment_out   => segment_out_s,
        segment_anode => segment_anode_s
    );

end Behavioral;

