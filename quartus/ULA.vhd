library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is 
   port( inputA, inputB: in std_logic_vector(31 downto 0);
			operation: in std_logic_vector(2 downto 0);
      
			output: out std_logic_vector(31 downto 0);
			flagzero: out std_logic
   );
end entity;

architecture behavior of ULA is

	component fulladder is
		port( carryin: in std_logic;
				input0, input1: in std_logic_vector(31 downto 0);
	
				output: out std_logic_vector(31 downto 0)
		);
	end component;

	signal outputOp, and_or, add_sub, slt: std_logic_vector(31 downto 0);

	begin
		fulladderULA: fulladder port map(operation(2), inputA, inputB, add_sub);

		and_or <= 	inputA and inputB when operation(0)='0' else
						inputA or inputB;
						
		slt <= (0 => '1', others => '0') when signed(inputA) < signed(inputB) else
				 (others => '0');

		outputOp <= slt when operation = "111" else
						and_or when operation(1) = '0' else
						add_sub;
						
		output <= outputOp;
 
		flagzero <= '1' when outputOp =(outputOp'range => '0') else '0';
		
	end behavior;