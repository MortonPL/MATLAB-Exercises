function [x_] = GaussSeidel(L, D, U, x, b)
    %GAUSSSEIDEL Funkcja wykonująca jedną iterację metody Gaussa-Seidela.
    n = length(D);
    w = U * x - b;
    x_ = zeros(n, 1);
    
    % Dla 1
    x_(1) = -w(1) / D(1, 1);
    % Dla i = 2, 3, ..., n
    for i = 2:n
        % Zsumuj wszystkie poprzednie x-y
        suma = sum([-L(i, 1:i - 1) .* x_(1:i - 1)']);                              %#ok<NBRAK> 
        % Znajdź i-ty x
        x_(i) = (suma - w(i)) / D(i, i);
    end
end
