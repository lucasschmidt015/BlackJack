library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;       
use ieee.numeric_std.all;     

entity blackJack is 
    port(
       
        sw: in std_logic_vector(9 downto 0); -- hit = 9 | stay = 8  | randonCards = 7  | Card: 3 2 1 0
        key: in std_logic_vector(3 downto 0); -- start = 3 | clock = 2 
    
        ledr: out std_logic_vector(9 downto 0); -- Win = 2 | tie = 1 | lose = 0 
        hex3: out std_logic_vector(6 downto 0); -- carta
        hex1: out std_logic_vector(6 downto 0); -- Decimal Soma;
        hex0: out std_logic_vector(6 downto 0);  -- Numeral Soma;

        hex2: out std_logic_vector(6 downto 0)  -- Apenas para deixar zerado;

    );
end blackJack;

architecture behav of blackJack is 
    type StateType is (Carta1Player, Carta2Player, EmHitPlayer, Carta1Dealer, Carta2Dealer, EmHitDealer);
    signal current_state : StateType;
begin 
    process(key(2), key(3))
    begin
        if ()


    end process;
end architecture behav;


