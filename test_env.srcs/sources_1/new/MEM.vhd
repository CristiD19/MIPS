----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2022 12:58:25 PM
-- Design Name: 
-- Module Name: MEM - Behavioral
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

entity MEM is
     Port( clk: in std_logic;
           AluRes : inout std_logic_vector(15 downto 0);
           RD2 : in std_logic_vector(15 downto 0);
           MemWrite : in std_logic;
           MemData : out std_logic_vector(15 downto 0)
     );
end MEM;

architecture Behavioral of MEM is
    type ram_type is array(0 to 31) of std_logic_vector(15 downto 0);
     signal ram : ram_type :=(others => x"0000");
     
begin

    process(clk) 
        begin 
            if rising_edge(clk) then 
                if(MemWrite = '1') then 
                    ram(to_integer(unsigned(AluRes))) <= RD2;
            
                end if;
            end if;
        end process;

    MemData <= ram(to_integer(unsigned(AluRes)));

end Behavioral;
