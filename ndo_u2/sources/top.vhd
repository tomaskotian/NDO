----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------
entity top is
	port(
		clk				: in std_logic;
		on_off			: in std_logic;
		button 			: in std_logic;
		digits     		: out std_logic_vector(3 downto 0);
        segments    	: out std_logic_vector(7 downto 0);
		led				: out std_logic
	);
end top;
----------------------------------------------------------------------------------
architecture Behavioral of top is

	component driver_display is
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
	end component;
		
	component clk_divider is
		generic(
        div_factor : positive := 5
		);
		port(
        clk_in : in STD_LOGIC;
        clk_out : out STD_LOGIC
		);
	end component;
	
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
	
	component rand_generator is
		port (
		clk     : in std_logic;
		gen_en  : in std_logic;
		en      : in std_logic;
		seed    : in std_logic_vector(11 downto 0);
		load    : in std_logic;
		rand    : out std_logic_vector (11 downto 0)
		);
	end component;

	component debouncer is
	generic(
        period : positive := 5    --1.6ms/20ns=80000
    );
    port(
        clk         : in std_logic;
        ce          : in std_logic;
        button_in   : in std_logic;
        button_out  : out std_logic
    );
	end component;
	
	signal rand_in_s		: std_logic_vector(11 downto 0);
	signal rand_out_s		: std_logic_vector(11 downto 0);
	signal load_s			: std_logic;
	signal s_1hz 			: std_logic;
	signal s_1khz 			: std_logic;
	signal digits_en_s 		: std_logic;
	signal gen_en_s			: std_logic;
	signal deb_button_s		: std_logic;
----------------------------------------------------------------------------------
	begin
	
	clk_divider_50hz : clk_divider
	generic map(
		div_factor => 2 --200000
	)
	port map(
		clk_in 	=> clk,	
      	clk_out 	=> digits_en_s
	);

	clk_divider_1hz : clk_divider
	generic map(
		div_factor => 2 --200000000
	)
	port map(
		clk_in 	=> clk,	
      	clk_out 	=> s_1hz
	);

	clk_divider_1khz : clk_divider
	generic map(
		div_factor => 2 --200000
	)
	port map(
		clk_in 	=> clk,	
      	clk_out 	=> s_1khz
	);

	debouncer_i : debouncer
	generic map(
        period 		=> 2    
    )
    port map(
        clk         => clk,
        ce          => s_1khz,
        button_in   => button,
        button_out  => deb_button_s
    );
	
	cube_fsm_i : cube_fsm
    port map ( 
        clk			=> clk,         
        button      => deb_button_s,
        en          => '1',
        rand_in     => rand_in_s,
        rand_out    => rand_out_s,
        gen_en      => gen_en_s,
        load        => load_s,
        led         => led
        );

	rand_generator_i : rand_generator
	port map(
		clk     => clk,
		gen_en  => gen_en_s,
		en      => s_1hz,
		seed    => "010001101001",
		load    => load_s,
		rand    => rand_in_s
	);
	

	driver_display_i : driver_display
	port map(
	  clk         	=> clk,
	  on_off     	=> on_off, 
	  digit_en    	=> digits_en_s,
	  digit_0     	=> rand_out_s(2 downto 0),
	  digit_1     	=> rand_out_s(5 downto 3),
	  digit_2     	=> rand_out_s(8 downto 6),
	  digit_3     	=> rand_out_s(11 downto 9),
	  digits      	=> digits,
	  segments    	=> segments
	);

end Behavioral;

