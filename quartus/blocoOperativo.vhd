-- This VHD file, for not being generic was written in Portuguese
-- O Bloco operativo do Mips foi descrito conforme a arquitetura vista na imagem Mips Multiciclo
library IEEE;
use ieee.std_logic_1164.all;

entity blocoOperativo is 
   port( clock, reset: in std_logic;
			PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA: in std_logic;
			ULAFonteB, ULAOp, FontePC: in std_logic_vector(1 downto 0);
			
			opcode: out std_logic_vector(5 downto 0)
   );
end entity;

architecture estrutural of blocoOperativo is

component dataregister is
-- PC, registrador de instrucoes, registrador de dados, A, B, ULA
	port(	enable, reset, clk 	: in std_logic;
			input : in std_logic_vector (31 downto 0);

			output : out std_logic_vector (31 downto 0)
		 );	 
end component;

component mux2x1_32 is
-- Mux PC, Mux A, Mux Registrador da memoria de Dados
	port( sel : in std_logic;
			input0, input1	: in std_logic_vector(31 downto 0);
        	
        	output : out std_logic_vector(31 downto 0)
    );
end component;

component mem is
-- Bloco unico
	port( clock: in std_logic;
			ReadMem, WrtMem: in std_logic;
			DataWrt: in std_logic_vector(31 downto 0);
			Address: in std_logic_vector(31 downto 0);
			
			DataRd: out std_logic_vector(31 downto 0)
	);
end component;

component mux2x1_5 is
-- Mux saida Registrador de Instrucoes 20 - 16 e 15 - 11
	port(	sel : in std_logic;
			input0, input1	: in std_logic_vector(4 downto 0);
        	
			output : out std_logic_vector(4 downto 0)
    );
end component;

component bank_registers is
-- Bloco unico
   generic(
      largura: natural := 8;
      bitsRegSerLido: natural := 2
   );
   port(
      clock, reset: in std_logic;
      EscReg: in std_logic;
      RegSerLido1, RegSerLido2, RegSerEscrito: in std_logic_vector(bitsRegSerLido-1 downto 0);
      DadoEscrita: in std_logic_vector(largura-1 downto 0);      
      DadoLido1, DadoLido2: out std_logic_vector(largura-1 downto 0)
   );
end component;

component  extend16_32 is
-- Componente unico
	port( input : in std_logic_vector(15 downto 0);

			output : out std_logic_vector (31 downto 0)
	);
end  component;

component shift is
-- Usado para deslocar PC e deslocar o dado do Registrador de instrucoes
	port( input : in std_logic_vector (31 downto 0);

			output : out std_logic_vector (31 downto 0)
	);
end  component;

component  mux4x1_32 is
-- componente unico usado na saida do Registrador B para selecionar 
	port(	sel : in std_logic_vector (1 downto 0);
			input0, input1, input2, input3 : in std_logic_vector (31 downto 0);

			output : out std_logic_vector (31 downto 0)
	);
end  component;

component operationULA is
-- Componente unico usado para controlar as operacoes que devem ser feitas na ULA conforme Instrucao
   port( ULAOp: in std_logic_vector(1 downto 0);
			funct: in std_logic_vector(5 downto 0);

			operation: out std_logic_vector(2 downto 0)
   );
end component;

component ULA is
-- Bloco unico usado para realizar diferentes operacoes conforme a instrucao
   port( inputA, inputB: in std_logic_vector(31 downto 0);
			operation: in std_logic_vector(2 downto 0);
      
			output: out std_logic_vector(31 downto 0);
			flagzero: out std_logic
   );
end component;

component mux3x1_32 is
-- componente unico usado na saida da ULA para selecionar PC + 4, BEQ ou JUMP
	port( sel : in std_logic_vector (1 downto 0);
			input0, input1, input2 : in std_logic_vector(31 downto 0);
        	
        	output : out std_logic_vector(31 downto 0)
    );
