library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity snakeSpeed is
    Port ( en : in  STD_LOGIC;
           raza : in  STD_LOGIC;
           h : in  STD_LOGIC;
			  
			  max: in std_logic_vector(9 downto 0);
           val : out  STD_LOGIC_VECTOR (9 downto 0));
end snakeSpeed;

architecture Behavioral of snakeSpeed is
signal valint, valint1, valint2:STD_LOGIC_VECTOR (9 downto 0);
begin

valint<=(others=> '0') when raza='0' else valint1 when rising_edge(h); 
valint1<= valint2 when en='1' else valint;
valint2<= (others=> '0') when unsigned(valint)> unsigned(max) else std_logic_vector(unsigned(valint)+1);
val<=valint;
end Behavioral;
