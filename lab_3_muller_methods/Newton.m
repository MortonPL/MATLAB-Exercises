function [x, fx, history] = Newton(x, max_iter, delta)
    %NEWTON Metoda Newtona dla punktu startowego x.
    history = zeros(max_iter, 2);
    for i = 1 : max_iter
        x = x - Func(x)/FuncD(x);
        fx = Func(x);
        history(i, :) = [x fx];
        % Test stopu
        if abs(fx) < delta
            history = history(1:i, :);
            return
        end
    end
end
