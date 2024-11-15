library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;       
use ieee.numeric_std.all;     

entity random_generator is
    port(
        clk: in std_logic;                   
        reset: in std_logic;                 
        stim: out std_logic_vector(11 downto 0)
    );
end random_generator;

architecture behaviour of random_generator is
begin
    process(clk)
      variable seed1, seed2: positive;
      variable rand: real;                       
      variable int_rand: integer;                
    begin
        if clk = '1' then
          uniform(seed1, seed2, rand);
          int_rand := integer(trunc(rand * 14.0));
          stim <= std_logic_vector(to_unsigned(int_rand, stim'length));
        end if;
    end process;
end behaviour;