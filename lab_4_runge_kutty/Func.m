function [x2] = Func(x)
    x2 = zeros(size(x));
    a = (0.04 - x(1)*x(1) - x(2)*x(2));
    x2(1) = x(2) + x(1) * a;
    x2(2) = -x(1) + x(2) * a;
end
