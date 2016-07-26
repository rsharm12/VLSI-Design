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

entity reg48b is
	Port (	A : In std_logic_vector (47 downto 0);
		CLOCK : In std_logic;
		RESET : In std_logic;
		Z : Out std_logic_vector (47 downto 0) );
end reg48b;

architecture BEHAVIORAL of reg48b is

 begin
   process(clock, reset)
   begin
     if ( reset = '0' ) then
	 Z <= "000000000000000000000000000000000000000000000000" ;
     elsif (( clock = '1' ) and (clock'EVENT)) then
	 Z <= A;
     end if;
   end process;

end BEHAVIORAL;

configuration CFG_reg48b_BEHAVIORAL of reg48b is
	 for BEHAVIORAL
	 end for;
end CFG_reg48b_BEHAVIORAL;
