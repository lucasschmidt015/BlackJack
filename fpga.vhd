library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;       
use ieee.numeric_std.all;     

entity blackJack is 
    port(
        --start, hit, stay: in std_logic;
        sw: in std_logic_vector(9 downto 0); -- hit = 9 | stay = 8  | randonCards = 7 
        key: in std_logic_vector(3 downto 0); -- start = 3 | clock = 2 
        -- clock: in std_logic;

        -- randonCards: in std_logic;
        -- userCard: out std_logic_vector(3 downto 0); -- 3 2 1 0
        
        -- card: out std_logic_vector(6 downto 0);
        -- sun: out std_logic_vector(6 downto 0);
        -- win, tie, lose: out std_logic -- Win = 2 | tie = 1 | lose = 0 

        ledr: out std_logic_vector(9 downto 0);
        hex3: out std_logic_vector(6 downto 0); -- carta
        hex1: out std_logic_vector(6 downto 0); -- Decimal Soma;
        hex0: out std_logic_vector(6 downto 0)  -- Numeral Soma;
    );
end blackJack;

architecture behaviour of blackJack is 
    type integer_array is array (0 to 12) of integer;

    function randomGenerator(ucards: in integer_array) return integer is 
        variable seed1, seed2: positive;
        variable rand: real;  
        variable search: std_logic:= '1';  
        variable generatedNumber: integer range 0 to 100; 
        variable contador: integer range 0 to 100 := 0;
    begin
        while search = '1' or contador < 100 loop
            contador := contador + 1;
            uniform(seed1, seed2, rand);
            generatedNumber := integer(trunc(rand * 13.0)) + 1; 
            if ucards(generatedNumber - 1) < 4 then
                search := '0';
            end if;
        end loop;
    
        return generatedNumber; 
    end function;

    function numberDisplayCard(pickedCard: in integer) return STD_LOGIC_VECTOR is 
        variable numberforDisplay: std_logic_vector(6 downto 0) := "1111110";  
    begin
         if pickedCard = 1 then 
            numberforDisplay:="0110000";
         elsif pickedCard = 2 then
            numberforDisplay:="1101101";
        elsif pickedCard = 3 then
            numberforDisplay:="1111001";
        elsif pickedCard = 4 then
            numberforDisplay:="0110011";
        elsif pickedCard = 5 then
             numberforDisplay:="1011011";
        elsif pickedCard = 6 then 
             numberforDisplay:="1011111";
        elsif pickedCard = 7 then
            numberforDisplay:="1110000";
        elsif pickedCard = 8 then
            numberforDisplay:="1111111";
        elsif pickedCard = 9 then
            numberforDisplay:="1111011";
        elsif pickedCard = 10 then
            numberforDisplay:="1110111";
        elsif pickedCard = 11 then
            numberforDisplay:="0011111";
        elsif pickedCard = 12 then
            numberforDisplay:="1001110";
        elsif pickedCard = 13 then
             numberforDisplay:="0111101";
         else 
            numberforDisplay:="1111110";
        end if;
        return numberforDisplay;
    end function;
   ----------------------------------------------------------------------
    --Essa função retorna o primeiro algarismo das dezenas do número, no caso se for 21, retorna 2.
    function numberSumDezenas(playerSUM: in integer) return STD_LOGIC_VECTOR is 
      variable numberSumDezenasForDisplay: std_logic_vector(6 downto 0) := "1111110";  
      begin
        if playerSUM < 10 then
            numberSumDezenasForDisplay:="1111110";
         elsif playerSUM >= 10 and playerSUM < 19 then
            numberSumDezenasForDisplay:="0110000";
        elsif playerSUM  >= 20 and playerSUM < 29 then
            numberSumDezenasForDisplay:="1101101";
        else --No processo principal nunca dará esse else por irá acusar derrota ao ter soma > 21
            numberSumDezenasForDisplay:="1111110";
        end if;  
        return numberSumDezenasForDisplay;   
    end function;
    ---------------------------------------------------------------------------------------------------

    --Essa função retorna o segundo algarismo do número, no caso se for 21, retorna 1.
    function numberSumUnidades(playerSUM: in integer) return STD_LOGIC_VECTOR is 
        variable numberSumUnidadesForDisplay: std_logic_vector(6 downto 0) := "1111110";  
    begin
            if playerSUM < 10 then
               if playerSUM = 1 then 
                   numberSumUnidadesForDisplay:="0110000";
               elsif playerSUM = 2 then
                   numberSumUnidadesForDisplay:="1101101";
               elsif playerSUM = 3 then
                   numberSumUnidadesForDisplay:="1111001";
               elsif playerSUM = 4 then
                   numberSumUnidadesForDisplay:="0110011";
               elsif playerSUM = 5 then
                   numberSumUnidadesForDisplay:="1011011";
               elsif playerSUM = 6 then 
                   numberSumUnidadesForDisplay:="1011111";
               elsif playerSUM = 7 then
                   numberSumUnidadesForDisplay:="1110000";
               elsif playerSUM = 8 then
                   numberSumUnidadesForDisplay:="1111111";
               elsif playerSUM = 9 then
                   numberSumUnidadesForDisplay:="1111011";
               else 
                   numberSumUnidadesForDisplay:="1111110";
               end if;
            elsif playerSUM >= 10 and playerSUM < 19 then
               if (playerSUM - 10) = 1 then 
                   numberSumUnidadesForDisplay:="0110000";
               elsif (playerSUM - 10) = 2 then
                   numberSumUnidadesForDisplay:="1101101";
               elsif (playerSUM - 10) = 3 then
                   numberSumUnidadesForDisplay:="1111001";
               elsif (playerSUM - 10) = 4 then
                   numberSumUnidadesForDisplay:="0110011";
               elsif (playerSUM - 10) = 5 then
                   numberSumUnidadesForDisplay:="1011011";
               elsif (playerSUM - 10) = 6 then 
                   numberSumUnidadesForDisplay:="1011111";
               elsif (playerSUM - 10) = 7 then
                   numberSumUnidadesForDisplay:="1110000";
               elsif (playerSUM - 10) = 8 then
                   numberSumUnidadesForDisplay:="1111111";
               elsif (playerSUM - 10) = 9 then
                   numberSumUnidadesForDisplay:="1111011";
               else 
                   numberSumUnidadesForDisplay:="1111110";
               end if;
           elsif playerSUM  >= 20 and playerSUM < 29 then
               if (playerSUM - 20) = 1 then 
                   numberSumUnidadesForDisplay:="0110000";
               elsif (playerSUM - 20) = 2 then
                   numberSumUnidadesForDisplay:="1101101";
               elsif (playerSUM - 20) = 3 then
                   numberSumUnidadesForDisplay:="1111001";
               elsif (playerSUM - 20) = 4 then
                   numberSumUnidadesForDisplay:="0110011";
               elsif (playerSUM - 20) = 5 then
                   numberSumUnidadesForDisplay:="1011011";
               elsif (playerSUM - 20) = 6 then 
                   numberSumUnidadesForDisplay:="1011111";
               elsif (playerSUM - 20) = 7 then
                   numberSumUnidadesForDisplay:="1110000";
               elsif (playerSUM - 20) = 8 then
                   numberSumUnidadesForDisplay:="1111111";
               elsif (playerSUM - 20) = 9 then
                   numberSumUnidadesForDisplay:="1111011";
               else 
                   numberSumUnidadesForDisplay:="1111110";
               end if;
           else --No processo principal nunca dará esse else por irá acusar derrota ao ter soma > 21
               numberSumUnidadesForDisplay:="1111110";
           end if;  
           return numberSumUnidadesForDisplay; 
    end function;
   --------------------------------------------------------------------------------------------------

    signal clockCount: integer range 0 to 100 := 0;
    signal gameStarted: std_logic := '0';
    signal playerAcum, dealerAcum: integer range 0 to 100 := 0;
    signal usedCardAcum: integer_array := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

