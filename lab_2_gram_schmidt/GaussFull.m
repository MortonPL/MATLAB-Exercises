function [U, P, P_, b_] = GaussFull(A, b)
    %GAUSSFULL Funkcja rozkładająca macierz metodą eliminacji Gaussa z pełnym wyborem elementu głównego.
    U = A;
    n = length(A);
    P = eye(n);
    P_ = eye(n);
    b_ = b;

    for k = 1 : n - 1
        % Znajdź pozycję (i, l) elementu głównego k-tego kroku
        [~, i] = max( abs( U(k:n, k:n) ), [], 'all' );
        i = i + (n + ceil(i/(n - k + 1)) ) * (k - 1);
        l = floor((i - 1)/n) + 1;
        i = mod(i - 1, n) + 1;

        % Zamiana kolumn
        P_k = Swap(k, l, n);
        U = U * P_k;
        P_ = P_ * P_k;
        % Zamiana wierszy
        Pk = Swap(k, i, n);
        U = Pk * U;
        P = Pk * P;
        % Zamiana wierszy prawej strony
        b_ = Pk * b_;

        % Zwykły krok eliminacji
        for j = k + 1:n
            % Zwykły krok eliminacji lewej strony
            l = U(j, k) / U(k, k);
            U(j, k:n) = U(j, k:n) - l * U(k, k:n);
            % Zwykły krok eliminacji prawej strony
            b_(j) = b_(j) - l * b_(k);
        end
    end
end
