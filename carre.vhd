library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity carre is
	port(
		cmpt_pixel, cmpt_ligne: in std_logic_vector(9 downto 0);
		cote, positionX, positionY: in std_logic_vector(9 downto 0); -- generique?
		interieur: out std_logic
	);
end entity;


architecture Behavioral of carre is
 signal okX, okY: std_logic;
	begin
		okX <= '1' when unsigned(positionX) <= unsigned(cmpt_pixel) - 138 and unsigned(cmpt_pixel) - 138 <= unsigned(positionX) + unsigned(cote) else '0';
		okY <= '1' when unsigned(positionY) <= unsigned(cmpt_ligne) - 34 and unsigned(cmpt_ligne) - 34 <= unsigned(positionY) + unsigned(cote) else '0';
		interieur <= '1' when okX = '1' and okY = '1' else '0';
end Behavioral;