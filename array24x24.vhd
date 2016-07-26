-- ---------------------------------------------------------------
-- File Name : swap24b.vhd
-- Date Created : 02/12/04 at 16:20
-- ---------------------------------------------------------------

library IEEE;
	 use IEEE.std_logic_1164.all;

entity array24x24 is
	Port (	X : In std_logic_vector (23 downto 0);
		Y : In std_logic_vector (23 downto 0);
		CLOCK : In std_logic;
		RESET : In std_logic;
		S : Out std_logic_vector (47 downto 0) ;
		C : Out std_logic_vector (47 downto 0) );
end array24x24;

architecture SCHEMATIC of array24x24 is

CONSTANT n : integer := 47;
CONSTANT p : integer := 25;
   signal       P0 : std_logic_vector(p downto 0);
   signal       P1 : std_logic_vector(p downto 0);
   signal       P2 : std_logic_vector(p downto 0);
   signal       P3 : std_logic_vector(p downto 0);
   signal       P4 : std_logic_vector(p downto 0);
   signal       P5 : std_logic_vector(p downto 0);
   signal       P6 : std_logic_vector(p downto 0);
   signal       P7 : std_logic_vector(p downto 0);
   signal       P8 : std_logic_vector(p downto 0);
   signal       P9 : std_logic_vector(p downto 0);
   signal       PA : std_logic_vector(p downto 0);
   signal       PB : std_logic_vector(p downto 0);
   signal       PC : std_logic_vector(p downto 0);
   signal       P0p : std_logic_vector(p downto 0);
   signal       P1p : std_logic_vector(p downto 0);
   signal       P2p : std_logic_vector(p downto 0);
   signal       P3p : std_logic_vector(p downto 0);
   signal       P4p : std_logic_vector(p downto 0);
   signal       P5p : std_logic_vector(p downto 0);
   signal       P6p : std_logic_vector(p downto 0);
   signal       P7p : std_logic_vector(p downto 0);
   signal       P8p : std_logic_vector(p downto 0);
   signal       P9p : std_logic_vector(p downto 0);
   signal       PAp : std_logic_vector(p downto 0);
   signal       PBp : std_logic_vector(p downto 0);
   signal       PCp : std_logic_vector(p downto 0);
   signal       zz : std_logic_vector(n downto 0);
   signal       f : std_logic_vector(n downto 0);
   signal       N0 : std_logic;
   signal       N1 : std_logic;
   signal       N2 : std_logic;
   signal       N3 : std_logic;
   signal       N4 : std_logic;
   signal       N5 : std_logic;
   signal       N6 : std_logic;
   signal       N7 : std_logic;
   signal       N8 : std_logic;
   signal       N9 : std_logic;
   signal       NA : std_logic;
   signal       NB : std_logic;
   signal       NC : std_logic;
   signal      ZERO : std_logic;
   signal      pack1 : std_logic_vector(2 downto 0);

   component TREE
      Port (      N0 : In    std_logic;
                  N1 : In    std_logic;
                  N2 : In    std_logic;
                  N3 : In    std_logic;
                  N4 : In    std_logic;
                  N5 : In    std_logic;
                  N6 : In    std_logic;
                  N7 : In    std_logic;
                  N8 : In    std_logic;
                  N9 : In    std_logic;
                  NA : In    std_logic;
                  NB : In    std_logic;
                  P0 : In    std_logic_vector (p downto 0);
                  P1 : In    std_logic_vector (p downto 0);
                  P2 : In    std_logic_vector (p downto 0);
                  P3 : In    std_logic_vector (p downto 0);
                  P4 : In    std_logic_vector (p downto 0);
                  P5 : In    std_logic_vector (p downto 0);
                  P6 : In    std_logic_vector (p downto 0);
                  P7 : In    std_logic_vector (p downto 0);
                  P8 : In    std_logic_vector (p downto 0);
                  P9 : In    std_logic_vector (p downto 0);
                  PA : In    std_logic_vector (p downto 0);
                  PB : In    std_logic_vector (p downto 0);
                  PC : In    std_logic_vector (p downto 0);
                   C : Out   std_logic_vector (n downto 0);
                   S : Out   std_logic_vector (n downto 0) );
   end component;

   component PARTPROD
      GENERIC(n : integer);
      Port (       X : In    std_logic_vector (n-2 downto 0);
                   Y : In    std_logic_vector(2 downto 0);
                 NEG : Out   std_logic;
                   P : Out   std_logic_vector (n downto 0) );
   end component;

  component reg26b
	Port (	A : In std_logic_vector (25 downto 0);
		CLOCK : In std_logic;
		RESET : In std_logic;
		Z : Out std_logic_vector (25 downto 0) );
   end component;

begin

ZERO <= '0';