end component;

			signal zero_end, PCEnable: std_logic;
			signal Mux_PC, PC_Mux: std_logic_vector(31 downto 0);
			
			signal ULA_Saida, Mux_Memoria: std_logic_vector(31 downto 0);
			signal B_EscDado, Memoria_Saida: std_logic_vector(31 downto 0);
			
			signal RegInstrucoes_Saida: std_logic_vector(31 downto 0);

			signal DadosMemoria_MuxDadoEsc: std_logic_vector(31 downto 0);
			
			signal MuxRegEsc_Registradores: std_logic_vector(4 downto 0);
			signal ULASaida_Mux, MuxDadoEsc_Registradores, dadoLido_A, dadoLido_B: std_logic_vector(31 downto 0);
		
			signal ExtensaoSinal_Saida, Deslocador_Mux4x1: std_logic_vector(31 downto 0);
			
			signal RegA_Saida, RegB_Saida: std_logic_vector(31 downto 0);
			
			constant quatro : std_logic_vector(31 downto 0) := (3 => '1', others => '0');
			signal MuxA_ULA, MuxB_ULA: std_logic_vector(31 downto 0);
			
			signal Operacao_ULA: std_logic_vector(2 downto 0);
			signal ULA_Resultado: std_logic_vector(31 downto 0);
			
			signal DeslocadorMux3x1: std_logic_vector(31 downto 0);

begin
			-- clock, reset: in std_logic;
			-- PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA: in std_logic;
			-- ULAFonteB, ULAOp, FontePC: in std_logic_vector(1 downto 0);
			
			-- opcode: out std_logic_vector(5 downto 0)
			
			PCEnable <= PCEsc or (PCEscCond and zero_end); 
			
			PC : dataregister port map(PCEnable, reset, clock, Mux_PC, PC_Mux);
			
			MuxEndereco : mux2x1_32 port map(IouD, PC_Mux, ULA_Saida, Mux_Memoria);
			
			Memoria : mem port map(clock, LerMem, EscMem, B_EscDado, Mux_Memoria, Memoria_Saida);
			
			RegistradorInstrucoes : dataregister port map(IREsc, reset, clock, Memoria_Saida, RegInstrucoes_Saida);
			
			RegistradorDadosMemoria : dataregister port map('1', reset, clock, Memoria_Saida, DadosMemoria_MuxDadoEsc);
			
			MuxRegEsc : mux2x1_5 port map(RegDst, RegInstrucoes_Saida(20 downto 16), RegInstrucoes_Saida(15 downto 11), MuxRegEsc_Registradores);	
			
			MuxDadoEsc : mux2x1_32 port map(MemParaReg, ULASaida_Mux, DadosMemoria_MuxDadoEsc, MuxDadoEsc_Registradores);
			
			Registradores : bank_registers generic map (32, 5) port map(clock, reset, EscReg, RegInstrucoes_Saida(25 downto 21), RegInstrucoes_Saida(20 downto 16),	MuxRegEsc_Registradores, dadoLido_A, dadoLido_B);
			
			ExtensaoSinal : extend16_32 port map(RegInstrucoes_Saida(15 downto 0), ExtensaoSinal_Saida);
			
			DeslocadorMux4x1 : shift port map(ExtensaoSinal_Saida, Deslocador_Mux4x1);
			
			A : dataregister port map('1', reset, clock, dadoLido_A, RegA_Saida);
			
			B : dataregister port map('1', reset, clock, dadoLido_B, RegB_Saida);
			
			MuxUlaA : mux2x1_32 port map(ULAFonteA, PC_Mux, RegA_Saida, MuxA_ULA);
			
			MuxUlaB : mux4x1_32 port map(ULAFonteB, RegB_Saida, quatro, ExtensaoSinal_Saida, Deslocador_Mux4x1, MuxB_ULA);
			
			OperacaoUla : operationULA port map(ULAOp, RegInstrucoes_Saida(5 downto 0), Operacao_ULA);
			
			aULA : ULA port map (MuxA_ULA, MuxB_ULA, Operacao_ULA, ULA_Resultado, zero_end);
			
			DeslocadorMux3x1 <= PC_Mux(31 downto 28)&RegInstrucoes_Saida(25 downto 0)&"00";
			
			ULASaida : dataregister port map('1', reset, clock, ULA_Resultado, ULA_Saida);
			
			MuxPC : mux3x1_32 port map(FontePC, ULA_Resultado, ULA_Saida, DeslocadorMux3x1, Mux_PC);
			
end architecture;
