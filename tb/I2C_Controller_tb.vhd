library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity I2C_Controller_tb is
end I2C_Controller_tb;

architecture Behavioral of I2C_Controller_tb is

	signal  aclk        		:   std_logic                       :=  '0';
	signal  Send        		:   std_logic                       :=  '0';
	signal  Busy        		:   std_logic                       :=  '0';
	signal  SCL        			:   std_logic                       :=  '0';
	signal  Data_Out_Valid     	:   std_logic                       :=  '0';
	signal  R_W        			:   std_logic                       :=  '0';
	signal  SDA        			:   std_logic                       :=  '0';
	signal  Data_Type		    :   std_logic                       :=  '0';
	signal  Data_In        		:   unsigned	(15 downto 0)       :=  (others=>'0');
	signal  Data_Out        	:   unsigned	(15 downto 0)       :=  (others=>'0');
	signal  Address_Pointer   	:   unsigned	(7 downto 0)        :=  (others=>'0');
	
	constant CLOCK_PERIOD 		: time := 10 ns;
	constant T_HOLD       		: time := 10 ns;


begin

I2C_Controller_inst: entity work.I2C_Controller
   port map (
      -- Input Ports - Single Bit
      Clock                       => aclk,                     
      Data_Type                   => Data_Type,                 
      R_W                         => R_W,                       
      Send                        => Send,                      
      -- Input Ports - Busses
      Address_Pointer 			  => Address_Pointer,
      Data_In        			  => Data_In,      
      -- Output Ports - Single Bit
      Busy                        => Busy,                      
      Data_Out_Valid              => Data_Out_Valid,            
      SCL                         => SCL,                       
      -- Output Ports - Busses
      Data_Out					  => Data_Out,     
      -- InOut Ports - Single Bit
      SDA                         => SDA                       
      -- InOut Ports - Busses
   );




  clock_gen : process
  begin
    aclk <= '0';

      wait for CLOCK_PERIOD;
      loop
        aclk <= '0';
        wait for CLOCK_PERIOD/2;
        aclk <= '1';
        wait for CLOCK_PERIOD/2;
      end loop;
  end process clock_gen;

  stimuli : process
  begin

    -- Drive inputs T_HOLD time after rising edge of clock
    wait until rising_edge(aclk);
    wait for T_HOLD;

    -- Run for long enough to produce 5 periods of outputs
    wait for CLOCK_PERIOD * 50;


	 Send				<=	'0';                   
	 R_W				<=	'0';                   
	 Send				<=	'0';                   
	 Data_Type			<=	'1';
	 
	 Data_In			<=	x"ABCD";   
	 Address_Pointer	<=	x"EF";   

    wait for CLOCK_PERIOD * 1000;

	 Send				<=	'1';                   
    wait for CLOCK_PERIOD * 1;
	 Send				<=	'0';                   

    wait for CLOCK_PERIOD * 11000;

	 Data_Type			<=	'0';
	 Send				<=	'1';                   
    wait for CLOCK_PERIOD * 1;
	 Send				<=	'0';                   

    wait for CLOCK_PERIOD * 16000;

	 R_W				<=	'1';                   
	 Send				<=	'0';                   
	 Data_Type			<=	'1';

    wait for CLOCK_PERIOD * 100;

	 Send				<=	'1';                   
    wait for CLOCK_PERIOD * 1;
	 Send				<=	'0';                   
	 
    wait for CLOCK_PERIOD * 16000;

	 Data_Type			<=	'0';
	 Send				<=	'1';                   
    wait for CLOCK_PERIOD * 1;
	 Send				<=	'0';                   


    wait for CLOCK_PERIOD * 16000;

	 Send				<=	'0';                   
	 R_W				<=	'0';                   
	 Send				<=	'0';                   
	 Data_Type			<=	'1';
	 
	 Data_In			<=	x"ABCD";   
	 Address_Pointer	<=	x"EF";   

    wait for CLOCK_PERIOD * 1000;

	 Send				<=	'1';                   
    wait for CLOCK_PERIOD * 1;
	 Send				<=	'0';                   

    wait for CLOCK_PERIOD * 11000;

	 Data_Type			<=	'0';
	 Send				<=	'1';                   
    wait for CLOCK_PERIOD * 1;
	 Send				<=	'0';                   

	
    wait;

  end process stimuli;


end Behavioral;
