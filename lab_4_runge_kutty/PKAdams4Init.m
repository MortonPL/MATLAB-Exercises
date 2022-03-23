function [xs, eval, err3] = PKAdams4Init(x, h)
    xs = zeros(2, 4);
    xs(:, 1) = x;
    err3 = ones(2, 3) * eps;
    % Oblicznie początkowych 4 wartości
    eval(:, 1) = Func(x);
    for i = 2:4
        x = RK4Step(x, h);
        xs(:, i) = x;
        eval(:, i) = Func(x);
        e = RK4Step(RK4Step(x, h/2), h/2);
        err3(:, i-1) = abs((e - x) * 16/15);
    end
end
