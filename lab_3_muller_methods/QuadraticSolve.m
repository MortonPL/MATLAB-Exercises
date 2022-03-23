function [x1, x2] = QuadraticSolve(poly_coeff)
%QUADRATICSOLVE Funkcja znajdująca miejsca zerowe trójmianu kwadratowego.
    a = poly_coeff(3, 1);
    b = poly_coeff(2, 1);
    c = poly_coeff(1, 1);
    d = sqrt(b^2 - 4 * a * c);
    z = max(-b - d, -b + d);
    x1 = z / (2 * a);
    x2 = (-b / a) - x1;
end
