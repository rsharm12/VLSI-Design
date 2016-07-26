library IEEE;
	 use IEEE.std_logic_1164.all;

entity fpmul1_gated is
	Port (	A1 : In std_logic_vector (31 downto 0);
		A2 : In std_logic_vector (31 downto 0);
		CLOCK : In std_logic;
		RESET : In std_logic;
		NEW_b : In std_logic;
		Z : Out std_logic_vector (31 downto 0) );
end fpmul1_gated;

architecture SCHEMATIC of fpmul1_gated is

   signal       BX : std_logic_vector(31 downto 0);
   signal       BY : std_logic_vector(31 downto 0);
   signal       MX : std_logic_vector(23 downto 0);
   signal       MY : std_logic_vector(23 downto 0);
   signal       MZ : std_logic_vector(23 downto 0);
   signal       EXP : std_logic_vector(7 downto 0);
   signal       EXP1 : std_logic_vector(7 downto 0);
   signal       EXP2 : std_logic_vector(7 downto 0);
   signal       EZ : std_logic_vector(7 downto 0);
   signal       OVF : std_logic;
   signal       SZ : std_logic;

   signal       PIPEe : std_logic_vector(7 downto 0);
   signal       PIPEe1 : std_logic_vector(7 downto 0);
   signal       PIPEe2 : std_logic_vector(7 downto 0);
   signal       PIPEo : std_logic;
   signal       PIPEo1 : std_logic;

   signal 	GT1 : std_logic;
   signal	GT2 : std_logic;
   signal	GT3 : std_logic;
   signal 	CLK1 : std_logic;
   signal	CLK2 : std_logic;
   signal	CLK3 : std_logic;

   component reg32b
	Port (	A : In std_logic_vector (31 downto 0);
		CLOCK : In std_logic;
		RESET : In std_logic;
		Z : Out std_logic_vector (31 downto 0) );
   end component;


   component out_sign
        Port (  sX   : In std_logic;
                sY   : In std_logic;
                SZ : Out std_logic );
   end component;

   component expadd
        Port (  A1 : In std_logic_vector (7 downto 0);
                A2 : In std_logic_vector (7 downto 0);
                S : Out std_logic_vector (7 downto 0) );
   end component;

   component expupdate
	Port (  EXP : In std_logic_vector (7 downto 0);
                OVF : In std_logic;
                EZ : Out std_logic_vector (7 downto 0) );
   end component;

   component  expincrement is
        Port (  EXP : In std_logic_vector (7 downto 0);
                EZ : Out std_logic_vector (7 downto 0) );
   end component;


   component significand_compute_gated 
        Port (  MX : In std_logic_vector (23 downto 0);
                MY : In std_logic_vector (23 downto 0);
		CLOCK : In std_logic;
		CLK1 : In std_logic;
		CLK2 : In std_logic;
		RESET : In std_logic;
                OVF : Out std_logic;
                Z : Out std_logic_vector (23 downto 0) );
   end component;

   component gl_mux21 
        GENERIC(n : integer);
        Port (  A0 : In std_logic_vector (n downto 0);
                A1 : In std_logic_vector (n downto 0);
                SEL : In std_logic;
                Z : Out std_logic_vector (n downto 0) );
   end component;

   component reg24b
	Port (	A : In std_logic_vector (23 downto 0);
		CLOCK : In std_logic;
		RESET : In std_logic;
		Z : Out std_logic_vector (23 downto 0) );
   end component;


   component nandgate
	Port (	A : In std_logic;
		B : In std_logic;
		Z : Out std_logic );
   end component;

   component reg8b
	Port (	A : In std_logic_vector (7 downto 0);
		CLOCK : In std_logic;
		RESET : In std_logic;
		Z : Out std_logic_vector (7 downto 0) );
   end component;

   component reg1b
	Port (	A : In std_logic;
		CLOCK : In std_logic;
		RESET : In std_logic;
		Z : Out std_logic );
   end component;


