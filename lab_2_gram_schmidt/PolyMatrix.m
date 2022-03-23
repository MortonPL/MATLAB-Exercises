function [A] = PolyMatrix(x, n)
    %POLYMATRIX Funkcja tworząca macierz A.
    n = n + 1;
    A = zeros(size(x, 1), n);
    for i = 1 : n
        A(:, i) = x.^(i-1);
    end
end
