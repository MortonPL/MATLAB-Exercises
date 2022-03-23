function [P] = Swap(w, k, n)
    %SWAP Funkcja generująca macierz kwadratową P przestawienia (w, k) o wymiarach n x n.
    P = eye(n);
    temp = P(:, k);
    P(:, k) = P(:, w);
    P(:, w) = temp;
end
