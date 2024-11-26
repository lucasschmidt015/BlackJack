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

    signal clockCount: integer range 0 to 100 := 0;
    signal gameStarted: sdt_logic := '0';
    signal playerAcum, dealerAcum: integer range 0 to 100 := 0;
    type integer_array is array (0 to 12) of integer;
    signal usedCardAcum: integer_array := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

begin
    process(clock, start) -- Lembrar de lidar com o caso onde o usuário começa a dar clock sem ter dado start
    variable pickedCard: integer range 0 to 100;
    variable playerSUM, DealerSUM: integer range 0 to 100 := 0; -- Precisa de um range pra FPGA entender

    type integer_array is array (0 to 12) of integer;
    variable usedCard: integer_array := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    begin
        if (start = '0') then 
            -- Reseta tudo
            gameStarted <= '1';
            pickedCard := 0;
            clockCount <= 0;
            playerSUM := 0;
            DealerSUM := 0;
            playerAcum <= 0;
            dealerAcum <= 0;
            win <= '0';
            tie <= '0';
            lose <= '0';
            sun <= "0000000";
            card <= "0000000";
            usedCardAcum <= (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

        elsif (gameStarted = '1') then

            if ((clockCount = 0 OR clockCount = 1) AND clock = '0') then

                clockCount <= clockCount + 1;  -- Lembrar que o valor só é atualizado no próximo ciclo
                if(randonCards = '1')    then
                    rg1: randomGenerator port map(
                        clk => clock, 
                        ucard1 => usedCard(0),
                        ucard2 => usedCard(1),
                        ucard3 => usedCard(2),
                        ucard4 => usedCard(3),
                        ucard5 => usedCard(4),   
                        ucard6 => usedCard(5),
                        ucard7 => usedCard(6),
                        ucard8 => usedCard(7),
                        ucard9 => usedCard(8),
                        ucard10 => usedCard(9),
                        ucard11 => usedCard(10),
                        ucard12 => usedCard(11),
                        ucard13 => usedCard(12),
                        stim => pickedCard
                    );
                    card <= std_logic_vector(to_unsigned(pickedCard, card'length)); -- Precisa converter para std_logic_vector
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
                    playerAcum <= playerSUM;
                    usedCard(pickedCard - 1) := usedCard(pickedCard - 1) + 1;
                else
                    card <= std_logic_vector(to_unsigned(userCard, card'length)); -- Precisa converter para std_logic_vector
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

            --Parei de ver aqui, precisamos verificar para salvar os dados nos novos signals, já que as variaveis precisam ser internas ao process <----

            -- Player dando hit
            if (hit = '1') then
                if(randonCards = '1')    then
                    rg3: randomGenerator port map(
                        clk => clock, 
                        ucard1 => usedCard(0),
                        ucard2 => usedCard(1),
                        ucard3 => usedCard(2),
                        ucard4 => usedCard(3),
                        ucard5 => usedCard(4),   
                        ucard6 => usedCard(5),
                        ucard7 => usedCard(6),
                        ucard8 => usedCard(7),
                        ucard9 => usedCard(8),
                        ucard10 => usedCard(9),
                        ucard11 => usedCard(10),
                        ucard12 => usedCard(11),
                        ucard13 => usedCard(12),
                        stim => pickedCard
                    );
                    card <= std_logic_vector(to_unsigned(pickedCard, card'length)); -- Precisa converter para std_logic_vector
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
                    card <= std_logic_vector(to_unsigned(userCard, card'length)); -- Precisa converter para std_logic_vector
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

            sun <= std_logic_vector(to_unsigned(playerSUM, sun'length)); -- Precisa converter para std_logic_vector

            if (playerSUM = 21) then
                win <= '1';
                tie <= '0';
                lose <= '0';
            elsif (playerSUM > 21) then
                win <= '0';
                tie <= '0';
                lose <= '1';
            end if;

            -- Se passou daqui, começa a jogada do dealer


            if (stay = '1') then 
                if (DealerSUM <= 17 AND clock = '0') then -- Precisamos verificar bem a lógica desse bloco, fiz na correria e não sei se está certo
                    if(randonCards = '1')    then
                        rg2: randomGenerator port map(
                            clk => clock, 
                            ucard1 => usedCard(0),
                            ucard2 => usedCard(1),
                            ucard3 => usedCard(2),
                            ucard4 => usedCard(3),
                            ucard5 => usedCard(4),   
                            ucard6 => usedCard(5),
                            ucard7 => usedCard(6),
                            ucard8 => usedCard(7),
                            ucard9 => usedCard(8),
                            ucard10 => usedCard(9),
                            ucard11 => usedCard(10),
                            ucard12 => usedCard(11),
                            ucard13 => usedCard(12),
                            stim => pickedCard
                        );
                        card <= std_logic_vector(to_unsigned(pickedCard, card'length)); -- Precisa converter para std_logic_vector
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
                        card <= std_logic_vector(to_unsigned(userCard, card'length)); -- Precisa converter para std_logic_vector
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
                        win <= '1';
                        tie <= '0';
                        lose <= '0';
                    end if;
        
                    if (DealerSUM = PlayerSUM) then
                        win <= '0';
                        tie <= '1';
                        lose <= '0';
                    end if;
        
                    if (PlayerSUM > DealerSUM) then
                        win <= '1';
                        tie <= '0';
                        lose <= '0';
                    end if;

                end if;

            end if;
            
        end if;
    end process;
end behaviour;


