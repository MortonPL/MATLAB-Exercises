n_max = 8;
delta1 = 1e-8;
delta2 = 1e-14;

[ax1, ax2] = Zadanie1_1(n_max);
[ax3, ax4] = Zadanie1_2(n_max);
[ax5, ax6, ax9] = Zadanie2_1(n_max, delta1, delta2);
[ax7, ax8, ax10] = Zadanie2_2(n_max, delta1, delta2);

linkaxes([ax1 ax5],'y');
linkaxes([ax3 ax7],'y');
linkaxes([ax2 ax4],'y');
linkaxes([ax6 ax8],'y');

function [ax1] = PlotAll(ys, xs, name, ylab)
    figure
    semilogx(xs, ys(:, 1), xs, ys(:, 2));
    title(name);
    xlabel('Stopień macierzy A [1]');
    ylabel(ylab);
    %set(gca, 'XTick', xs)
    xticks(xs);
    ax1 = gca;
    grid on;
    legend('Własna implementacja', 'MATLAB');
end

function [ax1] = PlotAllI(ys, xs, name, ylab)
    figure
    semilogx(xs, ys(:, 1), xs, ys(:, 2));
    title(name);
    xlabel('Stopień macierzy A [1]');
    ylabel(ylab);
    %set(gca, 'XTick', xs)
    xticks(xs);
    ax1 = gca;
    grid on;
    legend('Wykonane iteracje', 'Limit iteracji');
end

function [ax1] = PlotAllT(ys, xs, name, ylab)
    figure
    semilogx(xs, ys(:, 1));
    title(name);
    xlabel('Stopień macierzy A [1]');
    ylabel(ylab);
    %set(gca, 'XTick', xs)
    xticks(xs);
    ax1 = gca;
    grid on;
    legend('Własna implementacja');
end

function [ax1] = LogPlotAll(ys, xs, name, ylab)
    figure
    loglog(xs, ys(:, 1), xs, ys(:, 2));
    title(name);
    xlabel('Stopień macierzy A');
    ylabel(ylab);
    axis([min(xs),max(xs),min(ys(:,1)),max(ys(:,1))]);
    %set(gca, 'XTick', xs)
    xticks(xs);
    ax1 = gca;
    grid on;
    legend('Własna implementacja', 'MATLAB');
end

function [ax1, ax2] = Zadanie1_1(n_max)
    % Utwórz tablice na wyniki.
    rr = zeros(n_max, 2);
    times = zeros(n_max, 1);
    % Rozwiąż układ dla n = 20,40,80,...
    for i = 1:n_max
        n = (2 ^ i) * 10;
        [A, b] = Generate1(n);
        
        tic;
        % Dokonaj eliminacji i zmierz czas.
        [U, ~, P_, b_] = GaussFull(A, b);
        times(i, 1) = toc;
        % Rozwiąż układ
        x_ = Solve(U, b_);
        % Dokonaj przestawień wierszy w x.
        x = P_ * x_;
        
        % Porównanie z wersją MATLABa
        y = linsolve(A, b);
        rr(i, :) = [norm(A * x - b, 2), norm(A * y - b, 2)];
    end
    % Logowanie, rysowanie wykresów.
    disp('[Gauss] - Ukończono.');
    disp(rr);
    ax1 = LogPlotAll(rr, (2.^(1:n_max)) * 10, 'Gauss - Dane 1 - Norma residuum', 'Norma residuum [1]');
    saveas(gcf,'zad1_1_norma.pdf');
    disp(times);
    ax2 = PlotAllT(times, (2.^(1:n_max)) * 10, 'Gauss - Dane 1 - Czas wykonania', 'Czas [s]');
    saveas(gcf,'zad1_1_czas.pdf');
end

function [ax1, ax2] = Zadanie1_2(n_max)
    % Utwórz tablice na wyniki.
    rr = zeros(n_max, 2);
    times = zeros(n_max, 1);
    % Rozwiąż układ dla n = 20,40,80,...
    for i = 1:n_max
        n = (2 ^ i) * 10;
        [A, b] = Generate2(n);
        
        tic;
        % Dokonaj eliminacji i zmierz czas.
        [U, ~, P_, b_] = GaussFull(A, b);
        times(i, 1) = toc;
        % Rozwiąż układ
        x_ = Solve(U, b_);
        % Dokonaj przestawień wierszy w x.
        x = P_ * x_;
        
        % Porównanie z wersją MATLABa
        y = linsolve(A, b);
        rr(i, :) = [norm(A * x - b, 2), norm(A * y - b, 2)];
    end
    % Logowanie, rysowanie wykresów.
    disp('[Gauss] - Ukończono.');
    disp(rr);
    ax1 = LogPlotAll(rr, (2.^(1:n_max)) * 10, 'Gauss - Dane 2 - Norma residuum', 'Norma residuum [1]');
    saveas(gcf,'zad1_2_norma.pdf');
    disp(times);
    ax2 = PlotAllT(times, (2.^(1:n_max)) * 10, 'Gauss - Dane 2 - Czas wykonania', 'Czas [s]');
    saveas(gcf,'zad1_2_czas.pdf');
