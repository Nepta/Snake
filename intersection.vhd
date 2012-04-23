--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.numeric_std.ALL;
--
--entity intersection is
--	port(
--		red1, green1, blue1: in std_logic_vector(9 downto 0);
--		red2, green2, blue2: in std_logic_vector(9 downto 0);
--		intersect: out std_logic
--	);
--end entity;
--
--architecture Behavioral of intersection is
--	signal color1: unsigned(3*10-1 downto 0);
--	signal color2: unsigned(3*10-1 downto 0);
--begin
--	color1 <= red1&green1&blue1;
--	color2 <= red2&green2&blue2;
--	
--	intersect <= color1 > 0 and color2 > 0;
--	
--end Behavioral;