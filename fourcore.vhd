library IEEE;
	 use IEEE.std_logic_1164.all;

entity fourcore is
	Port (	X0 : In std_logic_vector (31 downto 0);
		X1 : In std_logic_vector (31 downto 0);
		X2 : In std_logic_vector (31 downto 0);
		X3 : In std_logic_vector (31 downto 0);
		Y0 : In std_logic_vector (31 downto 0);
		Y1 : In std_logic_vector (31 downto 0);
		Y2 : In std_logic_vector (31 downto 0);
		Y3 : In std_logic_vector (31 downto 0);
		CLOCK : In std_logic;
		RESET : In std_logic;
		P0 : Out std_logic_vector (31 downto 0);
		P1 : Out std_logic_vector (31 downto 0);
		P2 : Out std_logic_vector (31 downto 0);
		P3 : Out std_logic_vector (31 downto 0) );
end fourcore;

architecture SCHEMATIC of fourcore is

   component fpmul1
	Port (	A1 : In std_logic_vector (31 downto 0);
		A2 : In std_logic_vector (31 downto 0);
		CLOCK : In std_logic;
		RESET : In std_logic;
		Z : Out std_logic_vector (31 downto 0) );
   end component;

begin

   I_1 : fpmul1
	Port Map ( A1(31 downto 0)=>X0(31 downto 0), A2(31 downto 0)=>Y0(31 downto 0), 
		 CLOCK=>CLOCK, RESET=>RESET, Z(31 downto 0)=>P0(31 downto 0) );

   I_2 : fpmul1
	Port Map ( A1(31 downto 0)=>X1(31 downto 0), A2(31 downto 0)=>Y1(31 downto 0), 
		 CLOCK=>CLOCK, RESET=>RESET, Z(31 downto 0)=>P1(31 downto 0) );

   I_3 : fpmul1
	Port Map ( A1(31 downto 0)=>X2(31 downto 0), A2(31 downto 0)=>Y2(31 downto 0), 
		 CLOCK=>CLOCK, RESET=>RESET, Z(31 downto 0)=>P2(31 downto 0) );

   I_4 : fpmul1
	Port Map ( A1(31 downto 0)=>X3(31 downto 0), A2(31 downto 0)=>Y3(31 downto 0), 
		 CLOCK=>CLOCK, RESET=>RESET, Z(31 downto 0)=>P3(31 downto 0) );

end SCHEMATIC;

configuration CFG_FOURCORE_SCHEMATIC of FOURCORE is

   for SCHEMATIC
      for I_1, I_2, I_3, I_4: fpmul1
         use configuration WORK.CFG_fpmul1_SCHEMATIC;
      end for;

   end for;

end CFG_FOURCORE_SCHEMATIC;




