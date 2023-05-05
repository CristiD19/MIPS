----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2022 04:34:40 PM
-- Design Name: 
-- Module Name: ID - Behavioral
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

entity ID is
         Port ( Instruction : in std_logic_vector(15 downto 0);
                RegWrite : in std_logic;
                RegDst : in std_logic;
                ExtOp : in std_logic;
                clk : in std_logic;
                WD : in std_logic_vector(15 downto 0);
                RD1 : out std_logic_vector(15 downto 0);
                RD2 : out std_logic_vector(15 downto 0);
                Ext_Imm : out std_logic_vector(15 downto 0);
                func : out std_logic_vector(2 downto 0);
                sa : out std_logic
         );
end ID;

architecture Behavioral of ID is
 signal RA1: std_logic_vector(2 downto 0);
   signal RA2: std_logic_vector(2 downto 0);
   signal WA: std_logic_vector(2 downto 0);
    type ram_type is array(0 to 255) of std_logic_vector(15 downto 0);
     signal ram : ram_type :=(others => x"0000");
   

begin

     process(clk)
        begin 
            if rising_edge(clk) then
                if RegWrite = '1' then
                    ram(to_integer(unsigned(WA))) <= WD;
                end if;
            end if;
        
        end process;
        
        process(RegDst)
        Begin
          case RegDst is
                  when '0' => WA <= Instruction(9 downto 7);
                  when others => WA <= Instruction(6 downto 4);
         end case;
        end process;
        
        
        RA1 <= Instruction(12 downto 10);
        RA2 <= Instruction(9 downto 7);
        
        RD1 <= ram(to_integer(unsigned(RA1)));
        RD2 <= ram(to_integer(unsigned(RA2)));
        
        
        
        process(ExtOp)
        Begin 
            case ExtOp is
                     when '0' => Ext_Imm <= "000000000" & Instruction(6 downto 0);
                     when others => Ext_Imm(6 downto 0) <= Instruction(6 downto 0);     
                                    Ext_Imm(15 downto 7) <= (others=>Instruction(6));
            end case;
        end process;
        
        sa <= Instruction(3);
        func <= Instruction (2 downto 0);
        
   

end Behavioral;
