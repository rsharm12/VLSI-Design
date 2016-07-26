-- ---------------------------------------------------------------
-- File Name : reg32b.vhd
-- Date Created : 02/12/04 at 16:20
-- ---------------------------------------------------------------

-- ---------------------------------------------------------------
-- File Name : reg32b.vhd
-- Date Created : 02/02/2004 at 17:11:08
-- ---------------------------------------------------------------

library IEEE;
	 use IEEE.std_logic_1164.all;

entity reg1b is
	Port (	A : In std_logic;
		CLOCK : In std_logic;
		RESET : In std_logic;
		Z : Out std_logic );
end reg1b;

architecture BEHAVIORAL of reg1b is

 begin
   process(clock, reset)
   begin
     if ( reset = '0' ) then
	 Z <= '0' ;
     elsif (( clock = '1' ) and (clock'EVENT)) then
	 Z <= A;
     end if;
   end process;

end BEHAVIORAL;

configuration CFG_reg1b_BEHAVIORAL of reg1b is
	 for BEHAVIORAL
	 end for;
end CFG_reg1b_BEHAVIORAL;
