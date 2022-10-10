----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------
entity cube_fsm is
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
end cube_fsm;
----------------------------------------------------------------------------------
architecture Behavioral of cube_fsm is
    type t_state is (st1,st2,st3);
    signal pres_st : t_state := st1;
    signal next_st : t_state;
----------------------------------------------------------------------------------
    begin

        rand_out <= rand_in;

        process (clk) begin
            if rising_edge(clk) then
                pres_st <= next_st;
            end if;
        end process;

        process (pres_st, en, button) begin
            case pres_st is
                when st1 => if en = '1' then next_st <= st2;
                            else next_st <= st1;
                            end if;
                when st2 => if en = '1' and button = '1' then next_st <= st3;
                            else next_st <= st2;
                            end if;
                when st3 => if en = '1' and button = '1' then next_st <= st2;
                            else next_st <= st3;
                            end if;
            end case;
        end process;

        process (pres_st,rand_in) begin
            case pres_st is
                when st1 => gen_en   <= '0';
                            load     <= '1';
                            led      <= '0';
                when st2 => gen_en   <= '0';
                            load     <= '0';
                            led      <= '1';
                when st3 => gen_en   <= '1';
                            load     <= '0';
                            led      <= '0';
            end case;
        end process;

end Behavioral; 