begin


   GATE1 : reg1b
	Port Map ( A=>NEW_b, CLOCK=>CLOCK,
		 RESET=>RESET, Z=>GT1 );
   
   NAND1 : nandgate
	Port Map ( A=>GT1, B=>CLOCK, Z=>CLK1 );

   I_1 : reg32b
	Port Map ( A(31 downto 0)=>A1(31 downto 0), CLOCK=>CLOCK,
		 RESET=>RESET, Z(31 downto 0)=>BX(31 downto 0) );
   I_2 : reg32b
	Port Map ( A(31 downto 0)=>A2(31 downto 0), CLOCK=>CLOCK,
		 RESET=>RESET, Z(31 downto 0)=>BY(31 downto 0) );

   I_4 : expadd
	Port Map ( A1(7 downto 0)=>BX(30 downto 23), 
		   A2(7 downto 0)=>BY(30 downto 23),
		   S(7 downto 0)=>EXP(7 downto 0) );

   GATE2 : reg1b
	Port Map ( A=>GT1, CLOCK=>CLOCK,
		 RESET=>RESET, Z=>GT2 );
   NAND2 : nandgate
	Port Map ( A=>GT2, B=>CLOCK, Z=>CLK2 );
	
   PIPE5 : reg8b
	Port Map ( A(7 downto 0)=>EXP(7 downto 0), CLOCK=>CLK1,
		 RESET=>RESET, Z(7 downto 0)=>PIPEe2(7 downto 0) );

   PIPE6 : reg8b
	Port Map ( A(7 downto 0)=>PIPEe2(7 downto 0), CLOCK=>CLK2,
		 RESET=>RESET, Z(7 downto 0)=>EXP2(7 downto 0) );
 
   I_6 : expincrement
	Port Map ( EXP(7 downto 0)=>EXP(7 downto 0), 
		   EZ(7 downto 0)=>PIPEe(7 downto 0) );

   PIPE1 : reg8b
	Port Map ( A(7 downto 0)=>PIPEe(7 downto 0), CLOCK=>CLK1,
		 RESET=>RESET, Z(7 downto 0)=>PIPEe1(7 downto 0) );

   PIPE2 : reg8b
	Port Map ( A(7 downto 0)=>PIPEe1(7 downto 0), CLOCK=>CLK2,
		 RESET=>RESET, Z(7 downto 0)=>EXP1(7 downto 0) );

   -- must include inplicit 1
   MX(23)<='1'; MX(22 downto 0) <= BX(22 downto 0); 
   MY(23)<='1'; MY(22 downto 0) <= BY(22 downto 0); 

   I_5 : significand_compute_gated
	Port Map ( MX=>MX, MY=>MY, CLOCK=>CLOCK,CLK1=>CLK1, CLK2=>CLK2, RESET=>RESET, OVF=>OVF, Z=>MZ );

   EXP_MUX : gl_mux21 Generic Map(n=>7)
        Port Map ( A0 => EXP2, A1  => EXP1, SEL => OVF, Z => EZ );


   I_7 : out_sign
	Port Map (  SX=>BX(31), SY=>BY(31), SZ=>PIPEo );

   PIPE3 : reg1b
	Port Map ( A=>PIPEo, CLOCK=>CLK1,
		 RESET=>RESET, Z=>PIPEo1 );
   PIPE4 : reg1b
	Port Map ( A=>PIPEo1, CLOCK=>CLK2,
		 RESET=>RESET, Z=>SZ );
   GATE3 : reg1b
	Port Map ( A=>GT2, CLOCK=>CLOCK,
		 RESET=>RESET, Z=>GT3 );
   NAND3 : nandgate
	Port Map ( A=>GT3, B=>CLOCK, Z=>CLK3 );

   I_3 : reg32b
	Port Map ( A(31)=>SZ,
		   A(30 downto 23)=>EZ(7 downto 0), 
		   A(22 downto 0)=>MZ(22 downto 0), 
		   CLOCK=>CLK3, RESET=>RESET, 
                   Z(31 downto 0)=>Z(31 downto 0) );

end SCHEMATIC;

configuration CFG_FPMUL1_GATED_SCHEMATIC of FPMUL1_GATED is

   for SCHEMATIC
      for I_1, I_2, I_3: reg32b
         use configuration WORK.CFG_reg32b_BEHAVIORAL;
      end for;
      for I_4: expadd
         use configuration WORK.CFG_expadd_BEHAVIORAL;
      end for;
      for I_5: significand_compute_gated
         use configuration WORK.CFG_significand_compute_gated_SCHEMATIC;
      end for;
      for I_6: expincrement
         use configuration WORK.CFG_expincrement_BEHAVIORAL;
      end for;
      for I_7: out_sign 
         use configuration WORK.CFG_out_sign_BEHAVIORAL;
      end for;
      for EXP_MUX : gl_mux21
         use configuration WORK.CFG_gl_mux21_BEHAVIORAL;
      end for;
      for PIPE1, PIPE2, PIPE5, PIPE6 : reg8b
         use configuration WORK.CFG_reg8b_BEHAVIORAL;
      end for;
      for PIPE3, PIPE4, GATE1, GATE2, GATE3 : reg1b
         use configuration WORK.CFG_reg1b_BEHAVIORAL;
      end for;
      for NAND1, NAND2, NAND3 : nandgate
	 use configuration WORK.CFG_nandgate_BEHAVIORAL;
      end for;

   end for;

end CFG_FPMUL1_GATED_SCHEMATIC;
	

