----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2022 06:39:51 PM
-- Design Name: 
-- Module Name: test_ROM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstructionFetch is
      Port ( clk: in STD_LOGIC;
         instruction : out std_logic_vector(15 downto 0);
         Jump : in std_logic;
         PCSrc : in std_logic;
         PCadd : out std_logic_vector(15 downto 0);
         enable : std_logic;
         reset : std_logic;
         JumpAdress : std_logic_vector(15 downto 0);
         BranchAdress : std_logic_vector(15 downto 0)
          );
end InstructionFetch;

architecture Behavioral of InstructionFetch is

    type rom_type is array(0 to 255) of std_logic_vector(15 downto 0);
    signal ROM : rom_type :=( B"001_000_110_0000101", -- X"2305" -- ADDI $6 $0 5 - 1
                              B"001_000_111_0000000", -- X"2380" -- ADDI $7 $0 0 - 2
                              B"001_000_001_0000001", -- X"2081" -- ADDI $1 $0 1 - 3
                              B"001_000_010_0000010", -- X"2102" -- ADDI $2 $0 2 - 4
                              B"001_000_011_0000100", -- X"2184" -- ADDI $3 $0 4 - 5
                              B"011_001_001_0000000", -- X"6480" -- SW $1 0($1) - 6
                              B"011_001_010_0000001", -- X"6501" -- SW $2 1($1) - 7
                              B"011_001_011_0000010", -- X"6582" -- SW $3 2($1) - 8
                              B"010_001_001_0000000", -- X"4480" -- LW $1 0($1) - 9
                              B"010_010_010_0000000", -- X"4900" -- LW $2 0($2) -10
                              B"010_010_011_0000001", -- X"4D80" -- LW $3 1($2) -11
                              B"100_110_111_0100000", -- X"9BA0" -- BEQ $6 $7 32 - 12
                              B"000_001_010_100_0_111", -- X"0547" -- MULT $4 $1 $2  - 13
                              B"000_100_011_101_0_000", -- X"11D0" --ADD $5 $4 $3 - 14 
                              B"000_000_101_001_0_000", -- X"0290" --ADD $1 $0 $5 - 15  
                              B"001_111_100_0000001", -- X"3E01" --ADDI $4 $7 1 - 16
                              B"001_100_111_0000000", -- X"3380" --ADDI $7 $4 0 - 17 
                              B"111_0000000001011", -- X"E00B" --J 11 - 18
                              others => (x"0000")); -- NoOp (ADD $0 $0 $0) -19
                              
    signal mux1 : std_logic_vector(15 downto 0);
    signal mux2 : std_logic_vector(15 downto 0);
    signal PC : std_logic_vector(15 downto 0);
   
   
begin

    
process(clk)
    begin 
        if(rising_edge(clk)) then 
            if enable='1' then 
                PC <= mux2;
            end if;
            if reset='1' then 
                PC <= x"0000";
            end if;
        end if;
   end process;
   
   PCadd <= PC + 1;
   
   process(Jump)
        begin 
            case Jump is
            when '0' => mux2 <= mux1;
            when others => mux2 <= JumpAdress;
            end case;
        end process;
        
   process(PCSrc)
                begin 
                    case PCSrc is
                    when '0' => mux1 <= PC + 1;
                    when others => mux1 <= BranchAdress;
                    end case;
                end process;
                
    instruction <= ROM(to_integer(unsigned(PC(7 downto 0))));


end Behavioral;
