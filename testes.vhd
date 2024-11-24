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


library ieee;
use ieee.std_logic_1164.all;

entity blackJack is 
    port(
        start, hit, stay: in std_logic;
        clock: in std_logic;
        randonCards: in std_logic;
        userCard: out std_logic_vector(3 downto 0);
        
        card: out std_logic_vector(6 downto 0);
        sun: out std_logic_vector(6 downto 0);
        win, tie, lose: out std_logic
    );
end blackJack;

architecture behaviour of blackJack is 
    component randomGenerator is
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
    end component;

    variable playerSUM, DealerSUM: integer range 0 to 100 := 0; -- Precisa de um range pra FPGA entender
    signal clockCount: integer range 0 to 100 := 0;
    signal gameStarted: sdt_logic := '0';
    variable pickedCard: integer range 0 to 100;
    type integer_array is array (0 to 12) of integer;
    variable usedCard: integer_array := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

begin
    process(clock, start) -- Lembrar de lidar com o caso onde o usuário começa a dar clock sem ter dado start
    
    begin
        if (start = '0') then 
            -- Reseta tudo
            gameStarted <= '1';
            pickedCard := 0;
            clockCount <= 0;
            playerSUM := 0;
            DealerSUM := 0;
            win <= '0';
            tie <= '0';
            lose <= '0';
        elsif (gameStarted = '1') then

            if ((clockCount = 0 OR clockCount = 1) AND clock = '0') then

                clockCount <= clockCount + 1;  -- Lembrar que o valor só é atualizado no próximo ciclo
                if(randonCards = '1')    then
                    rg1: randomGenerator port map(
                        clk => clock, 
                        stim => pickedCard
                    );
                    card <= std_logic_vector(to_unsigned(pickedCard, card'length)); -- Precisa converter para std_logic_vector
                    playerSUM := playerSUM + pickedCard;
                else
                    card <= std_logic_vector(to_unsigned(userCard, card'length)); -- Precisa converter para std_logic_vector
                    playerSUM := playerSUM + to_integer(unsigned(userCard));
                end if;
                
            end if;

            if (playerSUM = 21) then
                win <= '1';
                tie <= '0';
                lose <= '0';
                
                sun <= std_logic_vector(to_unsigned(playerSUM, sun'length)); -- Precisa converter para std_logic_vector

            elsif (playerSUM > 21) then
                win <= '0';
                tie <= '0';
                lose <= '1';
                sun <= std_logic_vector(to_unsigned(playerSUM, sun'length)); -- Precisa converter para std_logic_vector
            end if;

            -- Se passou daqui, começa a jogada do dealer

            if (clockCount = 2 OR clockCount = 3 AND clock = '0') then -- Precisamos verificar bem a lógica desse bloco, fiz na correria e não sei se está certo
                if(randonCards = '1')    then

                    clockCount <= clockCount + 1;
                    rg2: randomGenerator port map(
                        clk => clock, 
                        stim => pickedCard
                    );
                    card <= std_logic_vector(to_unsigned(pickedCard, card'length)); -- Precisa converter para std_logic_vector
                    DealerSUM := DealerSUM + pickedCard;

                else 
                    card <= std_logic_vector(to_unsigned(userCard, card'length)); -- Precisa converter para std_logic_vector
                    DealerSUM := DealerSUM + to_integer(unsigned(userCard));
                end if;
            end if;

        end if;
    end process;
end behaviour;


