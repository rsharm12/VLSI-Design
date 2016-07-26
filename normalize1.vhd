library IEEE;
use IEEE.std_logic_1164.all;

entity normalize1 is
Port ( A : In std_logic_vector (47 downto 0);
Z : Out std_logic_vector (23 downto 0) );
end normalize1 ;

architecture BEHAVIORAL of normalize1 is

begin
process(A)
variable p,s : std_logic_vector (24 downto 0) ;
variable carry : std_logic;
variable guard : std_logic;
variable sticky : std_logic;
begin

if (A(47) = '0') then
p:= A(46 downto 22);
else
p:= A(47 downto 23);
end if;

carry:='1';
for i in 0 to 24 loop
s(i) := p(i) XOR carry;
carry := p(i) AND carry;
end loop;


Z <= s(24 downto 1);
end process;
end BEHAVIORAL;

configuration CFG_normalize1_BEHAVIORAL of normalize1 is
for BEHAVIORAL
end for;
end CFG_normalize1_BEHAVIORAL;
