library IEEE;
	 use IEEE.std_logic_1164.all;

entity fourcore_gated is
	Port (	X0 : In std_logic_vector (31 downto 0);
		X1 : In std_logic_vector (31 downto 0);
		X2 : In std_logic_vector (31 downto 0);
		X3 : In std_logic_vector (31 downto 0);
		Y0 : In std_logic_vector (31 downto 0);
		Y1 : In std_logic_vector (31 downto 0);
		Y2 : In std_logic_vector (31 downto 0);
		Y3 : In std_logic_vector (31 downto 0);
		A0 : In std_logic;
		A1 : In std_logic;
		A2 : In std_logic;
		A3 : In std_logic;
		CLOCK : In std_logic;
		RESET : In std_logic;
		P0 : Out std_logic_vector (31 downto 0);
		P1 : Out std_logic_vector (31 downto 0);
		P2 : Out std_logic_vector (31 downto 0);
		P3 : Out std_logic_vector (31 downto 0) );
end fourcore_gated;

architecture SCHEMATIC of fourcore_gated is

   component fpmul1_gated
	Port (	A1 : In std_logic_vector (31 downto 0);
		A2 : In std_logic_vector (31 downto 0);
		CLOCK : In std_logic;
		RESET : In std_logic;
		NEW_b : In std_logic;
		Z : Out std_logic_vector (31 downto 0) );
   end component;

begin

   I_1 : fpmul1_gated
	Port Map ( A1(31 downto 0)=>X0(31 downto 0), A2(31 downto 0)=>Y0(31 downto 0), 
		 CLOCK=>CLOCK, RESET=>RESET, NEW_b=>A0, Z(31 downto 0)=>P0(31 downto 0) );

   I_2 : fpmul1_gated
	Port Map ( A1(31 downto 0)=>X1(31 downto 0), A2(31 downto 0)=>Y1(31 downto 0), 
		 CLOCK=>CLOCK, RESET=>RESET, NEW_b=>A1, Z(31 downto 0)=>P1(31 downto 0) );

   I_3 : fpmul1_gated
	Port Map ( A1(31 downto 0)=>X2(31 downto 0), A2(31 downto 0)=>Y2(31 downto 0), 
		 CLOCK=>CLOCK, RESET=>RESET, NEW_b=>A2, Z(31 downto 0)=>P2(31 downto 0) );

   I_4 : fpmul1_gated
	Port Map ( A1(31 downto 0)=>X3(31 downto 0), A2(31 downto 0)=>Y3(31 downto 0), 
		 CLOCK=>CLOCK, RESET=>RESET, NEW_b=>A3, Z(31 downto 0)=>P3(31 downto 0) );

end SCHEMATIC;

configuration CFG_FOURCORE_GATED_SCHEMATIC of FOURCORE_GATED is

   for SCHEMATIC
      for I_1, I_2, I_3, I_4: fpmul1_gated
         use configuration WORK.CFG_fpmul1_gated_SCHEMATIC;
      end for;

   end for;

end CFG_FOURCORE_GATED_SCHEMATIC;




