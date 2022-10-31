----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:31:24 10/25/2022 
-- Design Name: 
-- Module Name:    fsm_mealy - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
entity fsm_mealy is
    port ( CLK		    : in std_logic;
		   TMP 	        : in  std_logic;
           ACK 	        : in  std_logic_vector (1 downto 0);
           TIM_ON       : out  std_logic;
           V_ON         : out  std_logic;
           V_OFF        : out  std_logic;
           Z            : out  std_logic);
end fsm_mealy;
----------------------------------------------------------------------------------
architecture Behavioral of fsm_mealy is
	type t_state is (SO, SON, SL, SOFF);
	signal pres_st : t_state := SO;
	signal next_st	: t_state;
----------------------------------------------------------------------------------
	begin
	
	--register
	process (clk) 
	begin
		if rising_edge(clk) then
			pres_st <= next_st;
		end if;
	end process;
	
	
	--logic
	process (TMP, ACK, pres_st, next_st) 
	begin
		TIM_ON 	<= '0';
		V_ON		<= '0';
		V_OFF		<= '0';
		Z			<= '0';
		case pres_st is
			when SO =>	
				if	TMP = '1' then	--!TMP v zadani
					TIM_ON 	<= '1';
					next_st <= SL;
				else
					V_ON		<= '1';
					Z			<= '1';
					next_st <= SON;
				end if;
			when SON =>
				if	ACK = "10" or ACK = "01" then
					next_st <= SO;
				else
					next_st <= SON;					
				end if;
			when SL => 	
				if	ACK = "11" then
					Z			<= '1';
					next_st <= SOFF;
				else
					next_st <= SO;					
				end if;
			when SOFF => 	
				if ACK = "01" then
					V_OFF		<= '1';
					next_st <= SO;	
				else
					next_st <= SOFF;						
				end if;
		end case;	
	end process;
	
end Behavioral;

