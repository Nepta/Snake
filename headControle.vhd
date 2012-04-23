library ieee;
use ieee.std_logic_1164.all;

entity headControle is
	port(
		l,r,u,d: in std_logic;
		clk,raza: in std_logic;
		Haut,Gauche,Droite,Bas: out std_logic
	);
end entity;

architecture stateMachine of headControle is
	type state is (pUp, pDown, pLeft, pRight);
	signal present, futur: state;
begin

evolution:
process (present, l,r,u,d)
begin
	futur <= present;
	case present is
		when pDown 	=> if r = '1' then futur <= pRight;
							elsif l = '1' then futur <= pLeft; end if;
							
		when pUp 	=> if r = '1' then futur <= pRight;
							elsif l = '1' then futur <= pLeft; end if;
							
		when pRight => if u = '1' then futur <= pUp;
							elsif d = '1' then futur <= pDown; end if;
							
		when pLeft 	=> if u = '1' then futur <= pUp;
							elsif d = '1' then futur <= pDown; end if;
	end case;
end process;

synchronisation:
process (clk,raza)
begin
	if raza = '1' then present <= pRight;
	elsif rising_edge(clk) then present <= futur;
	end if;
end process;

actions:
process (present)
begin
	Haut <= '0';
	Bas <= '0';
	Gauche <= '0';
	Droite <= '0';

	case present is
		when pUp => Haut <= '1';
		when pDown => Bas <= '1';
		when pLeft => Gauche <= '1';
		when pRight => Droite <= '1';
		when others => null;
	end case;
end process;

end architecture;
		

