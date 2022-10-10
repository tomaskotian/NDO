----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------
entity driver_display is
    port(
        clk         : in std_logic;	
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

----------------------------------------------------------------------------------
    begin

        process (clk) begin 
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
        process (pres_st,digit_0,digit_1,digit_2,digit_3) begin
            case pres_st is
                when st_dig_0 => if    digit_0 = "000" then segments <= "11111101"; --0 on cube is 1
                                 elsif digit_0 = "001" then segments <= "11111101"; --1
                                 elsif digit_0 = "010" then segments <= "11011011"; --2
                                 elsif digit_0 = "011" then segments <= "11011001"; --3
                                 elsif digit_0 = "100" then segments <= "10010011"; --4
                                 elsif digit_0 = "101" then segments <= "10010001"; --5
                                 elsif digit_0 = "110" then segments <= "00000011"; --6
                                 elsif digit_0 = "111" then segments <= "00000011"; --7 on cube 6
                                 else segments <= "11111111";
                                 end if;
                when st_dig_1 => if    digit_1 = "000" then segments <= "11111101"; --0 on cube is 1
                                 elsif digit_1 = "001" then segments <= "11111101"; --1
                                 elsif digit_1 = "010" then segments <= "11011011"; --2
                                 elsif digit_1 = "011" then segments <= "11011001"; --3
                                 elsif digit_1 = "100" then segments <= "10010011"; --4
                                 elsif digit_1 = "101" then segments <= "10010001"; --5
                                 elsif digit_1 = "110" then segments <= "00000011"; --6
                                 elsif digit_1 = "111" then segments <= "00000011"; --7 on cube 6
                                 else segments <= "11111111";
                                 end if;
                when st_dig_2 => if    digit_2 = "000" then segments <= "11111101"; --0 on cube is 1
                                 elsif digit_2 = "001" then segments <= "11111101"; --1
                                 elsif digit_2 = "010" then segments <= "11011011"; --2
                                 elsif digit_2 = "011" then segments <= "11011001"; --3
                                 elsif digit_2 = "100" then segments <= "10010011"; --4
                                 elsif digit_2 = "101" then segments <= "10010001"; --5
                                 elsif digit_2 = "110" then segments <= "00000011"; --6
                                 elsif digit_2 = "111" then segments <= "00000011"; --7 on cube 6
                                 else segments <= "11111111";
                                 end if;
                when st_dig_3 => if    digit_3 = "000" then segments <= "11111101"; --0 on cube is 1
                                 elsif digit_3 = "001" then segments <= "11111101"; --1
                                 elsif digit_3 = "010" then segments <= "11011011"; --2
                                 elsif digit_3 = "011" then segments <= "11011001"; --3
                                 elsif digit_3 = "100" then segments <= "10010011"; --4
                                 elsif digit_3 = "101" then segments <= "10010001"; --5
                                 elsif digit_3 = "110" then segments <= "00000011"; --6
                                 elsif digit_3 = "111" then segments <= "00000011"; --7 on cube 6
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
