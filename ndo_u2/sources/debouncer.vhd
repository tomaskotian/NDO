----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
entity debouncer is
    generic(
        period : positive := 5    --1.6ms/20ns=80000
    );
    port(
        clk         : in std_logic;
        ce          : in std_logic;
        button_in   : in std_logic;
        button_out  : out std_logic
    );
end debouncer;
----------------------------------------------------------------------------------
architecture Behavioral of debouncer is
    signal cnt : positive := 1;
    signal button_deb_s : std_logic := '0';
    signal button_prev_s : std_logic := '0';
----------------------------------------------------------------------------------
    begin
        
        process (clk,ce,button_in) begin
            if rising_edge(clk) then
                if ce = '1' then 
                    if button_in = '1' then 
                        if cnt >= period then
                            button_deb_s <= '1';
                        else
                            cnt <= cnt + 1;
                            button_deb_s <= '0';
                        end if;
                    else
                        cnt <= 1;
                        button_deb_s <= '0';
                    end if;
                end if;
            end if;
        end process;

        --edge detector
        process (clk) begin 
            if rising_edge(clk) then
                button_prev_s <= button_deb_s;

                button_out <= '0';

                if button_prev_s = '0' and button_deb_s = '1' then
                    button_out <= '1';
                end if;

            end if;
        end process;

end Behavioral;
