function [q] = Deflate(alpha, a)
    %DEFLATE Funkcja dokonująca deflacji wielomianu a czynnikiem liniowym
    % alfa.
    n = size(a, 1);
    k = ceil(n / 2);
    q = zeros(1, n+1);
    for i = flip(k+1 : n)
        q(i) = a(i) + q(i+1) * alpha;
    end
    for i = 1 : k
        q(i+1) = (q(i) - a(i)) / alpha;
    end
    q = q(2:n).';
end
