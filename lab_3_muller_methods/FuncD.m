function [y] = FuncD(x)
    %FUNCD Pochodna funkcji, której rozwiązań szukamy.
    %y = 1.2 * sin(x) + 2 * log(x+2) - 5;
    y = 1.2 * cos(x) + 2/(x+2);
end
