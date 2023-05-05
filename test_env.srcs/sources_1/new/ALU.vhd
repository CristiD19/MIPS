----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2022 12:44:22 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
    Port ( clk: in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0)
            );

end ALU;

architecture Behavioral of ALU is
    signal ce : std_logic;
    signal muxOut : std_logic_vector(15 downto 0);
    signal count : std_logic_Vector(1 downto 0);
    signal sw1 : std_logic_vector(15 downto 0);
    signal sw2 : std_logic_vector(15 downto 0);
    signal sw3 : std_logic_vector(15 downto 0);
    signal add : std_logic_vector(15 downto 0);
    signal substract : std_logic_vector(15 downto 0);
    signal shiftR : std_logic_vector(15 downto 0);
    signal shiftL : std_logic_vector(15 downto 0);
    signal zeroDetector : std_logic;

begin
    monopulse : entity work.MPG(Behavioral) port map(
        btn => btn(4),
        clk => clk,
        enable => ce
    );
    
    seven_segment : entity work.SSD(Behavioral) port map(
        clk => clk,
        cat => cat,
        an => an,
        digit => muxOut
        
    );
    
    process(clk)
        begin 
            if rising_edge(clk) then 
                if ce = '1' then 
                    count <= count + 1;
                 end if;
           end if;
        end process;

    sw1 <=  x"000" & sw(3 downto 0) ;
    sw2 <=  x"000" & sw(7 downto 4) ;
    sw3 <=  x"00" & sw(7 downto 0) ;
    
    add <= sw1 + sw2;
    substract <= sw1 - sw2;
    shiftL <= sw3(13 downto 0) & "00";
    shiftR <= "00" & sw3(15 downto 2);
    
    process(count)
    begin
        case count is 
            when "00" => muxOut <= add;
            when "01" => muxOut <= substract;
            when "10" => muxOut <= shiftL;
            when others => muxOut <= shiftR;
        end case;
    end process;
    
    zeroDetector <= '1' when muxOut = x"0000" else '0';
    
    led(7) <= zeroDetector;

end Behavioral;
