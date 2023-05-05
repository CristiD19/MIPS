----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2022 08:47:47 PM
-- Design Name: 
-- Module Name: bloc_registre - Behavioral
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

entity bloc_registre is
Port ( clk: in STD_LOGIC;
         btn : in STD_LOGIC_VECTOR (4 downto 0);
         sw : in STD_LOGIC_VECTOR (15 downto 0);
         led : out STD_LOGIC_VECTOR (15 downto 0);
         an : out STD_LOGIC_VECTOR (3 downto 0);
         cat : out STD_LOGIC_VECTOR (6 downto 0)
          );
end bloc_registre;

architecture Behavioral of bloc_registre is
    signal enable_count : std_logic;
    signal enable_reg :std_logic;
    signal count : std_logic_vector(3 downto 0);
    type ram_type is array(0 to 15) of std_logic_vector(15 downto 0);
    signal ram : ram_type :=(others => x"0001");
    signal ra1: std_logic_vector(3 downto 0);
    signal ra2: std_logic_vector(3 downto 0);
    signal wa: std_logic_vector(3 downto 0);
    signal rd1: std_logic_vector(15 downto 0);
    signal rd2: std_logic_vector(15 downto 0);
    signal reg_wr : std_logic;
    signal wd : std_logic_vector(15 downto 0);
        
begin
    MPG1 : entity work.MPG(Behavioral) port map(
    clk  => clk,
    btn => btn(4),
    enable => enable_count
);

    MPG2 : entity work.MPG(Behavioral) port map(
    clk  => clk,
    btn => btn(0),
    enable => enable_reg
);

    SevenSegment : entity work.SSD(Behavioral) port map(
    clk => clk,
    an => an,
    cat => cat,
    digit => wd
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
        if (rising_edge(clk)) then 
          
            if (reg_wr ='1') then 
                ram(to_integer(unsigned(wa))) <= wd;
            end if;
        end if;

        
    end process;
        
    rd1 <= ram(to_integer(unsigned(ra1)));
    rd2 <= ram(to_integer(unsigned(ra2)));
    ra1 <= count;
    ra2 <= count;
    wa <= count;
    wd <= rd1 + rd2;
    reg_wr <= enable_reg;
            
end Behavioral;
