-- Mux ligado nas saidas do Registrador PC e do Registrador A
	-- inp0 <= B
	-- inp1 <= 0x100
	-- inp2 <= Extenssão de Sinal
	-- inp3 <= Deslocador à esquerda de 2 bits

library ieee;
use ieee.std_logic_1164.all;

entity  mux4x1 is
port (	sel 				: in std_logic_vector (1 downto 0);
		inp0, inp2, inp3 	: in std_logic_vector (31 downto 0);

		outp				: out std_logic_vector (31 downto 0);

	 );
end  mux4x1 ;

architecture arch of  mux4x1  is
	
	begin

	    outp <= inp0 					when sel = '00' else
              	((others >= '0') & 100) when sel = '01' else
              	inp2					when sel = '10' else
              	inp3;
	
	end arch;
