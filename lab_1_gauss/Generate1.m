function [A, b] = Generate1(n)
    % Funkcja generująca zestaw danych typu 1).
    % Ze względu na specyficzny wzór macierzy, możemy ją stworzyć dodając
    % trzy macierze przekątne, dwie z nich przesunięte o jedną kolumnę w
    % lewo lub w prawo. W ten sposób wykorzystujemy działania na macierzach
    % zamiast iteracyjnego budowania macierzy element po elemencie.
    % Stwórz wyższą 'cięciwę'
    A2 = [zeros(n,1 ) eye(n)];
    % Stwórz niższą 'cięciwę'
    A3 = [eye(n) zeros(n, 1)];
    % Złóż macierz A
    A = 4 * eye(n) + A2(:, 1:n) + A3(:, 2:n+1);
    % Stwórz wektor b
    b = [3.0:0.8:2.2 + 0.8 * n]';                                           %#ok<NBRAK>
end
