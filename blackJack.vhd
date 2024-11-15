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
            stim: out integer
        );
    end component;
begin
    process(clock, start) -- Lembrar de lidar com o caso onde o usuário começa a dar clock sem ter dado start
    variable playerSUM, DealerSUM: integer range 0 to 100 := 0; -- Precisa de um range pra FPGA entender
    signal clockCount: integer range 0 to 100;
    signal gameStarted: sdt_logic := '0';
    variable pickedCard: integer range 0 to 100;
    type integer_array is array (0 to 12) of integer;
    variable usedCard: integer_array := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

    begin
        if (start = '0') then 
            -- Reseta tudo
            gameStarted <= '1';
            pickedCard := 0;
            clockCount <= 0;
            playerSUM <= 0;
            DealerSUM <= 0;
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
                playerSUM <= playerSUM + pickedCard;
                else
                    card <= std_logic_vector(to_unsigned(userCard, card'length)); -- Precisa converter para std_logic_vector
                    playerSUM <= playerSUM + to_integer(unsigned(userCard));
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

            -- Precisamos criar o controle das cartas que sairam
            randomGenerator port map(
                clk => clock, 
                stim => pickedCard
                ucard => usedCard
            );

        end if;
    end process;
end behaviour;


