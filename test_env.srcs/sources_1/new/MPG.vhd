----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2022 08:39:03 PM
-- Design Name: 
-- Module Name: MPG - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MPG is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           enable : out STD_LOGIC);
end MPG;

architecture Behavioral of MPG is
signal count : STD_LOGIC_VECTOR(31 downto 0);
signal Q1 : STD_LOGIC;
signal Q2 : STD_LOGIC;
signal Q3 : STD_LOGIC;

begin

process(clk)
    begin
        if rising_edge(clk) then
            count <= count + 1;
        end if;
     end process;

process(clk)
    begin 
        if rising_edge(clk) then 
            if count(15 downto 0) = "1111111111111111" then
                Q1 <= btn;
            end if;
        end if;
    end process;
    
process(clk)
    begin 
        if rising_edge(clk) then 
            Q2 <= Q1;
            Q3 <= Q2;
         end if;
    end process;
    


enable <= not(Q3) and Q2;

end Behavioral;
