------------------------- 
-- Project name: Parity generator/checker
-- Author:  Dinh Xuan Hieu - 2251243321
-- Date:  21/12/2025
-- Course:  
-- Function:  
-- Description:  
-- Inputs: 
-- Outputs: 
------------------------- 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
port(
d: in std_logic_vector (4 downto 1);
sel :in std_logic; -- 0:chan, 1:le
parity:out std_logic;
chan : out std_logic;
le: out std_logic
);
end main;
architecture behavioral of main is
signal S1,S2,S3:std_logic;
begin
S1<=d(1) xor d(2);
S2<=d(3) xor d(4);
S3<=S1 xor S2;

    process(d, sel, S3)
    begin
        if sel = '0' then
            parity <= S3;      -- chan
        else
            parity <= not(S3); -- le
        end if;
    end process;

chan<=not(s1 xor s2);
le<= s1 xor s2;

end behavioral;


