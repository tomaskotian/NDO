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
entity bcd_7_seg is
    port(
        en            : in STD_LOGIC; 
        row_in        : in STD_LOGIC_VECTOR(3 downto 0);
        column_in     : in STD_LOGIC_VECTOR(3 downto 0);
        segment_out   : out STD_LOGIC_VECTOR(7 downto 0);
        segment_anode : out STD_LOGIC_VECTOR(3 downto 0)
    );
end bcd_7_seg;
----------------------------------------------------------------------------------
architecture Behavioral of bcd_7_seg is
----------------------------------------------------------------------------------
    begin
        process (column_in,row_in) begin
            case row_in is                                  --segment_out <= "abcdefg."
                when "0001" =>  if    column_in = "0001" then segment_out <= "10011111"; --1
                                elsif column_in = "0010" then segment_out <= "00100101"; --2
                                elsif column_in = "0100" then segment_out <= "00001101"; --3
                                elsif column_in = "1000" then segment_out <= "00010001"; --A
                                else                          segment_out <= "11111111";
                                end if;

                when "0010" =>  if    column_in = "0001" then segment_out <= "11011001"; --4
                                elsif column_in = "0010" then segment_out <= "01001001"; --5
                                elsif column_in = "0100" then segment_out <= "01000001"; --6
                                elsif column_in = "1000" then segment_out <= "10111111"; --B segment
                                else                          segment_out <= "11111111";
                                end if;
                when "0100" =>  if    column_in = "0001" then segment_out <= "00011111"; --7
                                elsif column_in = "0010" then segment_out <= "00000001"; --8
                                elsif column_in = "0100" then segment_out <= "00011001"; --9
                                elsif column_in = "1000" then segment_out <= "01100011"; --C
                                else                          segment_out <= "11111111";
                                end if;
                when "1000" =>  if    column_in = "0001" then segment_out <= "10010001"; --x
                                elsif column_in = "0010" then segment_out <= "00000011"; --0
                                elsif column_in = "0100" then segment_out <= "00111001"; --#
                                elsif column_in = "1000" then segment_out <= "10000101"; --d
                                else                          segment_out <= "11111111";
                                end if;
                when others => segment_out <= "11111111";
            end case;    
        end process;

        segment_anode <= "0111" when en = '1' else "1111";
             

end Behavioral;