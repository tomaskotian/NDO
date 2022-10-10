----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------
entity rand_generator is
    port ( 
        clk     : in std_logic;
        gen_en  : in std_logic;
        en      : in std_logic;     --1 hz 
        seed    : in std_logic_vector(11 downto 0);
        load    : in std_logic;
        rand    : out std_logic_vector (11 downto 0)
        );
end rand_generator;
----------------------------------------------------------------------------------
architecture Behavioral of rand_generator is

signal seed_s : std_logic_vector(12 downto 0) ;
----------------------------------------------------------------------------------
    begin
       
        rand <= seed_s(12 downto 1);
        
        process (clk) begin
            if rising_edge(clk) then
                if load = '1' then
                    seed_s <= seed & '1';
                end if;

                if en = '1' and gen_en = '1' then 
                    seed_s(12) <=  seed_s(1) xor seed_s(2) xor seed_s(4) xor seed_s(6);
                    seed_s(11) <=  seed_s(12);
                    seed_s(10) <=  seed_s(11);
                    seed_s(9)  <=  seed_s(10);
                    seed_s(8) <=  seed_s(9);
                    seed_s(7) <=  seed_s(8);
                    seed_s(6) <=  seed_s(7);
                    seed_s(5) <=  seed_s(6);
                    seed_s(4) <=  seed_s(5);
                    seed_s(3) <=  seed_s(4);
                    seed_s(2) <=  seed_s(3);
                    seed_s(1) <=  seed_s(2);
                    seed_s(0) <=  seed_s(1);
                end if;
            end if;
        end process;

end Behavioral;
