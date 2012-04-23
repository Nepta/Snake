-------------------------------------------
-- decodeur 7 segments
-------------------------------------------
-- ESIEE
-- Creation     : A. Exertier, 11/2004
-- Modification : A. Exertier, 08/2008
-------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
---------------------------------------------------
--               Entrees
---------------------------------------------------
-- hexa 	    : entree code hexadacimal (4 bits)
---------------------------------------------------
--             sorties
---------------------------------------------------
--		a : segment horizontal superieur
--		b : segment vertical superieur droit
--		c : segment vertical inferieur droit
--		d : segment horizontal inferieur
--		e : segment vertical indefieur gauche
--		f : segment vertical superieur gauche
--		g : segment horizontal milieu
---------------------------------------------------
entity seven_segment_decoder  is
  port (
        hexa3 : in  std_logic;
        hexa2 : in  std_logic;
        hexa1 : in  std_logic;
        hexa0 : in  std_logic;
        a     : out std_logic;
        b     : out std_logic;
        c     : out std_logic;
        d     : out std_logic;
        e     : out std_logic;
        f     : out std_logic;
        g     : out std_logic
        );
end ;

----------------------------------------------------------------------
architecture RTL of  seven_segment_decoder is
 signal hexa    :  std_logic_vector(3 downto 0);
 signal abcdefg :  std_logic_vector(6 downto 0);
begin
  hexa <= hexa3&hexa2&hexa1&hexa0;
  a    <= abcdefg(6);
  b    <= abcdefg(5);
  c    <= abcdefg(4);
  d    <= abcdefg(3);
  e    <= abcdefg(2);
  f    <= abcdefg(1);
  g    <= abcdefg(0);  
 process(hexa)
 begin
  case hexa is
    when "0000" => abcdefg <= "0000001";  -- 0
    when "0001" => abcdefg <= "1001111";  -- 1
    when "0010" => abcdefg <= "0010010";  -- 2
    when "0011" => abcdefg <= "0000110";  -- 3
    when "0100" => abcdefg <= "1001100";  -- 4
    when "0101" => abcdefg <= "0100100";  -- 5
    when "0110" => abcdefg <= "0100000";  -- 6
    when "0111" => abcdefg <= "0001111";  -- 7
    when "1000" => abcdefg <= "0000000";  -- 8
    when "1001" => abcdefg <= "0000100";  -- 9
    when "1010" => abcdefg <= "0001000";  -- A
    when "1011" => abcdefg <= "1100000";  -- B
    when "1100" => abcdefg <= "0110001";  -- C
    when "1101" => abcdefg <= "1000010";  -- D
    when "1110" => abcdefg <= "0110000";  -- E
    when "1111" => abcdefg <= "0111000";  -- F
    when others => abcdefg <= "1111111";
  end case;
 end process;
end ;
