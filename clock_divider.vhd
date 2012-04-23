------------------------------------------------------
--      Clock Divider
------------------------------------------------------
-- Creation : A. Exertier, 2005
------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------
--                PARAMETRES GENERIQUES
------------------------------------------------------
-- board_frequency  : frequency of the FPGA
-- user_frequency   : desired frequency
------------------------------------------------------
--                   INPUTS
------------------------------------------------------
-- clk      : main clock
-- resetn   : asynchronous active low reset
------------------------------------------------------
--                   OUTPUT
------------------------------------------------------
-- en_user  : signal at user_frequency
--            set to 1 only 1 main clock cycle
------------------------------------------------------


entity clock_divider is	
  generic(
    board_frequency   : real :=50_000_000.0; -- 50 MHz
	 user_frequency    : real :=4.0);          -- 4 Hz
  Port (
    clk           : in  std_logic;  
    resetn        : in  std_logic;  -- active low
	 en_user       : out std_logic);
end clock_divider;

architecture RTL of clock_divider is
  constant max     : natural := integer(board_frequency/user_frequency);  
begin
  process(clk,resetn)
      variable counter : natural range 0 to max-1;
  begin
   if resetn='0' then 			 
     counter := 0;
     en_user <= '0';
   elsif rising_edge(clk) then 
     if counter = max-1 then 
       counter	:= 0;
       en_user <= '1';	
     else 
       counter := counter+1;
       en_user <= '0';
     end if;
   end if;
  end process;
end RTL;
