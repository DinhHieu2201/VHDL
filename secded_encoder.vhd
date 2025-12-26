------------------------- 
-- Project name: SECDED Encoder
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

entity secded is
port (d_in : in std_logic_vector(8 downto 1);
      d_out : out std_logic_vector(13 downto 1)
);
end secded;

architecture behavioral of secded is

signal c1,c2,c4,c8:std_logic;
signal parity : std_logic;
signal hamming: std_logic_vector(12 downto 1);

begin
--check bit

c1<=d_in(1) xor d_in(2) xor d_in(4) xor d_in(5) xor d_in(7);
c2<=d_in(1) xor d_in(3) xor d_in(4) xor d_in(6) xor d_in(7);
c4<=d_in(2) xor d_in(3) xor d_in(4) xor d_in(8);
c8<=d_in(5) xor d_in(6) xor d_in(7) xor d_in(8);

--hamming

hamming(1)  <= c1;
hamming(2)  <= c2;
hamming(3)  <= d_in(1);
hamming(4)  <= c4;
hamming(5)  <= d_in(2);
hamming(6)  <= d_in(3);
hamming(7)  <= d_in(4);
hamming(8)  <= c8;
hamming(9)  <= d_in(5);
hamming(10) <= d_in(6);
hamming(11) <= d_in(7);
hamming(12) <= d_in(8);

--bit parity chan 

parity <= hamming(1) xor hamming(2) xor hamming(3) xor
      	  hamming(4) xor hamming(5) xor hamming(6) xor
          hamming(7) xor hamming(8) xor hamming(9) xor
          hamming(10) xor hamming(11) xor hamming(12);

--bit tong gui di

d_out(12 downto 1)<=hamming;
d_out(13)<=parity;

end behavioral;
