library ieee;
use ieee.std_logic_1164.all;

entity blackJack is 
    port(
        start, hit, stay: in std_logic;
        clock: in std_logic;
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
    process(clk, start) -- Lembrar de lidar com o caso onde o usuário começa a dar clock sem ter dado start
    signal playerSUM, DealerSUM: integer range 0 to 100 := 0; -- Precisa de um range pra FPGA entender
    signal clockCount: integer range 0 to 100;
    variable pickedCard: integer range 0 to 100;
    begin
        if (start = '0') then 
            -- Reseta tudo
            clockCount <= 0;
        else
            if ((clockCount = 0 OR clockCount = 1) AND clock = '0') then
                clockCount <= clockCount + 1;  -- Lembrar que o valor só é atualizado no próximo ciclo

                rg1: randomGenerator port map(
                    clk => clock, 
                    stim => pickedCard
                );

                card <= std_logic_vector(to_unsigned(pickedCard, card'length)); -- Precisa converter para std_logic_vector
                playerSUM <= playerSUM + pickedCard;

            end if;

            if (playerSUM = 21) then
                win <= '1';
                tie <= '0';
                lose <= '0';
                
                sun <= std_logic_vector(to_unsigned(playerSUM, sun'length)); -- Precisa converter para std_logic_vector
            end if;
            


            -- Compra duas cartas

            -- Vai para o espera 





        end if;
    end process;
end behaviour;