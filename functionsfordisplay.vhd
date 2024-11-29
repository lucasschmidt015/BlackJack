 --Essa função retorna o número da carta, nesse caso se a carta for>=10 ele msotra como hexadecimal
    function numberDisplayCard(pickedCard: in integer) return STD_LOGIC_VECTOR is 
        variable numberforDisplay: std_logic_vector:="1111110";  
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
      variable numberSumDezenasForDisplay: std_logic_vector:="1111110";  
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
        variable numberSumUnidadesForDisplay: std_logic_vector:="1111110";  
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
    
