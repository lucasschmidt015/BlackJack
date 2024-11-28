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
        
        card: out std_logic_vector(6 downto 0);
        sun: out std_logic_vector(6 downto 0);
        -- win, tie, lose: out std_logic -- Win = 2 | tie = 1 | lose = 0 

        ledr: out std_logic_vector(9 downto 0);
        hex2: out std_logic_vector(6 downto 0)
    );
end blackJack;

architecture behaviour of blackJack is 
    type integer_array is array (0 to 12) of integer;

    function randomGenerator(ucards: in integer_array) return integer is 
        variable seed1, seed2: positive;
        variable rand: real;  
        variable search: std_logic:= '1';  
        variable generatedNumber: integer range 0 to 100;  
    begin
        while search = '1' loop
            uniform(seed1, seed2, rand);
            generatedNumber := integer(trunc(rand * 13.0)) + 1; 
            if ucards(generatedNumber - 1) < 4 then
                search := '0';
            end if;
        end loop;
    
        return generatedNumber; 
    end function;

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
            sun <= "0000000";
            card <= "0000000";
            usedCardAcum <= (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

        elsif (gameStarted = '1') then
            playerSUM := playerAcum;
            DealerSUM := dealerAcum;
            usedCard  := usedCardAcum;

            if ((clockCount = 0 OR clockCount = 1) AND key(2) = '0') then

                clockCount <= clockCount + 1;  -- Lembrar que o valor só é atualizado no próximo ciclo
                if(sw(7) = '1')    then
                    pickedCard := randomGenerator(usedCard);
                    card <= std_logic_vector(to_unsigned(pickedCard, card'length)); -- No changes required
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
                    card <= std_logic_vector(to_unsigned(to_integer(unsigned(userCard)), card'length)); -- Corrected for userCard
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
                    card <= std_logic_vector(to_unsigned(pickedCard, card'length)); -- No changes required
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
                    card <= std_logic_vector(to_unsigned(to_integer(unsigned(userCard)), card'length)); -- Corrected for userCard
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

            sun <= std_logic_vector(to_unsigned(playerSUM, sun'length)); -- No changes required

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
                        card <= std_logic_vector(to_unsigned(pickedCard, card'length)); -- No changes required
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
                        card <= std_logic_vector(to_unsigned(to_integer(unsigned(userCard)), card'length)); -- Corrected for userCard
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


