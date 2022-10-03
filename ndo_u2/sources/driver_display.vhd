----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------
entity driver_display is
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
end driver_display;
----------------------------------------------------------------------------------
architecture Behavioral of driver_display is

    type t_state is (st_dig_0,st_dig_1,st_dig_2,st_dig_3);
    signal pres_st : t_state := st_dig_0;
    signal next_st : t_state; 

    signal digit_0_s : std_logic_vector(2 downto 0);
    signal digit_1_s : std_logic_vector(2 downto 0);
    signal digit_2_s : std_logic_vector(2 downto 0);
    signal digit_3_s : std_logic_vector(2 downto 0);
----------------------------------------------------------------------------------
    begin
        process (digit_0,digit_1,digit_2,digit_3,clk,en) begin
            if rising_edge(clk) then
                if en = '1' then
                    digit_0_s <= digit_0;
                    digit_1_s <= digit_1;
                    digit_2_s <= digit_2;
                    digit_3_s <= digit_3;
                end if;
            end if;
        end process;

        process (clk,digit_en) begin 
            if rising_edge(clk) then
                if digit_en = '1' then
                    pres_st <= next_st;    
                end if;
            end if;
        end process;

        --fsm
        process (pres_st,digit_en) begin
            case pres_st is
                when st_dig_0 => if digit_en = '1' then next_st <= st_dig_1;
                                 else next_st <= st_dig_0;
                                 end if;
                when st_dig_1 => if digit_en = '1' then next_st <= st_dig_2;
                                 else next_st <= st_dig_1;
                                 end if;
                when st_dig_2 => if digit_en = '1' then next_st <= st_dig_3;
                                 else next_st <= st_dig_2;
                                 end if;
                when st_dig_3 => if digit_en = '1' then next_st <= st_dig_0;
                                 else next_st <= st_dig_3;
                                 end if;
            end case;
        end process;

        --controls which number will light
        process (pres_st,digit_0_s,digit_1_s,digit_2_s,digit_3_s) begin
            case pres_st is
                when st_dig_0 => if    digit_0_s = "001" then segments <= "11111101"; --1
                                 elsif digit_0_s = "010" then segments <= "11011011"; --2
                                 elsif digit_0_s = "011" then segments <= "11011001"; --3
                                 elsif digit_0_s = "100" then segments <= "10010011"; --4
                                 elsif digit_0_s = "101" then segments <= "10010001"; --5
                                 elsif digit_0_s = "110" then segments <= "00000011"; --6
                                 else segments <= "11111111";
                                 end if;
                when st_dig_1 => if    digit_1_s = "001" then segments <= "11111101"; --1
                                 elsif digit_1_s = "010" then segments <= "11011011"; --2
                                 elsif digit_1_s = "011" then segments <= "11011001"; --3
                                 elsif digit_1_s = "100" then segments <= "10010011"; --4
                                 elsif digit_1_s = "101" then segments <= "10010001"; --5
                                 elsif digit_1_s = "110" then segments <= "00000011"; --6
                                 else segments <= "11111111";
                                 end if;
                when st_dig_2 => if    digit_2_s = "001" then segments <= "11111101"; --1
                                 elsif digit_2_s = "010" then segments <= "11011011"; --2
                                 elsif digit_2_s = "011" then segments <= "11011001"; --3
                                 elsif digit_2_s = "100" then segments <= "10010011"; --4
                                 elsif digit_2_s = "101" then segments <= "10010001"; --5
                                 elsif digit_2_s = "110" then segments <= "00000011"; --6
                                 else segments <= "11111111";
                                 end if;
                when st_dig_3 => if    digit_3_s = "001" then segments <= "11111101"; --1
                                 elsif digit_3_s = "010" then segments <= "11011011"; --2
                                 elsif digit_3_s = "011" then segments <= "11011001"; --3
                                 elsif digit_3_s = "100" then segments <= "10010011"; --4
                                 elsif digit_3_s = "101" then segments <= "10010001"; --5
                                 elsif digit_3_s = "110" then segments <= "00000011"; --6
                                 else segments <= "11111111";
                                 end if;
            end case;
        end process;

        --controls which digit will light
        process (pres_st,on_off) begin
            case pres_st is
                when st_dig_0 => if on_off = '1' then digits <= "0111";
                                 else digits <= "1111";
                                 end if;
                when st_dig_1 => if on_off = '1' then digits <= "1011";
                                 else digits <= "1111";
                                 end if;
                when st_dig_2 => if on_off = '1' then digits <= "1101";
                                 else digits <= "1111";
                                 end if;
                when st_dig_3 => if on_off = '1' then digits <= "1110";
                                 else digits <= "1111";
                                 end if;
            end case;
        end process;

end Behavioral;
