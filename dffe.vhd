library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity userDffe is
	port(
		clk, raza: in std_logic;
		dataIn: in std_logic;
		ena: std_logic;
		dataOut: out std_logic
	);
end userDffe;

architecture Behavioral of userDffe is
	signal qint, mux: std_logic;
begin
	dataOut <= qint;
	qint <= '0' when raza='0' else mux when rising_edge(clk); 
	mux <= qint when ena = '0' else dataIn;
end Behavioral;
