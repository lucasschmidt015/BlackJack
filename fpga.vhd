

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;       
use ieee.numeric_std.all;     

entity blackJack is 
    port(
       
        sw: in std_logic_vector(9 downto 0); -- hit = 9 | stay = 8  | Card: 3 2 1 0
        key: in std_logic_vector(3 downto 0); -- key(2) = reset | key(3) = clk
    
        ledr: out std_logic_vector(9 downto 0); -- Win = 2 | tie = 1 | lose = 0 
        hex3: out std_logic_vector(6 downto 0); -- carta
        hex1: out std_logic_vector(6 downto 0); -- Decimal Soma;
        hex0: out std_logic_vector(6 downto 0);  -- Numeral Soma;

        hex2: out std_logic_vector(6 downto 0)  -- Apenas para deixar zerado;
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
        while search = '1' and contador < 100 loop
            contador := contador + 1;
            uniform(seed1, seed2, rand);
            generatedNumber := integer(trunc(rand * 7.0)) + 1; 
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
            numberforDisplay:="1111001";
         elsif pickedCard = 2 then
            numberforDisplay:="0100100";
        elsif pickedCard = 3 then
            numberforDisplay:="0110000";
        elsif pickedCard = 4 then
            numberforDisplay:="0011001";
        elsif pickedCard = 5 then
             numberforDisplay:="0010010";
        elsif pickedCard = 6 then 
             numberforDisplay:="0000010";
        elsif pickedCard = 7 then
            numberforDisplay:="1111000";
        elsif pickedCard = 8 then
            numberforDisplay:="0000000";
        elsif pickedCard = 9 then
            numberforDisplay:="0010000";
        elsif pickedCard = 10 then
            numberforDisplay:="0001000";
        elsif pickedCard = 11 then
			numberforDisplay:="0000011";
        elsif pickedCard = 12 then
            numberforDisplay:="1000110";
        elsif pickedCard = 13 then
            numberforDisplay:="0100001";
         else 
            numberforDisplay:="1000000";
        end if;
        return numberforDisplay;
    end function;

    --Essa função retorna o primeiro algarismo das dezenas do número, no caso se for 21, retorna 2.
    function numberSumDezenas(playerSUM: in integer) return STD_LOGIC_VECTOR is 
      variable numberSumDezenasForDisplay: std_logic_vector(6 downto 0) := "1111110";  
      begin
        if playerSUM < 10 then
            numberSumDezenasForDisplay:="1000000";
         elsif playerSUM >= 10 and playerSUM < 19 then            
			numberSumDezenasForDisplay:="1111001";
        elsif playerSUM  >= 20 and playerSUM < 29 then
			numberSumDezenasForDisplay:="0100100";
        else 
			numberSumDezenasForDisplay:="1000000";
        end if;  
        return numberSumDezenasForDisplay;   
    end function;

    --Essa função retorna o segundo algarismo do número, no caso se for 21, retorna 1.
    function numberSumUnidades(playerSUM: in integer) return STD_LOGIC_VECTOR is 
        variable numberSumUnidadesForDisplay: std_logic_vector(6 downto 0) := "1111110";  
        begin
            if playerSUM < 10 then
               if playerSUM = 1 then 
                    numberSumUnidadesForDisplay:="1111001";
               elsif playerSUM = 2 then
                    numberSumUnidadesForDisplay:="0100100";
               elsif playerSUM = 3 then
                    numberSumUnidadesForDisplay:="0110000";
               elsif playerSUM = 4 then
                    numberSumUnidadesForDisplay:="0011001";
               elsif playerSUM = 5 then
                    numberSumUnidadesForDisplay:="0010010";
               elsif playerSUM = 6 then 
                    numberSumUnidadesForDisplay:="0000010";
               elsif playerSUM = 7 then
                    numberSumUnidadesForDisplay:="1111000";
               elsif playerSUM = 8 then
                    numberSumUnidadesForDisplay:="0000000";
               elsif playerSUM = 9 then
                    numberSumUnidadesForDisplay:="0010000";
               else 
                    numberSumUnidadesForDisplay:="1000000";
               end if;
            elsif playerSUM >= 10 and playerSUM < 19 then
               if (playerSUM - 10) = 1 then 
                    numberSumUnidadesForDisplay:="0000110"; 
               elsif (playerSUM - 10) = 2 then
                    numberSumUnidadesForDisplay:="0100100";
               elsif (playerSUM - 10) = 3 then
                    numberSumUnidadesForDisplay:="0110000";
               elsif (playerSUM - 10) = 4 then
                    numberSumUnidadesForDisplay:="0011001";
               elsif (playerSUM - 10) = 5 then
                    numberSumUnidadesForDisplay:="0010010";
               elsif (playerSUM - 10) = 6 then 
                    numberSumUnidadesForDisplay:="0000010";
               elsif (playerSUM - 10) = 7 then
                    numberSumUnidadesForDisplay:="1111000";
               elsif (playerSUM - 10) = 8 then
                    numberSumUnidadesForDisplay:="0000000";
               elsif (playerSUM - 10) = 9 then
                    numberSumUnidadesForDisplay:="0010000";
               else 
                    numberSumUnidadesForDisplay:="1000000";
               end if;
           elsif playerSUM  >= 20 and playerSUM < 29 then
               if (playerSUM - 20) = 1 then 
                   numberSumUnidadesForDisplay:="1111001";
               elsif (playerSUM - 20) = 2 then
                   numberSumUnidadesForDisplay:="0100100";
               elsif (playerSUM - 20) = 3 then
                   numberSumUnidadesForDisplay:="0110000";
               elsif (playerSUM - 20) = 4 then
                   numberSumUnidadesForDisplay:="0011001";
               elsif (playerSUM - 20) = 5 then
                   numberSumUnidadesForDisplay:="0010010";
               elsif (playerSUM - 20) = 6 then 
                   numberSumUnidadesForDisplay:="0000010";
               elsif (playerSUM - 20) = 7 then
                   numberSumUnidadesForDisplay:="1111000";
               elsif (playerSUM - 20) = 8 then
                   numberSumUnidadesForDisplay:="0000000";
               elsif (playerSUM - 20) = 9 then
                   numberSumUnidadesForDisplay:="0010000";
               else 
                   numberSumUnidadesForDisplay:="1000000";
               end if;
           else 
               numberSumUnidadesForDisplay:="1000000";
           end if;  
           return numberSumUnidadesForDisplay; 
    end function;
	 
	function slv_to_int(input_vector: std_logic_vector(3 downto 0)) return integer is
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
                when others => return 0; 
            end case;
   end function;
   --------------------------------------------------------------------------------------------------

    signal clockCount: integer range 0 to 100 := 0;
    signal gameStarted: std_logic := '0';
    signal playerAcum, dealerAcum: integer range 0 to 100 := 0;
    signal usedCardAcum: integer_array := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	TYPE estado is (T, I, P, L, D, R, H, S);
    signal est: estado:= T;

    begin
        process(key(2), key(3)) -- key(2) = reset key(3) = clk
        variable pickedCard: integer range 0 to 100;
        variable playerSUM, DealerSUM: integer range 0 to 100 := 0; -- Precisa de um range pra FPGA entender
        variable usedCard: integer_array := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        begin	
            if key(2) = '0' then
                est <= I;
                ledr <= "0000000000";
                playerAcum <= 0;
                dealerAcum <= 0;
                usedCardAcum <= (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);				
            elsif (key(3)'event and key(3) = '0') then
                if est = T then 
                    ledr <= "0000000000";
                    hex3 <= "1111111";
                    hex1 <= "1111111";
                    hex0 <= "1111111";
                elsif est = I then
					pickedCard := randomGenerator(usedCardAcum);
                    hex3 <= numberDisplayCard(pickedCard);
                    hex1 <= numberSumDezenas(pickedCard);
                    hex0 <= numberSumUnidades(pickedCard);
                    playerAcum <= playerAcum + pickedCard;
                    ledr <= "0000000000";
                    est <= P;
                elsif est = P then
					pickedCard := randomGenerator(usedCardAcum);
                    playerSum :=  playerAcum + pickedCard;
                    hex3 <= numberDisplayCard(pickedCard);
                    hex1 <= numberSumDezenas(playerSum);
                    hex0 <= numberSumUnidades(playerSum);
                    if playerSUM > 21 then
                        ledr <= "0000000001";
                        est <= T;
                    elsif playerSUM = 21 then
                        ledr <= "0000000100";
                        est <= T;
                    else 
                        ledr <= "0000000000";
                        est <= L;
                    end if;
                elsif est = L then
                    if sw(5) = '1' and sw(6) = '0' then
                        pickedCard := randomGenerator(usedCardAcum);
                        playerSum :=  playerAcum + pickedCard;
                        playerAcum <= playerAcum + pickedCard;
                        hex3 <= numberDisplayCard(pickedCard);
                        hex1 <= numberSumDezenas(playerSum);
                        hex0 <= numberSumUnidades(playerSum);
                        if playerSUM > 21 then
                            ledr <= "0000000001";
                            est <= T;
                        elsif playerSUM = 21 then
                            ledr <= "0000000100";
                            est <= T;
                        else 
                            ledr <= "0000000000";
                        end if;
                    elsif sw(6) = '1' and sw(5) = '0' then
                        est <= D;
                    else 
                        est <= T;
                    end if;
                elsif est = D then
                    pickedCard := randomGenerator(usedCardAcum);
                    hex3 <= numberDisplayCard(pickedCard);
                    hex1 <= numberSumDezenas(pickedCard);
                    hex0 <= numberSumUnidades(pickedCard);
                    dealerAcum <= dealerAcum + pickedCard;
                    DealerSUM := dealerAcum + pickedCard;
                    playerSUM := playerAcum;
                    if DealerSUM > 21 then
                        ledr <= "0000000100";
                        est <= T;
                    elsif DealerSUM = 21 then
                        ledr <= "0000000001";
                        est <= T;
                    elsif DealerSUM <= 17 then
                        est <= D;
                    else 
                        ledr <= "0000000010";
                        est <= T;
                    end if;		 
                else 
                    ledr<="1111111111";		
                end if;
            end if;
        end process;                   
end behaviour;
