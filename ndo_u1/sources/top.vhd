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
entity top is
    port(
        clk_in          : in  STD_LOGIC;                        -- 50Mhz   
        row_out         : out STD_LOGIC_VECTOR(3 downto 0);
        column_in       : in  STD_LOGIC_VECTOR(3 downto 0);
        segment_out     : out STD_LOGIC_VECTOR(7 downto 0);     -- cathode 0 light
        digit_segment   : out STD_LOGIC_VECTOR(3 downto 0);     -- 0 light
        led_out         : out  STD_LOGIC
    );
end top;
----------------------------------------------------------------------------------
architecture Structural of top is

    component clk_divider is 
        generic(
            div_factor : positive := 5
        );
        port(
            clk_in : in STD_LOGIC;
            clk_out : out STD_LOGIC);
    end component;

    component row_fsm is
        port(
            clk_in : in STD_LOGIC; --1khz
            row    : out STD_LOGIC_VECTOR(3 downto 0);
            column : in STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component column_read is
        port(
            clk_in    : in STD_LOGIC; 
            column_in : in STD_LOGIC_VECTOR(3 downto 0);
            column_out : out STD_LOGIC_VECTOR(3 downto 0);
            led_out    : out STD_LOGIC
        );
    end component;

    component bcd_7_seg is
        port(
            en            : in STD_LOGIC; 
            row_in        : in STD_LOGIC_VECTOR(3 downto 0);
            column_in     : in STD_LOGIC_VECTOR(3 downto 0);
            segment_out   : out STD_LOGIC_VECTOR(7 downto 0);
            segment_anode : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;


    signal clk_1khz_s   : STD_LOGIC;
    signal column_in_s  : STD_LOGIC_VECTOR(3 downto 0);
    signal column_out_s : STD_LOGIC_VECTOR(3 downto 0);
    signal row_s        : STD_LOGIC_VECTOR(3 downto 0);
    signal clk_in_s     : STD_LOGIC;

----------------------------------------------------------------------------------
    begin 

        --clk divider
        clk_divider_i : clk_divider
        generic map(
            div_factor => 2
        )
        port map(
            clk_in => clk_in, 
            clk_out => clk_1khz_s
        );
    
        --row fsm
        row_fsm_i : row_fsm
        port map(
            clk_in  => clk_1khz_s,
            row => row_s,   -- pins out
            column  => column_out_s
        );

        --column read
        column_read_i : column_read
        port map(
            clk_in      => clk_1khz_s,
            column_in   => column_in,   -- pins out
            column_out  => column_out_s,
            led_out => led_out
        );

        --7 segment driver
        bcd_7_seg_i : bcd_7_seg
        port map(
            en            => '1',
            row_in        => row_s,
            column_in     => column_out_s,
            segment_out   => segment_out,
            segment_anode => digit_segment
        );
    
        row_out <= row_s;
        
end Structural;