begin
    process(key(2), key(3)) -- Lembrar de lidar com o caso onde o usuário começa a dar clock sem ter dado start
    variable userCard: std_logic_vector(3 downto 0) := sw(3) & sw(2) & sw(1) & sw(0); 
    variable pickedCard: integer range 0 to 100;
    variable playerSUM, DealerSUM: integer range 0 to 100 := 0; -- Precisa de um range pra FPGA entender
    variable usedCard: integer_array := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    begin
        if (key(3) = '0') then 
            -- Reseta tudo
            gameStarted <= '1';
            pickedCard := 0;
            clockCount <= 0;
            playerSUM := 0;
            DealerSUM := 0;
            playerAcum <= 0;
            dealerAcum <= 0;
            ledr(2) <= '0';
            ledr(1) <= '0';
            ledr(0) <= '0';
            hex1 <= "0000000";
            hex0 <= "0000000";
            hex3 <= "0000000";
            usedCardAcum <= (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

        elsif (gameStarted = '1') then
            playerSUM := playerAcum;
            DealerSUM := dealerAcum;
            usedCard  := usedCardAcum;

            if ((clockCount = 0 OR clockCount = 1) AND key(2) = '0') then

                clockCount <= clockCount + 1;  -- Lembrar que o valor só é atualizado no próximo ciclo
                if(sw(7) = '1')    then
                    pickedCard := randomGenerator(usedCard);
                    hex3 <= numberDisplayCard(pickedCard);
                    if pickedCard > 10 then
                        playerSUM := playerSUM + 10;
                    elsif pickedCard = 1 then
                        if playerSUM < 12 then
                            playerSUM := playerSUM + 10;
                        else 
                            playerSUM := playerSUM + 1;
                        end if;
                    else
                        playerSUM := playerSUM + pickedCard;
                    end if;
                    usedCard(pickedCard - 1) := usedCard(pickedCard - 1) + 1;
                else
                    -- card <= std_logic_vector(to_unsigned(to_integer(unsigned(userCard)), card'length)); -- Corrected for userCard
                    hex3 <= numberDisplayCard(to_integer(unsigned(userCard)));
                    if to_integer(unsigned(userCard)) > 10 then
                       playerSUM := playerSUM + 10;
                    elsif to_integer(unsigned(userCard)) = 1 then
                        if playerSUM < 12 then
                            playerSUM := playerSUM + 10;
                        else 
                            playerSUM := playerSUM + 1;
                        end if;
                    else
                        playerSUM := playerSUM + to_integer(unsigned(userCard));
                    end if;  
                    playerAcum <= playerSUM;
                end if; 
            end if;
            
            -- Player dando hit
            if (sw(9) = '1') then
                if(sw(7) = '1')    then
                    pickedCard := randomGenerator(usedCard);
                    -- card <= std_logic_vector(to_unsigned(pickedCard, card'length)); -- No changes required
                    hex3 <= numberDisplayCard(pickedCard);
                    if pickedCard > 10 then
                        playerSUM := playerSUM + 10;
                    elsif pickedCard = 1 then
                        if playerSUM < 12 then
                            playerSUM := playerSUM + 10;
                        else 
                            playerSUM := playerSUM + 1;
                        end if;
                    else
                        playerSUM := playerSUM + pickedCard;
                    end if;
                    usedCard(pickedCard - 1) := usedCard(pickedCard - 1) + 1;
                else
                    -- card <= std_logic_vector(to_unsigned(to_integer(unsigned(userCard)), card'length)); -- Corrected for userCard
                    hex3 <= numberDisplayCard(to_integer(unsigned(userCard)));
                    if to_integer(unsigned(userCard)) > 10 then
                       playerSUM := playerSUM + 10;
                    elsif to_integer(unsigned(userCard)) = 1 then
                        if playerSUM < 12 then
                            playerSUM := playerSUM + 10;
                        else 
                            playerSUM := playerSUM + 1;
                        end if;
                    else
                        playerSUM := playerSUM + to_integer(unsigned(userCard));
                    end if;  
                end if; 


            end if;

            hex0 <= numberSumUnidades(playerSUM);
            hex1 <= numberSumDezenas(playerSUM);

            if (playerSUM = 21) then
                ledr(2) <= '1';
                ledr(1) <= '0';
                ledr(0) <= '0';
            elsif (playerSUM > 21) then
                ledr(2) <= '0';
                ledr(1) <= '0';
                ledr(0) <= '1';
            end if;

            -- Se passou daqui, começa a jogada do dealer

            if (sw(8) = '1') then 
                if (DealerSUM <= 17 AND key(2) = '0') then -- Precisamos verificar bem a lógica desse bloco, fiz na correria e não sei se está certo
                    if(sw(7) = '1') then
                        pickedCard := randomGenerator(usedCard);
                        hex3 <= numberDisplayCard(pickedCard);
                        
                        if pickedCard > 10 then
                            DealerSUM := DealerSUM + 10;
                        elsif pickedCard = 1 then
                            if DealerSUM < 12 then
                                DealerSUM := DealerSUM + 10;
                            else 
                                DealerSUM := DealerSUM + 1;
                            end if;
                        else
                            DealerSUM := DealerSUM + pickedCard;
                        end if;
                        usedCard(pickedCard - 1) := usedCard(pickedCard - 1) + 1;
                    else 
                        hex3 <= numberDisplayCard(to_integer(unsigned(userCard)));
                        if to_integer(unsigned(userCard)) > 10 then
                            DealerSUM := DealerSUM + 10;
                        elsif to_integer(unsigned(userCard)) = 1 then
                            if DealerSUM < 12 then
                                DealerSUM := DealerSUM + 10;
                            else 
                                DealerSUM := DealerSUM + 1;
                            end if;
                        else
                            DealerSUM := DealerSUM + to_integer(unsigned(userCard));
                        end if;  
                    end if;

                elsif (DealerSUM <= 17) then

                    if (DealerSUM > 21) then
                        ledr(2) <= '1';
                        ledr(1) <= '0';
                        ledr(0) <= '0';
                    end if;
        
                    if (DealerSUM = PlayerSUM) then
                        ledr(2) <= '0';
                        ledr(1) <= '1';
                        ledr(0) <= '0';
                    end if;
        
                    if (PlayerSUM > DealerSUM) then
                        ledr(2) <= '1';
                        ledr(1) <= '0';
                        ledr(0) <= '0';
                    end if;

                end if;
            end if;
            playerAcum <= PlayerSUM;
            dealerAcum <= dealerSUM;
            usedCardAcum <= usedCard;
        end if;
    end process;
end behaviour;


