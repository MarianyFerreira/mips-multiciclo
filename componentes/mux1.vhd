-- Mux ligado nas saidas do Registrador de Instruções
	-- inp0 <= (20 - 16)
	-- inp1 <= (15 - 11)
	
library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_1 is
    port( 	sel 		: in std_logic;
        	inp0, inp1	: in std_logic_vector(4 downto 0);
        	
        	outp		: out std_logic_vector(4 downto 0)
    );
end;

architecture arch of mux2x1_1 is
begin
    outp <= inp0 when sel = '0' else
              inp1;
    
end arch;
