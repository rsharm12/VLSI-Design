library IEEE;
	use IEEE.std_logic_1164.all;
	use STD.textio.all;
	use IEEE.std_logic_textio.all;

entity E is
end E;

architecture A of E is

	 signal X0 : std_logic_vector(31 downto 0);
	 signal X1 : std_logic_vector(31 downto 0);
	 signal X2 : std_logic_vector(31 downto 0);
	 signal X3 : std_logic_vector(31 downto 0);
	 signal Y0 : std_logic_vector(31 downto 0);
	 signal Y1 : std_logic_vector(31 downto 0);
	 signal Y2 : std_logic_vector(31 downto 0);
	 signal Y3 : std_logic_vector(31 downto 0);
	 signal A0 : std_logic;
	 signal A1 : std_logic;
	 signal A2 : std_logic;
	 signal A3 : std_logic;
	 signal CLOCK : std_logic;
	 signal RESET : std_logic;
	 signal P0 : std_logic_vector (31 downto 0);
	 signal P1 : std_logic_vector (31 downto 0);
	 signal P2 : std_logic_vector (31 downto 0);
	 signal P3 : std_logic_vector (31 downto 0);

   component fourcore_gated
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
   end component;

begin

   UUT : fourcore_gated
	 Port Map ( X0, X1, X2, X3, Y0, Y1, Y2, Y3, A0, A1, A2, A3, CLOCK, RESET, P0, P1, P2, P3 );

   TB : block
   begin
   process
	file cmdfile: TEXT; 		 -- Define the file 'handle'
	variable line_in,line_out: Line; -- Line buffers
	variable good: boolean;   	 -- Status of the read operations
	variable W0, W1, W2, W3, B0, B1, B2, B3: std_logic_vector(31 downto 0);
	variable AP1,BP1, AP2, BP2: std_logic_vector(31 downto 0);
	variable S0, S1, S2, S3: std_logic_vector(31 downto 0);
	variable SP1, SP2: std_logic_vector(31 downto 0);
	variable operation: std_logic;
	variable opp: std_logic;
	variable c, Q : integer;
	-- constant TEST_PASSED: string := "Test passed:";
	-- constant TEST_FAILED: string := "Test FAILED:";

	begin


  SP1 := "00000000000000000000000000000000";
  SP2 := "00000000000000000000000000000000";
  X0 <= "00000000000000000000000000000000";
  X1 <= "00000000000000000000000000000000";
  X2 <= "00000000000000000000000000000000";
  X3 <= "00000000000000000000000000000000";
  Y0 <= "00000000000000000000000000000000";
  Y1 <= "00000000000000000000000000000000";
  Y2 <= "00000000000000000000000000000000";
  Y3 <= "00000000000000000000000000000000";
  A0 <= '0';
  A1 <= '0';
  A2 <= '0';
  A3 <= '0'; 

  reset <= '0';
  wait for  1 ns;
  reset <= '1';
  clock <= '0';
  wait for  1 ns;
  c := 1;
  Q := 1;
-- -------------------------------------------------------------------------
  FILE_OPEN(cmdfile,"testvecs.in",READ_MODE);
  
    if endfile(cmdfile) then  -- Check EOF
	assert false
	   report "End of file encountered; exiting."
	   severity NOTE;
    end if;

while (Q < 5000) loop
    -----------READ 4 LINES AND GET ALL 4 CORES ACTIVE ----------
    --READ 1ST LINE
    readline(cmdfile,line_in);     -- Read a line from the file

    hread(line_in,W0,good);         -- Read the A argument as hex value
    assert good report "Text I/O read error" severity ERROR;

    hread(line_in,B0,good);         -- Read the B argument as hex value
    assert good report "Text I/O read error" severity ERROR;

    hread(line_in,S0,good);         -- Read the S argument as hex value
    assert good report "Text I/O read error" severity ERROR;

    --READ 2ND LINE
    readline(cmdfile,line_in);     -- Read a line from the file

    hread(line_in,W1,good);         -- Read the A argument as hex value
    assert good report "Text I/O read error" severity ERROR;

    hread(line_in,B1,good);         -- Read the B argument as hex value
    assert good report "Text I/O read error" severity ERROR;

    hread(line_in,S1,good);         -- Read the S argument as hex value
    assert good report "Text I/O read error" severity ERROR;


    --GET ALL 4 CORES ACTIVE
    X0 <= W0;
    Y0 <= B0;
    A0 <= '1';
    X3 <= W1;
    Y3 <= B1;
    A3 <= '1';

    Q := Q + 1;

    clock <= '1'; wait for  1 ns; clock <= '0'; wait for  1 ns;
end loop;

-- -------------------------------------------------------------------------

  clock <= '1'; wait for  1 ns; clock <= '0'; wait for  1 ns;
  clock <= '1'; wait for  1 ns; clock <= '0'; wait for  1 ns;
  write(line_out, string'("-- END OF SIMULATION -------------------------"));
  writeline(OUTPUT,line_out); 


   end process;
 end block;
end A;

--configuration CFG_TB_fpmul1_BEHAVIORAL of E is
  -- for A
	-- for UUT : fourcore_gated
	  -- use configuration WORK.cfg_fourcore_gated_schematic;
	 --end for;

	 --for TB
	 --end for;

   --end for;
--end CFG_TB_fpmul1_BEHAVIORAL;
