function [x2] = RK4Step(x, h)
    k1 = Func(x);
    k2 = Func(x + 0.5*h*k1);
    k3 = Func(x + 0.5*h*k2);
    k4 = Func(x + h*k3);
    x2 = x + 1/6*h*(k1 + 2*k2 + 2*k3 + k4);
end
