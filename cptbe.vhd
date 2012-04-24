library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity cptbe is  generic (n:natural:=4);
    Port ( en : in  STD_LOGIC;
           raza : in  STD_LOGIC;
           h : in  STD_LOGIC;
           val : out  STD_LOGIC_VECTOR (9 downto 0));
end cptbe;

architecture Behavioral of cptbe is
signal valint, valint1, valint2:STD_LOGIC_VECTOR (9 downto 0);
begin

valint<=(others=> '0') when raza='0' else valint1 when rising_edge(h); 
valint1<= valint2 when en='1' else valint;
valint2<= (others=> '0') when unsigned(valint)= n else std_logic_vector(unsigned(valint)+1);
val<=valint;
end Behavioral;
