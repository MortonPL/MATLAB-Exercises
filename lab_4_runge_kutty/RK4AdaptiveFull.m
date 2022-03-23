function [xs, ts, err] = RK4AdaptiveFull(start, h, t, rele, abse)
    % Inicjalizacja
    x = start;
    t_max = t;
    t = 0;
    xs = zeros(2, 1);
    err = ones(2, 1) * eps;
    xs(:, 1) = start;
    % Iteracje
    i = 1;
    while t < t_max
        tx = RK4Step(x, h);
        % Podwójny krok
        x2 = RK4Step(RK4Step(x, h/2), h/2);
        error = norm((x2 - tx) * 16 / 15);
        err(:, i) = error;
        % Korekcja kroku
        e = abs(x2) * rele + abse;
        sa = 0.9 * (min(e ./ error) ^ (1/5));
        h2 = h * sa;
        if sa >= 1
            % Jeśli zwiększamy krok
            h = min([h2, 5 * h, t_max - t]);
            t = t + h;
            ts(:, i) = t;
            x = tx;
            i = i + 1;
            xs(:, i) = x;
        else
            % Jeśli zmniejszamy krok
            assert(h2 > realmin);
            h = h2;
        end
    end
end

