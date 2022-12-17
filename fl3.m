function [MachNumber] = fl3(Realnum,T,K1,K2)
% V is the mantissa of the real number
v = [];
% Machnum is the machine number of the inputs
Machnum = [];
cnt = 0;
if floor(T) == T && floor(K2) == K2 && floor(K1) == K1 && (K2 > K1) && (Realnum == real(Realnum))
    % calling fl2 function to get the M infinity and Epsilon0
    [ele,mInf,E0,E1] = fl2(T,K1,K2);
    % absolute value of the real number
    PossitiveRealnum  =  abs(Realnum);

    % checing if the real number representate in machine number set
    if  E0 <= PossitiveRealnum && PossitiveRealnum <= mInf
        %   Fpart Lpart stands for First and last part of the real number
        Fpart = dec2bin(PossitiveRealnum) == '1';
        Lpart = PossitiveRealnum - floor(PossitiveRealnum);
        % in case after the computation of our real number we have 00.001
        if Fpart == zeros
            for i = 1:T
                Lpart = Lpart*2;
                if Lpart < 1
                    v = [v,0];
                else
                    Lpart = Lpart - 1;
                    v = [v,1];
                end
            end
            Lpart = v;
            % Checking how many zeros we have before the first 1
            for  i = 1:T
                if v(i) == 1
                    break;
                end
                cnt = cnt + 1;
            end
            % sign-bit of the mantissa
            if Realnum > 0
                %  cnt+1 to remove first cnt elements from the array.
                Machnum = [0,v(cnt+1:end),zeros(1,cnt),(-cnt)];
            else
                Machnum = [1,v(cnt+1:end),zeros(1,cnt),(-cnt)];
            end

        else

            % To get a mantissa on the legnth of T and assign it into a vector
            for i = 1:(T-length(Fpart))
                Lpart = Lpart*2;
                if Lpart < 1
                    v = [v,0];
                else
                    Lpart = Lpart - 1;
                    v = [v,1];
                end
            end
            % The vector is assigned to Lpart
            Lpart = v;

            % sign-bit of the mantissa
            if K1<=length(Fpart) && length(Fpart) <= K2
                Machnum = [0,Fpart,Lpart,length(Fpart)];
            else
                disp("Your Machine number characteristic doesnt match the K1 and K2!")
            end
            % sign-bit of the mantissa
            if Realnum < 0
                Machnum = [1,Fpart,Lpart,length(Fpart)];
            end
        end
        %  if the real number cant representate in machine number set
    else
        disp("Your inputs arent appropiate for the machine number set(ε0 ≤ |r| ≤ M∞)")
    end
end

disp(Machnum);
MachNumber = Machnum;
end


