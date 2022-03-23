function [x] = Solve(A, b)
    %SOLVE Funkcja rozwiązująca układ równań w macierzy trójkątnej
    n = length(b);
    x = zeros(n, 1);
    % Dla n
    x(n) = b(n) / A(n, n);
    % Dla n - 1
    x(n - 1) = (b(n - 1) - A(n - 1, n) * x(n)) / A(n - 1, n - 1);
    % Dla k = n - 2, n - 3, ..., 1
    for k = (n - 2):-1:1
        % Zsumuj wszystkie poprzednie x-y
        suma = sum([A(k, k+1:n) * x(k+1:n)]);                               %#ok<NBRAK> 
        % Znajdź k-ty x
        x(k) = (b(k) - suma) / A(k, k);
    end
end
