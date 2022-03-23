function [x3] = Muller(poly_coeff, max_iter, delta)
    %MULLER Funkcja wyznaczająca jedno zero zadanego wielomianu za pomocą
    % metody Mullera #1.

    % Wartości początkowe
    x = [0.5;2.5;1.5];

    for i = 1 : max_iter
        % Początek iteracji
        x0 = x(1);
        x1 = x(2);
        x2 = x(3);

        % Tworzenie paraboli
        z0 = x0 - x2;
        z1 = x1 - x2;
        zz = z1 / z0;
        fx0 = Poly(x0, poly_coeff);
        fx1 = Poly(x1, poly_coeff);
        fx2 = Poly(x2, poly_coeff);
        a = (fx1 - fx0 * zz + fx2 * (zz - 1)) / (z1^2 - z0^2 * zz);
        b = (fx0 - fx2) / z0 - z0 * a;
        c = fx2;
        d = sqrt(b*b - 4*a*c);

        % Wyznaczanie kolejnego przybliżenia rozwiązania
        if abs(b + d) >= abs(b - d)
            x3 = x2 - 2*c / (b + d);
        else
            x3 = x2 - 2*c / (b - d);
        end

        % Test stopu
        if abs(Poly(x3, poly_coeff)) < delta
            return
        end

        % Odrzucanie najdalszego punktu
        [~, j] = max([abs(x3 - x0), abs(x3 - x1), abs(x3 - x2)]);
        x(j) = x3;
    end
end
