-- Mux ligado nas saidas do Registrador da ULA e do Registrador de dados da Memória
	-- inp0 <= Registrador ULA
	-- inp1 <= Registrador de dados da memória

library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_2 is
    port( 	sel 		: in std_logic;
        	inp0, inp1	: in std_logic_vector(32 downto 0);
        	
        	outp		: out std_logic_vector(32 downto 0)
    );
end;

architecture arch of mux2x1_2 is
begin
    outp <= inp0 when sel = '0' else
              inp1;
    
end arch;
