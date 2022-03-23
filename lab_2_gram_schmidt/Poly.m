function [y] = Poly(x,a)
    %POLY Oblicz wartości wielomianu opisanego przez wektor a dla wektora
    %x.
    n = size(a);
    m = size(x, 1);
    y = zeros(m, 1);
    for i = 1 : n
        y = y + x.^(i-1) .* a(i);
    end
end
