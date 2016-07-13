library ieee;
use ieee.std_logic_1164.all;

entity toplevel is
	port( clock, reset: in std_logic
	);
end ;

architecture arch of toplevel is

component blocoOperativo is
   port(
      clock, reset: in std_logic;
      PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA: in std_logic;
      ULAFonteB, ULAOp, FontePC: in std_logic_vector(1 downto 0);
      opcode: out std_logic_vector(5 downto 0)
	);
end component;
 
 
component blocoControle  is
	port(
      clock, reset: in std_logic;
      PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA: out std_logic;
      ULAFonteB, ULAOp, FontePC: out std_logic_vector(1 downto 0);
      opcode: in std_logic_vector(5 downto 0)
   );
end component;
 
signal PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA: std_logic;
signal ULAFonteB, ULAOp, FontePC: std_logic_vector(1 downto 0);
signal opcode: std_logic_vector(5 downto 0);
 
begin

bloco_controle: blocoControle port map (clock, reset, PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst,
									EscReg, ULAFonteA, ULAFonteB, ULAOp, FONtePC, opcode);

bloco_operativo: blocoOperativo port map (clock, reset, PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst,
									EscReg, ULAFonteA, ULAFonteB, ULAOp, FONtePC, opcode);

end arch;
