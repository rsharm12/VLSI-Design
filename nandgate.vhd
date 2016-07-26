--VHDL Code for NAND Gate:
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

---------------------------------- Entity Declarations -------------------------

entity nandgate is

      Port( A : in std_logic;
            B : in std_logic;
            Z : out std_logic );

end nandgate;

architecture BEHAVIORAL of nandgate is

begin
Z <= (A nand (not B));
end BEHAVIORAL;

configuration CFG_nandgate_BEHAVIORAL of nandgate is
	 for BEHAVIORAL
	 end for;
end CFG_nandgate_BEHAVIORAL;
