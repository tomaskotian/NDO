----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2022 16:41:35
-- Design Name: 
-- Module Name: my_fsm_tb - Behavioral
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
entity my_fsm_tb is
end my_fsm_tb;
----------------------------------------------------------------------------------
architecture Behavioral of fsm_mealy_tb is

    component my_fsm is
        port ( CLK		    : in std_logic;
               TMP 	        : in  std_logic;
               ACK 	        : in  std_logic_vector (1 downto 0);
               TIM_ON       : out  std_logic;
               V_ON         : out  std_logic;
               V_OFF        : out  std_logic;
               Z            : out  std_logic);
    end component ;

    constant period : time := 20 ns;
    signal clk_s    : std_logic := '0'; 
    signal tmp_s    : std_logic:= '0';
    signal ack_s    : std_logic_vector(1 downto 0) := "00";
    signal tim_on_s : std_logic := '0';
    signal v_on     : std_logic := '0';
    signal v_off    : std_logic := '0';
    signal z_s      : std_logic := '0';


----------------------------------------------------------------------------------
    begin
    
    --fsm
    my_fsm_i : my_fsm 
    port map(   CLK		    => clk_s,
                TMP 	    => tmp_s,
                ACK 	    => ack_s,
                TIM_ON      => tim_on_s,
                V_ON        => v_on,
                V_OFF       => v_off,
                Z           => z_s
    );


    --clk
    clk_gen : process
    begin
        clk_s <= '0';
        wait for period/2;
        clk_s <= '1';
        wait for period/2;
    end process;

    --inputs
    inputs_gen : process
    begin
        tmp_s <= '1';
        wait for period;
        tmp_s <= '0';
    end process;

end Behavioral;
