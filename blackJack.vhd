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
begin
    process(clk, start) -- Lembrar de lidar com o caso onde o usuário começa a dar clock sem ter dado start
    signal playerSUM, DealerSUM: integer range 0 to 100; -- Precisa de um range pra FPGA entender
    begin
        if (start = '0') then 
            -- Reseta tudo
        else
            -- Inicia o player


            -- Compra duas cartas

            -- Vai para o espera 





        end if;
    end process;
end behaviour;