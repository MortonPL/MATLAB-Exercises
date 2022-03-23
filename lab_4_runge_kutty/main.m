t = 20; % przedział [0 20]
start = [9 0 3 0.001; 8 0.2 0 0.001]; % punkty startowe
hs =  [0.01   0.002   0.01
       0.01   0.0005  0.01
       0.01   0.002   0.01
       0.005  0.0005  0.01];  % wartości kroków
h2s = [0.0164 0.005
       0.3    0.001
       0.11   0.005
       0.01   0.001];  % wartości za dużych kroków
rele = 2^-10; % błąd względny dla RK4 zmienny krok
abse = 2^-10; % błąd stały dla RK4 zmienny krok

funtitles = ["RK4 (stały krok)", "PK Adams", "RK4 (zmienny krok)"];
datatitles = ["a) x1=9, x2=8"; "b) x1=0, x2=0.2"; "c) x1=3, x2=0"; "d) x1=0.001, x2=0.001"];

% Faktyczne zadanie
stats(:, 1:3) = Zadanie(t, start(:, 1), hs(1, :), h2s(1, :) , rele, abse, funtitles, datatitles(1, :));
stats(:, 4:6) = Zadanie(t, start(:, 2), hs(2, :), h2s(2, :), rele, abse, funtitles, datatitles(2, :));
stats(:, 7:9) = Zadanie(t, start(:, 3), hs(3, :), h2s(3, :), rele, abse, funtitles, datatitles(3, :));
stats(:, 10:12) = Zadanie(t, start(:, 4), hs(4, :), h2s(4, :), rele, abse, funtitles, datatitles(4, :));

% Statystyki
names = {'Metoda', 'Czas', 'L. krokow', 'Min. blad', 'Sr. blad', 'Max. blad'};
writetable(cell2table(stats', 'VariableNames', names), "stats.csv");


function [data] = Zadanie(t, start, hs, h2s, rele, abse, funtitles, datatitles)
    [~, xs3] = ode45(@(t, x) Func(x), [0 t], start(:, 1));
    % RK4 stały krok
    if true
        ttt = tic();
        for j = 1:10
            [xs1, ts1, errs] = RK4Full(start(:, 1), hs(1, 1), t);
        end
        time = toc(ttt) / 10;
        [xs2, ~] = RK4Full(start(:, 1), h2s(1, 1), t);
        PlotLine(xs1, xs2, xs3', hs(1, 1), h2s(1, 1), funtitles(1, 1), datatitles(1, 1));
        PlotError(errs, ts1, funtitles(1,1), datatitles(1, 1));
        data(:, 1) = {
            "RK4staly"
            time
            length(ts1)
            min(errs,  [],'all')
            mean(errs, 'all')
            max(errs, [], 'all')
        };
    end

    % PK Adams 4
    if true
        ttt = tic();
        for j = 1:10
            [xs1, ts1, errs] = PKAdams4Full(start(:, 1), hs(1, 2), t);
        end
        time = toc(ttt) / 10;
        [xs2, ~, ~] = PKAdams4Full(start(:, 1), h2s(1, 2), t);
        PlotLine(xs1, xs2, xs3', hs(1, 2), h2s(1, 2), funtitles(1, 2), datatitles(1, 1));
        PlotError(errs, ts1, funtitles(1, 2), datatitles(1, 1));
        data(:, 2) = {
            "PKAdams"
            time
            (length(ts1) - 1)
            min(errs,  [],'all')
            mean(errs, 'all')
            max(errs, [], 'all')
        };
    end

    % RK4 zmienny krok
    if true
        ttt = tic();
        for j = 1:10
            [xs1, ts1, errs] = RK4AdaptiveFull(start(:, 1), hs(1, 3), t, rele, abse);
        end
        time = toc(ttt) / 10;
        PlotLineAdaptive(xs1, xs3', hs(1, 3), funtitles(1, 3), datatitles(1, 1));
        PlotError(errs, ts1, funtitles(1, 3), datatitles(1, 1));
        data(:, 3) = {
            "RK4zmienny"
            time
            length(ts1)
            min(errs,  [],'all')
            mean(errs, 'all')
            max(errs, [], 'all')
        };
    end
end

function [] = PlotError(errs, ts, funtitle, datatitle)
    figure;
    semilogy(ts, errs);
    title(strcat("Błedy ", funtitle, " dla danych ", datatitle));
    legend(["x1", "x2"]);
    xlabel("t");
    ylabel("Błąd");
    xlim([0 20]);
end

function [] = PlotLine(xs1, xs2, xs3, h, h2, funtitle, datatitle)
    figure;
    hold on
    plot(xs1(1, :), xs1(2, :));
    plot(xs2(1, :), xs2(2, :));
    plot(xs3(1, :), xs3(2, :));
    hold off
    title(strcat("Ruch ", funtitle, " dla danych ", datatitle));
    xlabel("x1");
    ylabel("x2");
    legend([strcat("RK4 h = ", num2str(h)), strcat("RK4 h = ", num2str(h2)), "ode45"])
    axis equal;
end

function [] = PlotLineAdaptive(xs1, xs3, h, funtitle, datatitle)
    figure;
    hold on
    plot(xs1(1, :), xs1(2, :));
    plot(xs3(1, :), xs3(2, :));
    hold off
    title(strcat("Ruch ", funtitle, " dla danych ", datatitle));
    xlabel("x1");
    ylabel("x2");
    legend([strcat("RK4 h = ", num2str(h)), "ode45"])
    axis equal;
end
