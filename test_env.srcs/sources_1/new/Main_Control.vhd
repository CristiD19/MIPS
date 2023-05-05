----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2022 05:27:08 PM
-- Design Name: 
-- Module Name: Main_Control - Behavioral
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

entity Main_Control is
      Port(  opcode : in std_logic_vector(2 downto 0);
             RegDst : out std_logic;
             ExtOp : out std_logic;
             ALUSrc : out std_logic;
             Branch : out std_logic;
             Jump : out std_logic;
             ALUOp : out std_logic_vector(2 downto 0);
             MemWrite : out std_logic;
             MemtoReg : out std_logic;
             RegWrite : out std_logic        
      );
end Main_Control;

architecture Behavioral of Main_Control is

  
        


begin

  process(opcode)
    Begin 
        case opcode is
            when "000" => RegDst <= '1';
                          RegWrite <= '1'; 
                          ALUSrc <= '0' ;
                          ExtOp <= '0' ;
                          ALUOp <= "000" ;
                          MemWrite <= '0';
                          MemtoReg <= '0';
                          Branch <= '0';
                          Jump <= '0' ;
                           
         when "001" => RegDst <= '0';
                       RegWrite <= '1'; 
                       ALUSrc <= '1' ;
                       ExtOp <= '1' ;
                       ALUOp <= "001" ;
                       MemWrite <= '0';
                       MemtoReg <= '0';
                       Branch <= '0';
                       Jump <= '0';
                       
           when "010" => RegDst <= '0';
                         RegWrite <= '1'; 
                         ALUSrc <= '1' ;
                         ExtOp <= '1' ;
                         ALUOp <= "010" ;
                         MemWrite <= '0';
                         MemtoReg <= '1';
                         Branch <= '0';
                         Jump <= '0';
        
        when "011" => RegDst <= '0';
                      RegWrite <= '0'; 
                      ALUSrc <= '1' ;
                      ExtOp <= '1' ;   
                      ALUOp <= "011" ;
                      MemWrite <= '1';
                      MemtoReg <= '0';
                      Branch <= '0';
                      Jump <= '0';
                      
        when "100" => RegDst <= '0';
                      RegWrite <= '0'; 
                      ALUSrc <= '0' ;
                       ExtOp <= '1' ;   
                      ALUOp <= "100" ;
                      MemWrite <= '0';
                      MemtoReg <= '0';
                      Branch <= '1';
                      Jump <= '0';
               
        when "101" => RegDst <= '0';
                      RegWrite <= '1'; 
                      ALUSrc <= '1' ;
                      ExtOp <= '0' ;   
                      ALUOp <= "101" ;
                      MemWrite <= '0';
                      MemtoReg <= '0';
                      Branch <= '0';
                      Jump <= '0';
                            
                            
        when "110" => RegDst <= '0';
                      RegWrite <= '1'; 
                      ALUSrc <= '1' ;
                      ExtOp <= '0' ;   
                      ALUOp <= "110" ;
                      MemWrite <= '0';
                      MemtoReg <= '0';
                      Branch <= '0';
                      Jump <= '0';
                      
                     
                     
       when others => RegDst <= '0';
                     RegWrite <= '0'; 
                     ALUSrc <= '0' ;
                     ExtOp <= '0' ;   
                     ALUOp <= "000" ;
                     MemWrite <= '0';
                     MemtoReg <= '0';
                     Branch <= '0';
                     Jump <= '1';
                      
        end case;
        
        
    end process;


end Behavioral;
