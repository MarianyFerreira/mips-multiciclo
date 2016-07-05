library ieee;
use ieee.std_logic_1164.all;

entity  mux4x1_32 is
	port(	sel : in std_logic_vector (1 downto 0);
			input0, input1, input2, input3 : in std_logic_vector (31 downto 0);

			output : out std_logic_vector (31 downto 0)
	);
end  mux4x1_32;

architecture behavior of  mux4x1_32  is
	begin
	    output <= 	input0	when sel = "00" else
						input1	when sel = "01" else
						input2	when sel = "10" else
						input3;
	end behavior;

	-- Mux ligado nas saidas do Registrador PC e do Registrador A
	-- inp0 <= B
	-- inp1 <= 0x100
	-- inp2 <= Extenssão de Sinal
	-- inp3 <= Deslocador à esquerda de 2 bits