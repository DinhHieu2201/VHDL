------------------------- 
-- Project name: SECDED Decoder
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
use IEEE.NUMERIC_STD.ALL;

entity secded_decoder is
    port (
        d_in  : in  std_logic_vector(13 downto 1);
        d_out : out std_logic_vector(8 downto 1);
        err_1bit : out std_logic; -- co bao loi 1 bit
        err_2bit : out std_logic  -- co bao loi 2 bit
    );
end secded_decoder;

architecture behavioral of secded_decoder is

signal hamming   : std_logic_vector(12 downto 1);
signal parity_rx : std_logic;	-- bit parity nhan duoc

signal s1,s2,s4,s8 : std_logic;
signal syndrome : std_logic_vector(3 downto 0);
signal parity_check : std_logic;-- bit parity tinh lai

signal corrected : std_logic_vector(12 downto 1);

begin

hamming   <= d_in(12 downto 1);
parity_rx <= d_in(13);

-- syndrome
s1 <= hamming(1) xor hamming(3) xor hamming(5) xor
      hamming(7) xor hamming(9) xor hamming(11);

s2 <= hamming(2) xor hamming(3) xor hamming(6) xor
      hamming(7) xor hamming(10) xor hamming(11);

s4 <= hamming(4) xor hamming(5) xor hamming(6) xor
      hamming(7) xor hamming(12);

s8 <= hamming(8) xor hamming(9) xor hamming(10) xor
      hamming(11) xor hamming(12);

syndrome <= s8 & s4 & s2 & s1;

-- parity check
parity_check <= parity_rx xor
    (hamming(1) xor hamming(2) xor hamming(3) xor
     hamming(4) xor hamming(5) xor hamming(6) xor
     hamming(7) xor hamming(8) xor hamming(9) xor
     hamming(10) xor hamming(11) xor hamming(12));

-- secded
process(hamming, syndrome, parity_check)
    variable error_pos : integer range 0 to 12;
begin
    corrected <= hamming;
    err_1bit  <= '0';
    err_2bit  <= '0';

    error_pos := to_integer(unsigned(syndrome));

    if syndrome /= "0000" then
        if parity_check = '1' then
            -- loi 1 bit
            corrected(error_pos) <= not hamming(error_pos);
            err_1bit <= '1';
        else
            -- loi 2 bit
            err_2bit <= '1';
        end if;
    end if;
end process;

d_out(1) <= corrected(3);
d_out(2) <= corrected(5);
d_out(3) <= corrected(6);
d_out(4) <= corrected(7);
d_out(5) <= corrected(9);
d_out(6) <= corrected(10);
d_out(7) <= corrected(11);
d_out(8) <= corrected(12);

end behavioral;
