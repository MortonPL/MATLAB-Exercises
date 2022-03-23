function [xs, ts, err] = RK4Full(start, h, t)
    % Inicjalizacja
    x = start;
    t_max = t;
    t = 0;
    xs = zeros(2, 1);
    err = ones(2, 1) * eps;
    xs(:, 1) = start;
    ts(:, 1) = t;
    % Iteracje
    i = 1;
    while t < t_max
        xs(:, i+1) = RK4Step(x, h);
        x = xs(:, i+1);
        % Błąd
        e = RK4Step(RK4Step(x, h/2), h/2);
        err(:, i) = abs((e - x) * 16/15);

        t = t + h;
        ts(:, i) = t;
        i = i + 1;
    end
end
