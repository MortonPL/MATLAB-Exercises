a_min = 2;
b_max = 12;
max_iter = 1000;
delta = 1e-8;
delta2 = 1e-4;
a = [1 2 5 5 -2]';

% Tworzenie legendy
leg1 = {'f(x)', 'y = 0', 'Pierwsze rozwiązanie', 'Pierwszy przedział', 'Drugie rozwiązanie', 'Drugi przedział'};
leg2 = {'f(x)', 'y = 0', 'Pierwsze rozwiązanie', 'Pierwszy x0', 'Drugie rozwiązanie', 'Drugi x0'};

% Tworzenie wykresów
x = linspace(a_min, b_max, 100);
y = Func(x);
figure(1);
PlotFunc(y, x, linspace(a_min, b_max, b_max - a_min + 1), "Funkcja zadana - Metoda Bisekcji", "f(x)");
figure(2);
PlotFunc(y, x, linspace(a_min, b_max, b_max - a_min + 1), "Funkcja zadana - Metoda Newtona", "f(x)");

% Faktyczne zadanie
Zadanie1a([a_min a_min+5], [b_max-3 b_max], max_iter, delta, delta2);
Zadanie1b([5.18 10.45], max_iter, delta);
Zadanie2(a, max_iter, delta);

% Łączenie wykresów i legend
figure(1);
legend(leg1, 'Location', 'southeast');
figure(2);
legend(leg2, 'Location', 'southeast');

function [] = Zadanie1a(a_mins, b_maxs, max_iter, delta, delta2)
    disp('ZADANIE 1 - BISEKCJA');
    figure(1);
    color = {'red','blue'};
    aby = [0.5, -0.5];
    for i = 1 : 2
        fprintf('\nMiejsce zerowe %d\n', i);
        [x, y, history] = Bisection(a_mins(i), b_maxs(i), max_iter, delta, delta2);
        PlotOnceA(y, x, a_mins(i), b_maxs(i), aby(i), color(i));
        disp(history);
    end
end

function [] = Zadanie1b(starts, max_iter, delta)
    disp('ZADANIE 2 - NEWTON');
    figure(2);
    color = {'red','blue'};
    for i = 1 : 2
        fprintf('\nMiejsce zerowe %d\n', i);
        [x, y, history] = Newton(starts(i), max_iter, delta);
        PlotOnceB(y, x, starts(i), color(i));
        disp(history);
    end
end

function [] = Zadanie2(a, max_iter, delta)
    figure(3);
    n = size(a, 1);
    x = zeros(n - 1, 1);
    % Iteracje metody Mullera
    for i = 1 : n - 3
        x(i) = Muller(a, max_iter, delta);
        a = Deflate(x(i), a);
    end
    % Zwykłe rozwiązanie trójmianu kwadratowego
    [x(n-2), x(n-1)] = QuadraticSolve(a);
    disp('ZADANIE 2 - MM1');
    disp(x);
    PlotGrid(imag(x), real(x), 'Rozwiązania wielomianu dla MM1', 'Re(x)', 'Im(x)');
end

function [] = PlotOnceA(ys1, xs1, a, b, aby, color)
    hold on;
    scatter(xs1, ys1, char(color), 'filled');
    line([a,b], [aby,aby], 'LineWidth', 1, 'Color', char(color));
    hold off;
end

function [] = PlotOnceB(ys1, xs1, start, color)
    hold on;
    scatter(xs1, ys1, char(color), 'filled');
    scatter(start, Func(start), char(color));
    hold off;
end

function [] = PlotFunc(ys1, xs1, ticks, name, ylab)
    plot(xs1, ys1, 'Color', 'k');
    title(name);
    xlabel('x');
    ylabel(ylab);
    xticks(ticks);
    line(xlim(), [0,0], 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--');
end

function [] = PlotGrid(ys, xs, name, xlab, ylab)
    scatter(xs, ys, char('g'), 'filled');
    title(name);
    xlabel(xlab);
    ylabel(ylab);
    line(xlim(), [0,0], 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--');
    line([0,0], ylim(), 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--');
end
