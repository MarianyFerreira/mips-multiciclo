-- Mux ligado nas saidas do Registrador PC e do Registrador A
	-- inp0 <= PC
	-- inp1 <= A

library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_3 is
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