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

entity test_ROM is
      Port ( clk: in STD_LOGIC;
         btn : in STD_LOGIC_VECTOR (4 downto 0);
         sw : in STD_LOGIC_VECTOR (15 downto 0);
         led : out STD_LOGIC_VECTOR (15 downto 0);
         an : out STD_LOGIC_VECTOR (3 downto 0);
         cat : out STD_LOGIC_VECTOR (6 downto 0)
          );
end test_ROM;

architecture Behavioral of test_ROM is
    signal enable : std_logic;
    signal do : std_logic_vector(15 downto 0);
    signal count : std_logic_vector(7 downto 0) := x"00";
    type rom_type is array(0 to 255) of std_logic_vector(15 downto 0);
    signal ROM : rom_type :=( x"0001", x"0002", x"0003", x"0004", others => (x"0000"));
begin

MPG : entity work.MPG(Behavioral) port map(
    clk  => clk,
    btn => btn(4),
    enable => enable

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
            if (enable = '1') then 
                count <= count + 1;
             end if;
        end if;
        
        do <= ROM(to_integer(unsigned(count)));
        
    end process;
        


end Behavioral;
