function [A, b] = Generate2(n)
    %GENERATE2 Funkcja generująca dane typu 2).
    % Stwórz macierz A
    A = 7 ./ [9 * (2 + ones(n) .* [1:n] + ones(n) .* [1:n]')];              %#ok<NBRAK> 
    % Stwórz wektor b
    b = 3 * mod([0:n-1], 2)' - 1;                                           %#ok<NBRAK>
end
