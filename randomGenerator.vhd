library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;       
use ieee.numeric_std.all;     

entity randomGenerator is
    port(
        clk: in std_logic;  
        ucard1: in integer;
        ucard2: in integer;
        ucard3: in integer;
        ucard4: in integer;
        ucard5: in integer;   
        ucard6: in integer;
        ucard7: in integer;
        ucard8: in integer;
        ucard9: in integer;
        ucard10: in integer;
        ucard11: in integer;
        ucard12: in integer;
        ucard13: in integer;                           
        stim: out integer
    );
end randomGenerator;

architecture behaviour of randomGenerator is
begin
    process(clk)
      variable seed1, seed2: positive;
      variable rand: real;  
      variable search: std_logic:= '1';  
      variable generatedNumber: integer range 0 to 100;                              
    begin
        if clk = '0' then
            search := '1';
            while search = '1' loop
                uniform(seed1, seed2, rand);
                generatedNumber := integer(trunc(rand * 14.0));
                if generatedNumber = 1 and ucard1 < 4 then
                    search := '0';
                end if;
                if generatedNumber = 2 and ucard2 < 4 then
                    search := '0';
                end if;
                if generatedNumber = 3 and ucard3 < 4 then
                    search := '0';
                end if;
                if generatedNumber = 4 and ucard4 < 4 then
                    search := '0';
                end if;
                if generatedNumber = 5 and ucard5 < 4 then
                    search := '0';
                end if;
                if generatedNumber = 6 and ucard6 < 4 then
                    search := '0';
                end if;
                if generatedNumber = 7 and ucard7 < 4 then
                    search := '0';
                end if;
                if generatedNumber = 8 and ucard8 < 4 then
                    search := '0';
                end if;
                if generatedNumber = 9 and ucard9 < 4 then
                    search := '0';
                end if;
                if generatedNumber = 10 and ucard10 < 4 then
                    search := '0';
                end if;
                if generatedNumber = 11 and ucard11 < 4 then
                    search := '0';
                end if;
                if generatedNumber = 12 and ucard12 < 4 then
                    search := '0';
                end if;
                if generatedNumber = 13 and ucard13 < 4 then
                    search := '0';
                end if;
            end loop;  
        stim <= generatedNumber;  
        end if;
    end process;
end behaviour;
