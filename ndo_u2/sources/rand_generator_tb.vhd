----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------
entity rand_generator_tb is
end rand_generator_tb;
----------------------------------------------------------------------------------
architecture Behavioral of rand_generator_tb is

component rand_generator is
    port(
        clk     : in std_logic;
        gen_en  : in std_logic;
        en      : in std_logic;
        seed    : in std_logic_vector(11 downto 0);
        load    : in std_logic;
        rand    : out std_logic_vector (11 downto 0)
        );
end component;

constant clk_periode : time := 20 ns;
signal clk_s    : std_logic;
signal rand_s   : std_logic_vector(11  downto 0);
signal load_s     : std_logic;

----------------------------------------------------------------------------------
    begin
    
    rand_generator_i : rand_generator
        port map(
            clk     => clk_s,
            gen_en  => '1',
            en      => '1',
            seed    => "010001101001",
            load    => load_s,
            rand    => rand_s
        );

       gen_load : process
            begin
                load_s <= '0';
                wait for clk_periode;
                load_s <= '1';
                wait for clk_periode;
                load_s <= '0';
                wait;
        end process;
  
       gen_clk : process
            begin
                clk_s <= '0';
                wait for clk_periode/2;
                clk_s <= '1';
                wait for clk_periode/2;
        end process;
        
end Behavioral;
