----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------
entity driver_display_tb is
end driver_display_tb;
----------------------------------------------------------------------------------
architecture Behavioral of driver_display_tb is
    component driver_display is
        port(
            clk         : in std_logic;
            en          : in std_logic; --load data for display 
            on_off      : in std_logic; --connect to switch, control on off all digits
            digit_en    : in std_logic; --connect to 2ms period clk, for digit ligth period
            digit_0     : in std_logic_vector(2 downto 0);
            digit_1     : in std_logic_vector(2 downto 0);
            digit_2     : in std_logic_vector(2 downto 0);
            digit_3     : in std_logic_vector(2 downto 0);
            digits      : out std_logic_vector(3 downto 0);
            segments    : out std_logic_vector(7 downto 0)
        );
    end component;

    signal clk_s : std_logic;
    signal en_s  : std_logic;
    signal on_off_s : std_logic;
    signal digit_en_s : std_logic;
    signal digit_0_s : std_logic_vector(2 downto 0);
    signal digit_1_s : std_logic_vector(2 downto 0);
    signal digit_2_s : std_logic_vector(2 downto 0);
    signal digit_3_s : std_logic_vector(2 downto 0);

    constant clk_periode : time := 20 ns;
----------------------------------------------------------------------------------
    begin

        driver_display_i : driver_display
        port map(
            clk         => clk_s,  
            en          => en_s,   
            on_off      => on_off_s,
            digit_en    => digit_en_s,   
            digit_0     => digit_0_s,
            digit_1     => digit_1_s,
            digit_2     => digit_2_s,
            digit_3     => digit_3_s
        );

        gen_clk : process
            begin
                clk_s <= '0';
                wait for clk_periode/2;
                clk_s <= '1';
                wait for clk_periode/2;
        end process;

        gen_div_2ms : process
            begin
                digit_en_s <= '1';
                wait for clk_periode;
                digit_en_s <= '0';
                wait for (clk_periode*10)-(clk_periode);

        end process;

        gen_digits : process
            begin
                on_off_s <= '1';
                en_s <= '0';
                wait for 50 ns;
                en_s <= '1';
                digit_0_s <= "001";
                digit_1_s <= "010";
                digit_2_s <= "011";
                digit_3_s <= "100";
                wait for 60 ns;
                en_s <= '0';
                digit_0_s <= "000";
                digit_1_s <= "000";
                digit_2_s <= "000";
                digit_3_s <= "000";
                wait for 300 ns;
                on_off_s <= '0';
                wait for 300 ns;
                on_off_s <= '1';
                wait;
        end process;

end Behavioral;