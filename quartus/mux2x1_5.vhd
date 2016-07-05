library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_5 is
	port(	sel : in std_logic;
			input0, input1	: in std_logic_vector(4 downto 0);
        	
			output : out std_logic_vector(4 downto 0)
    );
end;

architecture behavior of mux2x1_5 is
	begin
    output <= 	input0 when sel = '0' else
					input1;    
	end behavior;

-- Mux ligado nas saidas do Registrador de Instruções
	-- inp0 <= (20 - 16)
	-- inp1 <= (15 - 11)