function [c, fc, history] = Bisection(a, b, max_iter, delta, delta2)
    %BISECTION Metoda Bisekcji na przedziale od a do b.
    history = zeros(max_iter, 2);
    for i = 1 : max_iter
        c = (a + b) / 2;
        fa = Func(a);
        fb = Func(b);
        fc = Func(c);
        history(i, :) = [c, fc];
        % Test stopu
        if abs(fc) < delta
            if abs(b - a) < delta2
                history = history(1:i, :);
                return
            end
        end
        if fa * fc < 0
            b = c;
        elseif fc * fb < 0
            a = c;
        end
    end
end
