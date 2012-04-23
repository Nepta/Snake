library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity button is
	port(
		button, clk: in std_logic;
		trigger: out std_logic
	);
end entity;

architecture Behavioral of button is
	signal buttonCliked, resync: std_logic;
begin
	buttonCliked <= '0' when resync = '1' else '1' when falling_edge(button);
	resync <= buttonCliked when rising_edge(clk);
	trigger <= resync;
end Behavioral;
