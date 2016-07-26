library IEEE;
	 use IEEE.std_logic_1164.all;

entity significand_compute_gated is
	Port (	MX : In std_logic_vector (23 downto 0);
		MY : In std_logic_vector (23 downto 0);
		CLK1 : In std_logic;
		CLK2 : In std_logic;
		CLOCK : In std_logic;
		RESET : In std_logic;
		OVF : Out std_logic;
		Z : Out std_logic_vector (23 downto 0) );
end significand_compute_gated;

architecture SCHEMATIC of significand_compute_gated is

   signal       PS : std_logic_vector(47 downto 0);
   signal       PC : std_logic_vector(47 downto 0);
   signal       PROD : std_logic_vector(47 downto 0);
   signal       P1S : std_logic_vector(47 downto 0);
   signal       P1C : std_logic_vector(47 downto 0);
   signal       PROD1 : std_logic_vector(47 downto 0);
   signal       P2S : std_logic_vector(47 downto 0);
   signal       P2C : std_logic_vector(47 downto 0);
   signal       PROD2 : std_logic_vector(47 downto 0);
   signal       RBIT : std_logic_vector(48 downto 0);
   signal       GND : std_logic;

   signal       PI1 : std_logic_vector(47 downto 0);
   signal       PI2 : std_logic_vector(47 downto 0);

   component array24x24
        Port (  X : In std_logic_vector (23 downto 0);
                Y : In std_logic_vector (23 downto 0);
		CLOCK : In std_logic;
		RESET : In std_logic;
                S : Out std_logic_vector (47 downto 0) ;
                C : Out std_logic_vector (47 downto 0) );
   end component;

   component normalize1 
        Port (  A : In std_logic_vector (47 downto 0);
                Z : Out std_logic_vector (23 downto 0) );
   end component;

      component gl_cpa 
        GENERIC(n : integer);
        Port (  A1 : In std_logic_vector (n downto 0);
                A2 : In std_logic_vector (n downto 0);
                S : Out std_logic_vector (n downto 0) );
   end component;

   component gl_csa32 is
        GENERIC(n : integer);
        Port (  A : In std_logic_vector (n downto 0);
                B : In std_logic_vector (n downto 0);
                C : In std_logic_vector (n downto 0);
                Cin : In std_logic;
                Z : Out std_logic_vector (n downto 0);
                Y : Out std_logic_vector (n downto 0) );
   end component;

   component gl_mux21 
        GENERIC(n : integer);
        Port (  A0 : In std_logic_vector (n downto 0);
                A1 : In std_logic_vector (n downto 0);
                SEL : In std_logic;
                Z : Out std_logic_vector (n downto 0) );
   end component;

  component reg48b
	Port (	A : In std_logic_vector (47 downto 0);
		CLOCK : In std_logic;
		RESET : In std_logic;
		Z : Out std_logic_vector (47 downto 0) );
  end component;

begin

GND <= '0';
RBIT <= "0000000000000000000000000100000000000000000000000";
   I_7 : array24x24
	Port Map ( X(23 downto 0)=>MX(23 downto 0),
		   Y(23 downto 0)=>MY(23 downto 0),
		   CLOCK=>CLK1, RESET=>RESET,
		   S(47 downto 0)=>PI1(47 downto 0),
		   C(47 downto 0)=>PI2(47 downto 0)  );

   PIPE1 : reg48b
	Port Map ( A=>PI1, CLOCK=>CLK2,
		 RESET=>RESET, Z=> PS);
   PIPE2 : reg48b
	Port Map ( A=>PI2, CLOCK=>CLK2,
		 RESET=>RESET, Z=> PC);


   CSA1 : gl_csa32 Generic Map(n=>47)
        Port Map ( A=> PS, B=> PC, C=> RBIT(48 downto 1), Cin=> GND, 				   Z=>P1s , Y=>P1c);

   CSA2 : gl_csa32 Generic Map(n=>47)
        Port Map ( A=> PS, B=> PC, C=> RBIT(47 downto 0), Cin=> GND, 				   Z=>P2s , Y=>P2c);


   A_1 : gl_cpa Generic Map(n=>47)
        Port Map ( A1 => P1S, A2  => P1C, S => PROD1 );

   A_2 : gl_cpa Generic Map(n=>47)
        Port Map ( A1 => P2S, A2  => P2C, S => PROD2 );

   A_MUX : gl_mux21 Generic Map(n=>23)
        Port Map ( A0 => PROD1(46 downto 23), A1  => PROD2(47 downto 24), 
		   SEL => PROD2(47), Z => Z );


OVF<=PROD2(47);

end SCHEMATIC;

configuration CFG_significand_compute_gated_SCHEMATIC of significand_compute_gated is

   for SCHEMATIC
      for I_7: array24x24
         use configuration WORK.CFG_array24x24_SCHEMATIC;
      end for;
      for A_1, A_2: gl_cpa
         use configuration WORK.CFG_gl_cpa_BEHAVIORAL;
      end for;
      for CSA1, CSA2 : gl_csa32
         use configuration WORK.CFG_gl_csa32_BEHAVIORAL;
      end for;
      for A_MUX : gl_mux21
         use configuration WORK.CFG_gl_mux21_BEHAVIORAL;
      end for;
      for PIPE1, PIPE2 : reg48b
         use configuration WORK.CFG_reg48b_BEHAVIORAL;
      end for;
   end for;

end CFG_significand_compute_gated_SCHEMATIC;
