library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;       
use ieee.numeric_std.all;     

entity random_generator is
    port(
        clk: in std_logic;                   
        reset: in std_logic;                 
        stim: out integer
    );
end random_generator;

architecture behaviour of random_generator is
begin
    process(clk)
      variable seed1, seed2: positive;
      variable rand: real;                                  
    begin
        if clk = '0' then
          uniform(seed1, seed2, rand);
          stim <= integer(trunc(rand * 14.0));
        end if;
    end process;
end behaviour;