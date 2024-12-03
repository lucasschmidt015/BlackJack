library ieee;
use ieee.std_logic_1164.all;
-- use ieee.math_real.all; 

entity blackJack is
    port(
        key: in std_logic_vector(3 downto 0); 
        ledr: out std_logic_vector(9 downto 0) 
    );
end entity blackJack;

architecture rtl of tblackJackeste is
begin
    process(key(3), key(2))
    begin
        if key(3) = '1' then
            ledr(0) <= '0';
        elsif key(2) = '1' then
            ledr(0) <= '1';
        end if;
    end process;
end architecture rtl;