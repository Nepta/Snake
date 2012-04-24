library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga is
	port(
		clk, raza: in std_logic;
		red, green, blue: out std_logic_vector(9 downto 0);
		
		hsync, vsync, blank: out std_logic;
		clk_vga: out std_logic;
		sync: out std_logic;

		fourKey: in std_logic_vector(3 downto 0);
		fourLed: out std_logic_vector(3 downto 0)
	);
end entity;

architecture controle of vga is
	-- vga synchronisation stuff
	signal cmpt_pixel, cmpt_ligne: std_logic_vector(9 downto 0);
	signal enable_ligne, div2, div2int: std_logic;

	-- Clock to speed down the game
	signal humanClock: std_logic;
	
	-- signal to manage snake's moves
	signal xAxisMove, yAxisMove: std_logic;
	signal xAxisMoveInt, yAxisMoveInt: std_logic;
	
	-- Movable object
	signal carre0: std_logic;
	signal xOffset, yOffset: std_logic_vector(9 downto 0);


	-- Snake
	signal brain, bodyWave: std_logic_vector(3 downto 0);
begin
	
	-- maybe use a componant?
	div2int <= not div2;
	div2 <= '0' when raza = '0' else div2int when rising_edge(clk);
	clk_vga <= div2;


	U0: entity work.carre(Behavioral)
			port map(
				cmpt_pixel => cmpt_pixel,
				cmpt_ligne => cmpt_ligne,
				cote => std_logic_vector(to_unsigned(10,10)),
				positionX => xOffset,
				positionY => yOffset,
				interieur => carre0
			)
		;

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

	red <= (others => '0') when carre0 = '1' else (others => '1');
	green <= (others => '1');
	blue <= (others => '0');


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
					en_user => humanClock
				)
		;
		
 
		Xaxis: entity work.inversibleCompteur(Behavioral)
					generic map(
						n => 640
					)
					port map(
						clk => clk,
						raza => raza,
						en => xAxisMove,
						sens => bodyWave(0),
						val => xOffset
					)
		;
		
		Yaxis: entity work.inversibleCompteur(Behavioral)
					generic map(
						n => 480
					)
					port map(
						clk => clk,
						raza => raza,
						en => yAxisMove,
						sens => bodyWave(3),
						val => yOffset
					)
		;
-- TODO componant style vhdl to make the joystick
	buttonUp: entity work.button(Behavioral)
		port map(
			clk => clk,
			button => fourKey(0),
			trigger => brain(0)
		)
	;
	
	buttonDown: entity work.button(Behavioral)
		port map(
			clk => clk,
			button => fourKey(1),
			trigger => brain(1)
		)
	;
	
	buttonLeft: entity work.button(Behavioral)
		port map(
			clk => clk,
			button => fourKey(2),
			trigger => brain(2)
		)
	;
	
	buttonRigth: entity work.button(Behavioral)
		port map(
			clk => clk,
			button => fourKey(3),
			trigger => brain(3)
		)
	;
	

	snakeHead: entity work.headControle(stateMachine)
		port map(
			l => brain(0),
			r => brain(1),
			u => brain(2),
			d => brain(3),
			clk => clk,
			raza => raza,
			Gauche => bodyWave(0),
			Droite => bodyWave(1),
			Haut => bodyWave(2),
			Bas => bodyWave(3)
		)
	;	
	
	enable_ligne <= '1' when div2 = '1' and unsigned(cmpt_pixel) = 0 else '0';

	xAxisMoveInt <= '1' when bodyWave(0) = '1' or bodyWave(2) = '1';
	yAxisMoveInt <= bodyWave(1) or bodyWave(3);

	directionX: entity work.dffe(Behavioral) port map(clk => clk, raza => raza, dataIn => xAxisMoveInt, en => humanClock, dataOut => xAxisMove);
	
	directionY: entity work.dffe(Behavioral) port map(clk => clk, raza => raza, dataIn => yAxisMoveInt, en => humanClock, dataOut => xAxisMove);
	
	fourLed <= bodyWave;
	
end controle;

