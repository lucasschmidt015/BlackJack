TYPE estado is (T, I, P, L, D, R, H, S);
    signal est: estado:= T;

begin
    process(sw, key) -- Lembrar de lidar com o caso onde o usuário começa a dar clock sem ter dado start
    variable pickedCard: integer range 0 to 100;
    variable playerSUM, DealerSUM: integer range 0 to 100 := 0; -- Precisa de um range pra FPGA entender
    variable usedCard: integer_array := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    begin
        if key = '0' then
            est <= I;
        else 
            if est = T then 
                est <= T;
                ledr <= "0000000001";
            elsif est = I then
                est <= P;
                ledr <= "0000000011";
            elsif est = P then
                est <= L;
                ledr <= "0000000111";
            else 
                ledr <= "0000000000";
            end if;
       
        end if;
    end process;
end behaviour;
