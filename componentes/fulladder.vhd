library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fulladder is
   port( carryin: in std_logic;
			input0, input1: in std_logic_vector(31 downto 0);
	
			output: out std_logic_vector(31 downto 0)
   );
end entity;

architecture behavior of fulladder is
	begin
		output <= 	std_logic_vector(signed(input0) + signed(input1)) when carryin = '0' else
						std_logic_vector(signed(input0) - signed(input1));
	end behavior;
	
-- Somador completo usado na ULA para.