pack1(2)<= Y(1); pack1(1)<= Y(0); pack1(0)<= ZERO;
   I_0 : PARTPROD Generic Map(n=>p)
      Port Map ( X=>X, Y=>pack1, NEG=>N0, P=>P0p);

 
   I_1 : PARTPROD Generic Map(n=>p)
      Port Map ( X=>X, Y=>Y(3 downto 1), NEG=>N1, P=>P1p );



   I_2 : PARTPROD Generic Map(n=>p)
      Port Map ( X=>X, Y=>Y(5 downto 3), NEG=>N2, P=>P2p );



   I_3 : PARTPROD Generic Map(n=>p)
      Port Map ( X=>X, Y=>Y(7 downto 5), NEG=>N3, P=>P3p );



   I_4 : PARTPROD Generic Map(n=>p)
      Port Map ( X=>X, Y=>Y(9 downto 7), NEG=>N4, P=>P4p );



   I_5 : PARTPROD Generic Map(n=>p)
      Port Map ( X=>X, Y=>Y(11 downto 9), NEG=>N5, P=>P5p );



   I_6 : PARTPROD Generic Map(n=>p)
      Port Map ( X=>X, Y=>Y(13 downto 11), NEG=>N6, P=>P6p );



   I_7 : PARTPROD Generic Map(n=>p)
      Port Map ( X=>X, Y=>Y(15 downto 13), NEG=>N7, P=>P7p );



   I_8 : PARTPROD Generic Map(n=>p)
      Port Map ( X=>X, Y=>Y(17 downto 15), NEG=>N8, P=>P8p );



   I_9 : PARTPROD Generic Map(n=>p)
      Port Map ( X=>X, Y=>Y(19 downto 17), NEG=>N9, P=>P9p );



   I_A : PARTPROD Generic Map(n=>p)
      Port Map ( X=>X, Y=>Y(21 downto 19), NEG=>NA, P=>PAp );



   I_B : PARTPROD Generic Map(n=>p)
      Port Map ( X=>X, Y=>Y(23 downto 21), NEG=>NB, P=>PBp );



   I_C : PARTPROD Generic Map(n=>p)
      Port Map ( X=>X, Y(2)=>ZERO, Y(1)=>ZERO, Y(0)=>Y(23), NEG=>open, P=>PCp );


   PIPE0 : reg26b
	Port Map ( A=>P0p, CLOCK=>CLOCK,
		 RESET=>RESET, Z=>P0 ); 
   PIPE1 : reg26b
	Port Map ( A=>P1p, CLOCK=>CLOCK,
		 RESET=>RESET, Z=> P1);
   PIPE2 : reg26b
	Port Map ( A=>P2p, CLOCK=>CLOCK,
		 RESET=>RESET, Z=> P2); 
   PIPE3 : reg26b
	Port Map ( A=>P3p, CLOCK=>CLOCK,
		 RESET=>RESET, Z=> P3);
   PIPE4 : reg26b
	Port Map ( A=>P4p, CLOCK=>CLOCK,
		 RESET=>RESET, Z=> P4); 
   PIPE5 : reg26b
	Port Map ( A=>P5p, CLOCK=>CLOCK,
		 RESET=>RESET, Z=> P5);
   PIPE6 : reg26b
	Port Map ( A=>P6p, CLOCK=>CLOCK,
		 RESET=>RESET, Z=> P6); 
   PIPE7 : reg26b
	Port Map ( A=>P7p, CLOCK=>CLOCK,
		 RESET=>RESET, Z=> P7);
   PIPE8 : reg26b
	Port Map ( A=>P8p, CLOCK=>CLOCK,
		 RESET=>RESET, Z=> P8); 
   PIPE9 : reg26b
	Port Map ( A=>P9p, CLOCK=>CLOCK,
		 RESET=>RESET, Z=> P9);
   PIPEA : reg26b
	Port Map ( A=>PAp, CLOCK=>CLOCK,
		 RESET=>RESET, Z=> PA); 
   PIPEB : reg26b
	Port Map ( A=>PBp, CLOCK=>CLOCK,
		 RESET=>RESET, Z=> PB);
   PIPEC : reg26b
	Port Map ( A=>PCp, CLOCK=>CLOCK,
		 RESET=>RESET, Z=> PC);


   T_6 : TREE
      Port Map ( P0=>P0, N0=>N0, P1=>P1, N1=>N1, P2=>P2, N2=>N2,
		 P3=>P3, N3=>N3, P4=>P4, N4=>N4, P5=>P5, N5=>N5,
		 P6=>P6, N6=>N6, P7=>P7, N7=>N7, P8=>P8, N8=>N8,
		 P9=>P9, N9=>N9, PA=>PA, NA=>NA, PB=>PB, NB=>NB,
		 PC=>PC, 
                 C(n downto 0)=>C(n downto 0),
                 S(n downto 0)=>S(n downto 0) );


end SCHEMATIC;

configuration CFG_array24x24_SCHEMATIC of array24x24 is

   for SCHEMATIC
      for T_6: TREE
         use configuration WORK.CFG_TREE_SCHEMATIC;
      end for;
      for I_0, I_1, I_2, I_3, I_4, I_5, I_6, I_7, I_8, I_9, I_A, I_B, I_C: PARTPROD
         use configuration WORK.CFG_PARTPROD_BEHAVIORAL;
      end for;
      for PIPE0, PIPE1, PIPE2, PIPE3, PIPE4, PIPE5, PIPE6, PIPE7, PIPE8, PIPE9, PIPEA, PIPEB, PIPEC: reg26b
         use configuration WORK.CFG_reg26b_BEHAVIORAL;
      end for;
   end for;

end CFG_array24x24_SCHEMATIC;

