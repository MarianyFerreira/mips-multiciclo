library ieee;
use ieee.std_logic_1164.all;

entity mux3x1_32 is
	port( sel : in std_logic_vector (1 downto 0);
			input0, input1, input2 : in std_logic_vector(31 downto 0);
        	
        	output : out std_logic_vector(31 downto 0)
    );
end;

architecture behavior of mux3x1_32 is
	begin
		output <=	input0 when sel = "00" else
						input1 when sel = "01" else
						input2;
	end behavior;

-- Mux ligado nas saidas do Registrador da ULA e do Registrador de dados da Memória
	-- inp0 <= ULA
	-- inp1 <= Registrador ULA
	-- inp2 <= Deslocador 2 bits e PC