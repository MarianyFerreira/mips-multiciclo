library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity  extend16_32 is
	port( input : in std_logic_vector(15 downto 0);

			output : out std_logic_vector (31 downto 0)
	);
end  extend16_32 ;

architecture behavior of extend16_32 is
	begin
		output <= std_logic_vector(resize(signed(input), output'length));
	end behavior;
