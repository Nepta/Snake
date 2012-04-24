library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity inversibleCompteur is
	generic(
		n:natural:=600
	);
	Port(
		en : in  STD_LOGIC;
		raza : in  STD_LOGIC;
		clk : in  STD_LOGIC;
		sens: in std_logic;
		val : out  STD_LOGIC_VECTOR (9 downto 0)
	);
	
end inversibleCompteur;

architecture Behavioral of inversibleCompteur is
	signal registre, modulo, mux, enable: unsigned(9 downto 0);
begin
	registre <= (others => '0') when raza = '0' else enable when rising_edge(clk); 
	mux <= registre + 1 when sens = '1' else registre - 1;
	modulo <= to_unsigned(n,10) when mux > n else mux;
	enable <= modulo when en = '1' else registre;
	val <= std_logic_vector(registre);
end Behavioral;
