----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2022 01:14:03 PM
-- Design Name: 
-- Module Name: WB - Behavioral
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

entity WB is
        Port( 
           MemtoReg : in std_logic;
           AluRes : in std_logic_vector(15 downto 0);
           MemData : in std_logic_vector(15 downto 0);
           RegisterWriteData : out std_logic_vector(15 downto 0)
     );
end WB;

architecture Behavioral of WB is

begin

    process(MemtoReg)
    begin
         case MemtoReg is 
            when '0' => RegisterWriteData <= AluRes;
            when others => RegisterWriteData <= MemData;
         end case;
   end process;


end Behavioral;
