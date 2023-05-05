----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2022 04:50:12 PM
-- Design Name: 
-- Module Name: test_RAM - Behavioral
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

entity test_RAM is
   Port ( clk: in STD_LOGIC;
      btn : in STD_LOGIC_VECTOR (4 downto 0);
      sw : in STD_LOGIC_VECTOR (15 downto 0);
      led : out STD_LOGIC_VECTOR (15 downto 0);
      an : out STD_LOGIC_VECTOR (3 downto 0);
      cat : out STD_LOGIC_VECTOR (6 downto 0)
       );
end test_RAM;

architecture Behavioral of test_RAM is

signal enable_count: std_logic;
signal enable_ram: std_logic;
signal count: std_logic_vector(3 downto 0);
type ram_type is array(15 downto 0) of std_logic_vector(15 downto 0);
signal ram : ram_type := (others => x"0001");
signal do : std_logic_vector(15 downto 0);
signal do_aux : std_logic_vector(15 downto 0);
signal wd : std_logic_vector(15 downto 0);
signal wa: std_logic_vector(3 downto 0);

begin
    
     MPG1 : entity work.MPG(Behavioral) port map(
clk  => clk,
btn => btn(4),
enable => enable_count
);

MPG2 : entity work.MPG(Behavioral) port map(
clk  => clk,
btn => btn(0),
enable => enable_ram
);

SevenSegment : entity work.SSD(Behavioral) port map(
    clk => clk,
    an => an,
    cat => cat,
    digit => do
    );
    
   process(clk)
       begin 
           if (rising_edge(clk)) then 
               if (enable_count ='1') then 
                   count <= count + 1;
               end if;
           end if;
       end process;

process(clk) 
  begin 
      if rising_edge(clk) then 
            if (enable_ram = '1') then 
                ram(to_integer(unsigned(wa))) <= wd ;
            end if;
       end if;
    end process;
 
do_aux <= ram(to_integer(unsigned(count)));
wa <= count;
do <= do_aux(13 downto 0) & "00";
wd <= do;

end Behavioral;