end

function [ax1, ax2, ax3] = Zadanie2_1(n_max, delta1, delta2)
    % Utwórz tablice na wyniki.
    rr = zeros(n_max, 2);
    ii = zeros(n_max, 2);
    % Rozwiąż układ dla n = 20,40,80,...
    for i = 1:n_max
        n = (2 ^ i) * 10;
        [A, b] = Generate1(n);
        % Dekompozycja macierzy.
        L = tril(A, -1);
        D = diag(A) .* eye(n);
        U = triu(A, 1);
        x = ones(n, 1);
        times = zeros(n_max, 1);
        iter = 0;
        
        tic;
        % Warunek stopu - osiągnięcie limitu iteracji.
        while iter < n * 4
            % Pojedyncza iteracja
            x_ = GaussSeidel(L, D, U, x, b);
            % Warunek stopu - odpowiednio mała różnica wyników.
            if norm((x_ - x), 2) <= delta1
                r = A * x - b;
                % Warunek stopu - odpowiednio mała norma residuum.
                if norm(r, 2) <= delta2
                    break;
                end
                delta1 = delta1 / 2;
            end
            iter = iter + 1;
            x = x_;
        end
        times(i, 1) = toc;
        fprintf('[Gauss-Seidel] - Rozmiar %d - Liczba iteracji: %d\n', n, iter);
        
        % Porównanie z wersją MATLABa.
        y = linsolve(A, b);
        rr(i, :) = [norm(A * x - b, 2), norm(A * y - b, 2)];
        ii(i, :) = [iter n * 4];
    end
    % Logowanie, rysowanie wykresów.
    disp('[Gauss-Seidel] - Ukończono.');
    disp(rr);
    ax1 = LogPlotAll(rr, (2.^(1:n_max)) * 10, 'Gauss-Seidel - Dane 1 - Norma residuum', 'Norma residuum [1]');
    saveas(gcf,'zad2_1_norma.pdf');
    disp(times);
    ax2 = PlotAllT(times, (2.^(1:n_max)) * 10, 'Gauss-Seidel - Dane 1 - Czas wykonania', 'Czas [s]');
    saveas(gcf,'zad2_1_czas.pdf');
    ax3 = PlotAllI(ii, (2.^(1:n_max)) * 10, 'Gauss-Seidel - Dane 1 - Liczba iteracji', 'Iteracje [s]');
    saveas(gcf,'zad2_1_iter.pdf');
end

function [ax1, ax2, ax3] = Zadanie2_2(n_max, delta1, delta2)
    % Utwórz tablice na wyniki.
    rr = zeros(n_max, 2);
    ii = zeros(n_max, 2);
    % Rozwiąż układ dla n = 20,40,80,...
    for i = 1:n_max
        n = (2 ^ i) * 10;
        [A, b] = Generate2(n);
        % Dekompozycja macierzy.
        L = tril(A, -1);
        D = diag(A) .* eye(n);
        U = triu(A, 1);
        x = ones(n, 1);
        times = zeros(n_max, 1);
        iter = 0;
        
        tic;
        % Warunek stopu - osiągnięcie limitu iteracji.
        while iter < n * 4
            % Pojedyncza iteracja
            x_ = GaussSeidel(L, D, U, x, b);
            % Warunek stopu - odpowiednio mała różnica wyników.
            if norm((x_ - x), 2) <= delta1
                r = A * x - b;
                % Warunek stopu - odpowiednio mała norma residuum.
                if norm(r, 2) <= delta2
                    break;
                end
                delta1 = delta1 / 2;
            end
            iter = iter + 1;
            x = x_;
        end
        times(i, 1) = toc;
        fprintf('[Gauss-Seidel] - Rozmiar %d - Liczba iteracji: %d\n', n, iter);
        
        % Porównanie z wersją MATLABa.
        y = linsolve(A, b);
        rr(i, :) = [norm(A * x - b, 2), norm(A * y - b, 2)];
        ii(i, :) = [iter n * 4];
    end
    % Logowanie, rysowanie wykresów.
    disp('[Gauss-Seidel] - Ukończono.');
    disp(rr);
    ax1 = LogPlotAll(rr, (2.^(1:n_max)) * 10, 'Gauss-Seidel - Dane 2 - Norma residuum', 'Norma residuum [1]');
    saveas(gcf,'zad2_2_norma.pdf');
    disp(times);
    ax2 = PlotAllT(times, (2.^(1:n_max)) * 10, 'Gauss-Seidel - Dane 2 - Czas wykonania', 'Czas [s]');
    saveas(gcf,'zad2_2_czas.pdf');
    ax3 = PlotAllI(ii, (2.^(1:n_max)) * 10, 'Gauss-Seidel - Dane 2 - Liczba iteracji', 'Iteracje [s]');
    saveas(gcf,'zad2_2_iter.pdf');
end
