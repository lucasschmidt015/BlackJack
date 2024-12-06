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


            function slv_to_int(input_vector: std_logic_vector(3 downto 0)) return integer is
    variable int_value : integer;
begin
    case input_vector is
        when "0001" => return 1;
        when "0010" => return 2;
        when "0011" => return 3;
        when "0100" => return 4;
        when "0101" => return 5;
        when "0110" => return 6;
        when "0111" => return 7;
        when "1000" => return 8;
        when "1001" => return 9;
        when "1010" => return 10;
        when "1011" => return 11;
        when "1100" => return 12;
        when "1101" => return 13;
        when others => return 0; -- Caso indesejado ou erro
    end case;
end function;
