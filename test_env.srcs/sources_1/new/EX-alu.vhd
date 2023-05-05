----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2022 04:42:42 PM
-- Design Name: 
-- Module Name: EX-alu - Behavioral
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

entity EX is
      Port( RD1 : in std_logic_vector(15 downto 0);
            RD2 : in std_logic_vector(15 downto 0);
            Ext_Imm : in std_logic_vector(15 downto 0);
            sa : in std_logic;
            func : in std_logic_vector(2 downto 0);
            ALUSrc : in std_logic;
            ALUOp : in std_logic_vector(2 downto 0);
            ALURes : inout std_logic_vector(15 downto 0);
            Zero : out std_logic
      );
end EX;


architecture Behavioral of EX is
    
        signal muxout : std_logic_vector(15 downto 0);
        signal ALUControl : std_logic_vector(2 downto 0);
        signal Result : std_logic_vector(15 downto 0);
    
           
begin

    process(ALUSrc)
         Begin 
             case ALUSrc is 
             when '0' => muxout <= RD2;
             when others => muxout <= Ext_Imm;
             end case;
         end process;
 
    
    process(ALUOp,func)
        Begin 
            case ALUOp is 
            when "000" =>  case func is 
                           when "000" => ALUControl <= "000"; -- add - adunare
                           when "001" => ALUControl <= "001"; -- sub - scadere
                           when "010" => ALUControl <= "010"; -- sll- & sa
                           when "011" => ALUControl <= "011"; -- slr- & sa
                           when "100" => ALUControl <= "100"; -- and- &
                           when "101" => ALUControl <= "101"; -- or- |
                           when "110" => ALUControl <= "110"; -- xor - ^
                           when "111" => ALUControl <= "111"; -- mult - *
                           end case;
                           
            when "001" =>  ALUControl <= "000"; --addi - adunare
            when "010" =>  ALUControl <= "000"; --lw - adunare
            when "011" =>  ALUControl <= "000"; --sw - adunare 
            when "100" =>  ALUControl <= "001"; --beq - scadere
            when "101" =>  ALUControl <= "100"; --andi - &
            when "110" =>  ALUControl <= "101"; --ori - |
            when others =>  ALUControl <= "000"; -- jmp - nu conteaza
            
            end case;
        end process;
        
      process(ALUControl)
           Begin 
                case ALUControl is 
                when "000" => AluRes <= RD1 + muxout;
                when "001" => AluRes <= RD1 - muxout;
                when "010" => if(sa = '1') then 
                                AluRes <= RD1(14 downto 0) & '0';
                               else 
                                AluRes <= RD1;
                               end if;
                when "011" => if(sa = '1') then 
                               AluRes <= '0' & RD1(15 downto 1) ;
                                    else 
                               AluRes <= RD1;
                                  end if;
                when "100" => AluRes <= RD1 and muxout;
                when "101" => AluRes <= RD1 or muxout;
                when "110" => AluRes <= RD1 xor muxout;
                when others => AluRes <=  RD1(7 downto 0) * muxout(7 downto 0);
            end case;
        end process;
    
    Zero <= '1' when AluRes = x"0000" else '0';

end Behavioral;
