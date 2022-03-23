function [Q,R] = GramSchmidt(A)
    %GRAMSCHMIDT Funkcja dokonująca wąskiego rozkładu QR zmodyfikowanym
    %algorytmem Grama-Schmidta.
    [m, n] = size(A);
    Q = zeros(m, n);
    R = zeros(n, n);
    
    % Dla każdej kolumny macierzy A
    for i = 1 : n
        q = A(:, i);
        Q(:, i) = q;
        R(i, i) = 1;
        q2 = q' * q;

        % Ortogonalizujemy następne kolumny macierzy A
        for j = i + 1 : n
            % a_j = a_j - (q^T*a_i / q^T*q) * q;
            R(i, j) = (q' * A(:, j))/q2;
            A(:, j) = A(:, j) - R(i, j) * q;
        end
    end

    %Normalizacja każdej kolumny macierzy Q i wiersza macierzy R
    for i = 1 : n
        q_ = norm(Q(:, i));
        Q(:, i) = Q(:, i) / q_;
        R(i, :) = R(i, :) * q_;
    end
end
