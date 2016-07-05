library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_32 is
	port( sel : in std_logic;
			input0, input1	: in std_logic_vector(31 downto 0);
        	
        	output : out std_logic_vector(31 downto 0)
    );
end;

architecture behavior of mux2x1_32 is
	begin
		output <= 	input0 when sel = '0' else
						input1;
	end behavior;

-- Mux ligado nas saidas do Registrador da ULA e do Registrador de dados da Memória
	-- inp0 <= Registrador ULA
	-- inp1 <= Registrador de dados da memória
-- Mux ligado nas saidas do Registrador PC e do Registrador A
	-- inp0 <= PC
	-- inp1 <= A