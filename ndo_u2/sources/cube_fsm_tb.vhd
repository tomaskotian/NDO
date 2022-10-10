----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------
entity cube_fsm_tb is
end cube_fsm_tb;
----------------------------------------------------------------------------------
architecture Behavioral of cube_fsm_tb is
    component cube_fsm is
        port ( 
            clk         : in std_logic;
            button      : in std_logic;
            en          : in std_logic;
            rand_in     : in std_logic_vector (11 downto 0);
            rand_out    : out std_logic_vector (11 downto 0);
            gen_en      : out std_logic;
            load        : out std_logic;
            led         : out std_logic
            );
    end component;
    
    signal clk_s : std_logic;
    signal button_s : std_logic;
    signal rand_in_s : std_logic_vector (11 downto 0);
    signal rand_out_s : std_logic_vector (11 downto 0);
    signal gen_s : std_logic;
    signal load_s : std_logic;
    signal led_s : std_logic;

    constant clk_periode : time := 20 ns;
    constant clk_per_en  : time := 100 ns;
----------------------------------------------------------------------------------
    begin

    clk_50MHz : process
        begin
            clk_s <= '0';
            wait for clk_periode/2;
            clk_s <= '1';
            wait for clk_periode/2;
    end process;
    
    gen_event : process
    begin
        rand_in_s <= "001010011100"; 
        button_s <= '0';
        wait for 110 ns;
        button_s <= '1';
        wait for clk_periode;
        button_s <= '0';
        
        wait for 400ns;
        button_s <= '1';
        wait for clk_periode;
        button_s <= '0';
        wait;
    end process;

    cube_fsm_i : cube_fsm
    port map(
        clk         => clk_s,
        button      => button_s,
        en          => '1',
        rand_in     => rand_in_s,
        rand_out    => rand_out_s,
        gen_en      => gen_s,
        load        => load_s,
        led         => led_s
    );
   

end Behavioral; 