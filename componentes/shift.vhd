library ieee;
use ieee.std_logic_1164.all;

entity shift is
port ( 	inp		: in std_logic_vector (31 downto 0);
		outp 	: out std_logic_vector (31 downto 0)
	 );
end  shift ;

architecture arch of shift is
	
	begin

		outp <= (inp sll 2);
	
	end arch;
