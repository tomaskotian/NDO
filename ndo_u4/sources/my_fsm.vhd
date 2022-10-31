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
entity my_fsm is
    port ( CLK		    : in std_logic;
		   TMP 	        : in  std_logic;
           ACK 	        : in  std_logic_vector (1 downto 0);
           TIM_ON       : out  std_logic;
           V_ON         : out  std_logic;
           V_OFF        : out  std_logic;
           Z            : out  std_logic);
end my_fsm;
----------------------------------------------------------------------------------
architecture Behavioral of my_fsm is
    component jk is
        port(   clk : in    std_logic;
                J   : in    std_logic;
                K   : in    std_logic;
                Q   : out   std_logic;
                QB  : out   std_logic);
    end component;

    signal st : std_logic_vector(1 downto 0) := "10";   --10 SO
    signal k0_s : std_logic;
    signal j1_s : std_logic;
    signal k1_s : std_logic;
----------------------------------------------------------------------------------
    begin

    jk_0 : jk
    port map(   clk => CLK, 
                J   => st(1),
                K   => k0_s,
                Q   => st(0)
                );

    jk_1 : jk
    port map(   clk => CLK,  
                J   => j1_s,
                K   => k1_s,
                Q   => st(1)
                );
                
    k0_s <= not(st(1)) or (not(ACK(1)) and ACK(0)) or (ACK(1) and not(ACK(0)));
    j1_s <= (not(TMP) and not(ACK(1))) or (st(0) and not(ACK(0)));
    k1_s <= TMP and not(st(0));

    TIM_ON <= TMP and st(1) and not(st(0));
    V_ON <= not(TMP) and st(1) and not(st(0));
    V_OFF <= not(ACK(1)) and ACK(0) and not(st(1)) and not(st(0));
    Z <= (not(TMP) and st(1) and not(st(0))) or (not(ACK(1)) and ACK(0) and not(st(1)) and not(st(0)));
    

end Behavioral;