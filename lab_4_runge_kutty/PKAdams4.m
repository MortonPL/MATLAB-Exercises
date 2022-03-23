function [x2, eval, err] = PKAdams4(x, h, eval)
    % Predyktor-korektor, metda Adamsa
    P_beta = [55/24 -59/24 37/24 -9/24];
    C_beta = [251/720 646/720 -264/720 106/720 -19/720];
    % Predykcja
    P = x + h * sum(eval .* P_beta, 2);
    eval2 = Func(P);
    % Korekcja
    C = x + h * sum([eval2 eval] .* C_beta, 2);
    x2 = C;
    % Błąd
    err = abs((P - C) * 19/-270);
    eval = [eval(:, 2:end) Func(x2)];
end
