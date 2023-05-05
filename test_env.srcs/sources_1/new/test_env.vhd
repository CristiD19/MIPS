----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2022 12:20:36 AM
-- Design Name: 
-- Module Name: test_env - Behavioral
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

entity test_env is
    Port ( clk: in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0)
            );
end test_env;

architecture Behavioral of test_env is
         
    signal  Q : STD_LOGIC_VECTOR (15 downto 0);
    signal enable : STD_LOGIC;
    signal reset : std_logic;
    signal instructiune : std_logic_vector(15 downto 0);
    signal PCafisare : std_logic_vector(15 downto 0);
    signal afisare : std_logic_vector(15 downto 0);
    signal RegWrite : std_logic;
    signal RegDst :  std_logic;
    signal ExtOp :  std_logic;
    signal WD : std_logic_vector(15 downto 0);
    signal RD1 : std_logic_vector(15 downto 0);
    signal RD2 : std_logic_vector(15 downto 0);
    signal Ext_Imm : std_logic_vector(15 downto 0);
    signal func : std_logic_vector(2 downto 0);
    signal sa : std_logic;
    signal ALUSrc : std_logic;
    signal ALUOp : std_logic_vector(2 downto 0);
    signal ALURes : std_logic_vector(15 downto 0);
    signal Zero : std_logic;
    signal MemWrite : std_logic;
    signal MemData : std_logic_vector(15 downto 0);
    signal MemtoReg : std_logic;
    signal Branch : std_logic;
    signal Jump : std_logic;
    signal PCSrc : std_logic;
    signal BranchAdress : std_logic_vector(15 downto 0);
    signal JumpAdress : std_logic_vector(15 downto 0);
    
begin

    seven_segment : entity work.SSD(Behavioral) port map(
        clk  => clk,
        an => an,
        cat => cat,
        digit => afisare);
        
    
     MPG1 : entity work.MPG(Behavioral) port map(
        clk  => clk,
        btn => btn(4),
        enable => enable);
        
        
     MPG2 : entity work.MPG(Behavioral) port map(
               clk  => clk,
               btn => btn(0),
               enable => reset);
               
      PCSrc <= Branch and Zero;
      BranchAdress <= PCafisare + Ext_Imm; 
      JumpAdress <= "000" & instructiune(12 downto 0); 
      
                     
     instruction : entity work.InstructionFetch(Behavioral) port map(
        clk => clk,
        instruction => instructiune,
        Jump => Jump,
        PCSrc => PCSrc,
        PCadd => PCafisare,
        enable => enable,
        reset => reset,
        JumpAdress => JumpAdress,
        BranchAdress => BranchAdress
        
     );
     
     
        UnitateaDeDecodificareID : entity work.ID(Behavioral) port map(
                        Instruction => instructiune ,
                        RegWrite => RegWrite,
                        RegDst => RegDst,
                        ExtOp => ExtOp,
                        clk => clk,
                        WD => WD,
                        RD1 => RD1, 
                        RD2 => RD2,
                        Ext_Imm => Ext_Imm,
                        func => func,
                        sa => sa
         );
         
         UnitateaDeControl : entity work.Main_Control(Behavioral) port map(
                 opcode => instructiune(15 downto 13),
                  RegDst => RegDst,
                  ExtOp => ExtOp,
                  ALUSrc => ALUSrc,
                  Branch => Branch,
                  Jump => Jump,
                  ALUOp => ALUOp,
                  MemWrite => MemWrite,
                  MemtoReg => MemtoReg,
                  RegWrite => RegWrite
         );
         
       led(15) <= RegDst;
       led(14) <= ExtOp;
       led(13) <= ALUSrc;
       led(12) <= Branch;
       led(11) <= Jump;
       led(10 downto 8) <= AlUOp;
       led(7) <= MemWrite;
       led(6) <= MemtoReg; 
       led(5) <= RegWrite;
         
       UnitateaDeExecutie : entity work.EX(Behavioral) port map(
       
            RD1 => RD1, 
            RD2 => RD2,
            Ext_Imm => Ext_Imm, 
            sa => sa,
            func => func,
            ALUSrc => ALUSrc,
            ALUOp => ALUOp,
            ALURes => ALURes,
            Zero => Zero
       );
       
       UnitateaDeMemorare : entity work.MEM(Behavioral) port map(
       
                 clk => clk,
                  AluRes => AluRes ,
                  RD2 => RD2,
                  MemWrite => MemWrite,
                  MemData => MemData 
       );
       
       WriteInRegister : entity work.WB(Behavioral) port map(
     
                  MemtoReg => MemtoReg,
                  AluRes => AluRes,
                  MemData => MemData,
                  RegisterWriteData => WD 
     
     );              
        process(sw(7))
               begin 
                    case sw(7 downto 5) is
                     when "000" => afisare <= instructiune;
                     when "001" => afisare <= PCafisare;
                     when "010" => afisare <= RD1;
                     when "011" => afisare <= RD2;
                     when "100" => afisare <= Ext_Imm;
                     when "101" => afisare <= AluRes;
                     when "110" => afisare <= MemData;
                     when others => afisare <= WD;
                      end case;
               end process;
        

 

end Behavioral;
