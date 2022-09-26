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
entity row_fsm is
    port(
        clk_in : in  STD_LOGIC;
        row    : out STD_LOGIC_VECTOR(3 downto 0);
        column : in  STD_LOGIC_VECTOR(3 downto 0)
    );
end row_fsm;
----------------------------------------------------------------------------------
architecture Behavioral of row_fsm is
    type t_state is (st_1,st_2,st_3,st_4);
    signal pres_st : t_state := st_1;
    signal next_st : t_state;
----------------------------------------------------------------------------------
    begin

        process (clk_in) begin
            if rising_edge(clk_in) then
                pres_st <= next_st;
            end if;        
        end process;

        process (pres_st,column) begin
            case pres_st is
                when st_1 => if column = "0000" then next_st <= st_2;
                             else next_st <= st_1;
                             end if;
                when st_2 => if column = "0000" then next_st <= st_3;
                             else next_st <= st_2;
                             end if;
                when st_3 => if column = "0000" then next_st <= st_4;
                             else next_st <= st_3;
                             end if;
                when st_4 => if column = "0000" then next_st <= st_1;
                            else next_st <= st_4;
                            end if;
            end case;
        end process;

        process (pres_st) begin 
            case pres_st is
                when st_1 => row <= "0001";
                when st_2 => row <= "0010";
                when st_3 => row <= "0100";
                when st_4 => row <= "1000";
            end case;
        end process;
        
end Behavioral;

