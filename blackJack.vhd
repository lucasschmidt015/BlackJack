library ieee;
use ieee.std_logic_1164.all;

entity blackJack is 
    port(
        start, hit, stay: in std_logic;
        card: out std_logic_vector(6 downto 0);
        sun: out std_logic_vector(6 downto 0);
        win, tie, lose: out std_logic
    );
end blackJack;

architecture behaviour of blackJack is 
begin
    process()


    end process;
end behaviour;