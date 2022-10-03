----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------
entity rand_generator is
    generic(
        seed    : std_logic_vector( 2 downto 0)
    );
    port ( 
        clk     : in std_logic;
        en      : in std_logic;
        load    : in std_logic;
        rand    : out std_logic_vector (2 downto 0)
        );
end rand_generator;
----------------------------------------------------------------------------------
architecture Behavioral of rand_generator is

signal seed_s : std_logic_vector(3 downto 0);
----------------------------------------------------------------------------------
    begin
       
        rand <= seed_s(3 downto 1);
        
        process (clk,en,load) begin
            if rising_edge(clk) then
                if en = '1' then 
                    if load = '1' then
                         seed_s <= seed & '1';
                    else
                        seed_s(3) <=  seed_s(1);
                        seed_s(2) <=  seed_s(3) xor seed_s(1);
                        seed_s(1) <=  seed_s(2);
                    end if;
                end if;
            end if;
        end process;

end Behavioral;
