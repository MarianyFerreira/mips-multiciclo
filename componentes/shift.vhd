library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift is
	port( input : in std_logic_vector (31 downto 0);

			output : out std_logic_vector (31 downto 0)
	);
end  shift ;

architecture behavior of shift is
	begin
		output <= std_logic_vector(signed(input) sll 2);
	end behavior;
