----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------
entity top_tb is
	port(
		clk				: in std_logic;
		on_off			: in std_logic;
		button 			: in std_logic;
		digits     		: out std_logic_vector(3 downto 0);
        segments    	: out std_logic_vector(7 downto 0);
		led				: out std_logic
	);
end top_tb;
----------------------------------------------------------------------------------
architecture Behavioral of top_tb is

    component top is
        port(
            clk				: in std_logic;
            on_off			: in std_logic;
            button 			: in std_logic;
            digits     		: out std_logic_vector(3 downto 0);
            segments    	: out std_logic_vector(7 downto 0);
            led				: out std_logic
        );
    end component;

    signal clk_s        : std_logic;
    signal on_off_s     : std_logic;
    signal button_s     : std_logic;
    signal digits_s     : std_logic_vector(3 downto 0);
    signal segments_s   : std_logic_vector(7 downto 0);
    signal led_s        : std_logic;

    constant clk_periode : time := 20 ns;
----------------------------------------------------------------------------------
    begin

        gen_clk : process
        begin
            clk_s <= '0';
            wait for clk_periode/2;
            clk_s <= '1';
            wait for clk_periode/2;
        end process;

        clik_gen : process
        begin
            on_off_s <= '1';
            button_s <= '0';  
            wait for  50 ns;
            button_s <= '1';
            wait for 130 ns;
            button_s <= '0';
            wait for  270 ns;
            button_s <= '1';
            wait for 130 ns;
            button_s <= '0';
            wait;
        end process;

        top_i : top
        port map(
            clk				=> clk_s,
            on_off			=> on_off_s,
            button 			=> button_s,
            digits     		=> digits_s,
            segments    	=> segments_s,
            led				=> led_s
        );


end Behavioral;