function [xs, ts, err] = PKAdams4Full(start, h, t)
    % Inicjalizacja
    x = start;
    t_max = t;
    t = 3*h;
    xs = zeros(2, 4);
    err = ones(2, 3) * eps;
    ts(:, 1:3) = [h 2*h 3*h];
    % Pierwsze 3 kroki z RK4
    [xs(:, 1:4), eval, err(:, 1:3)] = PKAdams4Init(x, h);
    % Iteracje
    i = 4;
    while t < t_max
        [xs(:, i+1), eval, err(:, i)] = PKAdams4(x, h, eval);
        x = xs(:, i+1);

        t = t + h;
        ts(:, i) = t;
        i = i + 1;
    end
end
