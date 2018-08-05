--EVM Machine based on FSM on Xilinx Spartan 3e kit by Abhishek Mitra.
--DATE-18/02/2017.
--for input/output configuration see ucf file.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Voting_Machine is
port(
		clk : in std_logic;
		reset : in std_logic;
		party1 : in std_logic;
		party2 : in std_logic;
		party3 : in std_logic;
		party4 : in std_logic;
		select_party : in std_logic;
		--ouput the count of the vote.
		count1_x : out std_logic_vector(10 downto 0);
		count2_x : out std_logic_vector(10 downto 0);
		count3_x : out std_logic_vector(10 downto 0);
		count4_x : out std_logic_vector(10 downto 0)
);
end Voting_Machine;

architecture bhv of Voting_Machine is
		signal count1,count2,count2,count4 : std_logic_vector(10 downto 1);
		--store the present state of the fsm.
		signal state : std_logic_vector(10 downto 1);
		--state declaration with one hot code logic.
		constant intial : std_logic_vector( 10 downto 0) :=       "0000000001";
		constant check : std_logic_vector( 10 downto 0) :=        "0000000010";
		constant party1_state : std_logic_vector( 10 downto 0) := "0000000100";
		constant party2_state : std_logic_vector( 10 downto 0) := "0000001000";
		constant party3_state : std_logic_vector( 10 downto 0) := "0000010000";
		constant party4_state : std_logic_vector( 10 downto 0) := "0000100000";
		constant done 		  : std_logic_vector( 10 downto 0) := "0001000000";
		
		begin
			process(clk,reset,party1,party2,party3,party4)
			begin
			--reset the evm , reset all the counts to 0, fix the
			--intial state memory as intial.
				if(reset='1') then				
					count1 <= "0000000000";
					count2 <= "0000000000";
					count3 <= "0000000000";
					count4 <= "0000000000";
					state <= intial;
				else 
					--on rising edge of the clock.
					if(clk'event and clk='1' and reset='0')
						case state is 
							--next state logiv(NSL)
							when intial =>
								if(party1='1' or party2='1' or party3='1' or party4='1')
									state <= check;
								else 	
									state<= intial;		--state memory
								end if;
									
							when check =>
								--NSL for check state
								if(party1='1')
									state <= party1_state;
								elsif(party2='1')
									state <= party2_state; 	
								elsif(party3='1')
									state <= party3_state; 
								elsif(party4='1')
									state <= party4_state; 
								else state <=check;		--state memory
								end if;
							
							when party1_state =>
								--NSL for check state
								if(select_party='1')		
									state <= done;		--state memory
								else state <= party1_state
								end if;
								count1=count1+1;	--output function logic	
								
							when party2_state =>
								--NSL for check state
								if(select_party='1')		
									state <= done;		--state memory
								else state <= party2_state
								end if;
								count2=count2+1;	--output function logic
								
							when party3_state =>
								--NSL for check state
								if(select_party='1')		
									state <= done;		--state memory
								else state <= party3_state
								end if;
								count3=count3+1;	--output function logic	
							
							when party4_state =>
								--NSL for check state
								if(select_party='1')		
									state <= done;		--state memory
								else state <= party4_state
								end if;
								count4=count4+1;	--output function logic	
							
							when done =>
								state<=intial;
							when others
								state<=intial;
								
						end case;
					end if;
				end if;
			end process;
			
			count1_x <= count1;
			count2_x <= count2;
			count3_x <= count3;
			count4_x <= count4;
	end bhv;
								
									
									
							
							
						
					
					
					

		
