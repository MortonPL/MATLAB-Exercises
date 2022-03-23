function [G, rho] = GramMatrix(x, y, n)
    %GRAMMATRIX Funkcja konstruująca macierz Grama dla wielomianu
    % n-tego stopnia.

    n = n + 1;
    G = zeros(n, n);
    rho = zeros(n, 1);
    exp = zeros(2*n - 1, size(x, 1));
    
    for k = 1 : 2*n - 1
        % Liczenie i zapamiętywanie x^n, n = 0,1,2...
        exp(k, :) = x'.^(k-1);
        g = sum(exp(k, :));
        % Dla G(i, j) = sum(x^(i+j)) zachodzi zależność:
        % G(i, j) = G(j, i) = G(i-n, j+n), n = 0,1,2...
        % Dlatego w kroku k wystarczy policzyć tę wartość raz i zapisać
        % w każdym elemencie drugiej przekątnej obecnej podmacierzy
        % (kwadratowej macierzy k x k z początkiem w prawym górnym rogu
        % konstruowanej macierzy G). Dzięki temu w każdym kroku liczymy
        % raz, a nie k razy.
        for i = max(1, k-n+1) : min(k, n)
            G(i, k-i+1) = g;
        end
    end
    for k = 1 : n
        rho(k) = sum(y' .* exp(k, :));
    end
end
