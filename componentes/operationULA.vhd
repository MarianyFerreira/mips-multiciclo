library IEEE;
use ieee.std_logic_1164.all;

entity operationULA is 
   port( ULAOp: in std_logic_vector(1 downto 0);
			funct: in std_logic_vector(5 downto 0);

			operation: out std_logic_vector(2 downto 0)
   );
end entity;

architecture behavior of operationULA is
	begin
		operation <= "010" when ULAOp = "00" else 		-- sum
						 "110" when ULAOp = "01" else 		-- sub
						 
						 "001" when funct(0) = '1' else 	-- or
						 "010" when funct(1) = '0' else 	-- sum
 						 "000" when funct(2) = '1' else 	-- and
						 "111" when funct(3) = '1' else 	-- slt
						 "110"; 									-- sub
	end behavior;