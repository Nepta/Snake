library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dffe is
	generic(
		n: natural:=1
	);
	
	port(
		clk, raza: in std_logic;
		dataIn: in std_logic_vector(n-1 downto 0);
		en: std_logic;
		dataOut: out std_logic_vector(n-1 downto 0)
	);
end entity;

architecture Behavioral of dffe is
	signal qint, mux: std_logic_vector(n-1 downto 0);
begin
	dataOut <= qint;
	qint <= (others => '0') when raza='1' else mux when rising_edge(clk); 
	mux <= qint when en = '0' else dataIn;
end architecture;
