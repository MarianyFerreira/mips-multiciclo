library ieee ;
USE ieee.std_logic_1164.all;

entity dataregister is
	port(	enable, reset, clk 	: in std_logic;
			input : in std_logic_vector (15 downto 0);

			output : out std_logic_vector (15 downto 0)
		 );
end dataregister;

architecture behavior of dataregister is
	begin
		process(clk, reset)
			begin
				if reset = '0' then				
					output <= (others => '0');
				elsif rising_edge(clk) and enable = '1' then
					output <= input;
				end if;
		end process;
	end behavior;
