library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga is
	port(
		clk, raza: in std_logic;
		red, green, blue: out std_logic_vector(9 downto 0);

		speed: in std_logic_vector(9 downto 0);
		x: in std_logic;
		speedout: out std_logic_vector(9 downto 0);
		
		hsync, vsync, blank: out std_logic;
		clk_vga: out std_logic;
		sync: out std_logic
		
	);
end entity;

architecture controle of vga is
	signal cmpt_pixel, cmpt_ligne: std_logic_vector(9 downto 0);
	signal enable_ligne, div2, div2int: std_logic;

	signal xOffset: std_logic_vector(9 downto 0);
	signal speedy: std_logic;
	signal speedint: std_logic_vector(9 downto 0);
	
begin
--	
--	U0: entity work.carre(Behavioral)
--				port map(
--					cmpt_pixel => cmpt_pixel,
--					cmpt_ligne => cmpt_ligne,
--					cote => std_logic_vector(to_unsigned(10,10)),
--					positionX => std_logic_vector(unsigned(offset)),
--					positionY => std_logic_vector(to_unsigned(225,10)),
--					interieur => carre0
--				)
--		;
--		
--		
--		
--	U1: entity work.carre(Behavioral)
--				port map(
--					cmpt_pixel => cmpt_pixel,
--					cmpt_ligne => cmpt_ligne,
--					cote => std_logic_vector(to_unsigned(100,10)),
--					positionX => std_logic_vector(unsigned(xOffset)),
--					positionY => std_logic_vector(to_unsigned(225,10)),
--					interieur => carre0
--				)
--		;
		
--	U2: entity work.carre(Behavioral)
--				port map(
--					cmpt_pixel => cmpt_pixel,
--					cmpt_ligne => cmpt_ligne,
--					cote => std_logic_vector(to_unsigned(42,10)),
--					positionX => std_logic_vector(unsigned(offset)),
--					positionY => std_logic_vector(to_unsigned(225,10)),
--					interieur => carre0
--				)
--		;
--		
--			U0: entity work.carre(Behavioral)
--				port map(
--					cmpt_pixel => cmpt_pixel,
--					cmpt_ligne => cmpt_ligne,
--					cote => std_logic_vector(to_unsigned(40,10)),
--					positionX => std_logic_vector(unsigned(offset)),
--					positionY => std_logic_vector(to_unsigned(225,10)),
--					interieur => carre0
--				)
--		;
--			
		synch: entity work.controle(Behavioral)
				port map(
					cmpt_pixel => cmpt_pixel,
					cmpt_ligne => cmpt_ligne,
					hsync => hsync,
					vsync => vsync,
					blank => blank,
					sync => sync)
		;
		
		C1: entity work.cptbe(Behavioral)
				generic map(
					n => 525
				)
				port map(
					h => clk,
					raza => raza,
					en => enable_ligne,
					val => cmpt_ligne
				)
		;

		
		C2: entity work.cptbe(Behavioral)
				generic map(
					n => 794
				)
				port map(
					h => clk,
					raza => raza,
					en => div2,
					val => cmpt_pixel
				)
		;

		exertier: entity work.clock_divider(RTL)
				generic map(
					board_frequency => 50_000_000.0,
					user_frequency => 50.0
				)
				port map(
					clk => clk,
					resetn => raza,
					en_user => speedy
				)
		;
		
 
		Xaxis: entity work.inversibleCompteur(Behavioral)
					generic map(
						n => 7
					)
					port map(
						clk => clk,
						raza => raza,
						en => speedy,
						sens => x,
						val => xOffset
					)
		;
		
--		seven: entity work.seven_segment_decoder(RTL)
--					port map(
--						
--					)
--		;
--		
	speedint(0) <= not speedint(0) when rising_edge(speedy);
	speedout <= xOffset;
	
	enable_ligne <= '1' when div2 = '1' and unsigned(cmpt_pixel) = 0 else '0';

	div2int <= not div2;
	div2 <= '0' when raza = '0' else div2int when rising_edge(clk);
	clk_vga <= div2;


	
	--red <= (others => '0');
	--green <= (others => '1');
	--blue <= (others => '0');
	
	
end controle;