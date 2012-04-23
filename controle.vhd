library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controle is
	port(
		cmpt_pixel, cmpt_ligne: in std_logic_vector(9 downto 0);

		hsync, vsync, blank: out std_logic;
		sync: out std_logic
		
	);
end entity;

architecture Behavioral of controle is
	signal enable_ligne: std_logic;
	begin

	vsync <= '0' when (unsigned(cmpt_ligne) = 1) or (unsigned(cmpt_ligne) = 0) else '1';
	hsync <= '0' when 0 <= unsigned(cmpt_pixel) and unsigned(cmpt_pixel) < 94 else '1';
	blank <= '1' when 34 <= unsigned(cmpt_ligne) and unsigned(cmpt_ligne) < 514 and 138 <= unsigned(cmpt_pixel) and unsigned(cmpt_pixel) < 777 else '0';
	sync  <='1';
	

end Behavioral;