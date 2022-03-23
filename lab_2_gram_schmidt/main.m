% Stopnie wielomianu do liczenia
degrees = [1,2,4,8,10];
n = size(degrees,2);

% Dane wejściowe
x=[-5 -4 -3 -2 -1 0 1 2 3 4 5]';
y=[63.638 33.2744 16.1215 4.7061 0.2707 -0.1198 -0.0597 -0.0080 3.4085 12.0457 25.2401]';

% Tworzenie legendy
leg = cell(n + 1, 1);
leg{1} = 'Próbki';
for z = 1 : n
    i = degrees(z);
    leg{z+1} = strcat('Stopień w(x) = ', num2str(i));
end

% Tworzenie wykresów
f1 = figure(1);
PlotStart(y, x, "Funkcja aproksymująca (Układ równań normalnych)", "y")
f2 = figure(2);
PlotStart(y, x, "Funkcja aproksymująca (Rozkład QR)", "y")

% Faktyczne zadanie
Zadanie(x, y, degrees, f1, f2);

% Łączenie wykresów i legend
figure(f1);
legend(leg);
figure(f2);
legend(leg);

function [] = Zadanie(x, y, degrees, f1, f2)
    n = size(degrees,2);
    norms = zeros(2, n);
    errors = zeros(2, n);
    for z = 1 : n
        i = degrees(z);
        % Tworzenie macierzy Grama
        [A] = PolyMatrix(x, i);
        G = A' * A;
        rho = A' * y;

        % Układ równań normalnych – rozkład LU + rozwiązywanie układu z macierzą trójkątną
        [U, ~, P_, b_] = GaussFull(G, rho);
        a1_ = Solve(U, b_);
        a1 = P_ * a1_;
    
        % Rozkłąd QR + rozwiązywanie układu z macierzą trójkątną
        [Q, R] = GramSchmidt(A);
        a2 = Solve(R, Q'*y);
    
        % Próbkowanie
        x_ = linspace(-5, 5, size(x,1)*10);
        y_1 = Poly(x_, a1);
        y_2 = Poly(x_, a2);
        % Liczenie norm residuum - przy zerze zakładamy eps
        norms(1, z) = max(norm(G*a1 - rho), eps);
        norms(2, z) = max(norm(G*a2 - rho), eps);
        % Liczenie błędu aproksymacji
        errors(1, z) = max(norm(Poly(x, a1) - y), eps);
        errors(2, z) = max(norm(Poly(x, a2) - y), eps);
        fprintf("Norma residuum (Układ równań normalnych), n = %d: %e\n", i, norms(1, z));
        fprintf("Norma residuum (Rozkład QR),              n = %d: %e\n", i, norms(2, z));
        fprintf("Norma błędu aproksymacji (Układ równań normalnych), n = %d: %e\n", i, errors(1, z));
        fprintf("Norma błędu aproksymacji (Rozkład QR),              n = %d: %e\n", i, errors(2, z));
        disp(' ');
        
        figure(f1);
        hold on;
        PlotOnce(y_1, x_);
        hold off;
        figure(f2);
        hold on;
        PlotOnce(y_2, x_);
        hold off;
    end
    figure(3);
    PlotAll(errors(1,:), errors(2,:), degrees, "Normy błędu aproksymacji", "Stopień wielomianu", "Norma błędu y2 - y", ["Układ równań normalnych", "Układ równań (QR)"]);
    figure(4);
    PlotAll(norms(1,:), norms(2,:), degrees, "Normy residuum", "Stopień wielomianu", "Norma residuum", ["Układ równań normalnych", "Układ równań (QR)"]);
end

function [] = PlotOnce(ys1, xs1)
    hold on;
    plot(xs1, ys1);
    hold off;
end

function [] = PlotStart(ys1, xs1, name, ylab)
    scatter(xs1, ys1);
    title(name);
    xlabel('x');
    ylabel(ylab);
    xticks(xs1);
end

function [] = PlotAll(ys1, ys2, xs, name, xlab, ylab, leg)
    semilogy(xs, ys1, xs, ys2);
    title(name);
    xlabel(xlab);
    ylabel(ylab);
    axis([min(xs),max(xs),min(ys1),max(ys2)]);
    xticks(xs);
    legend(leg);
    grid on;
end
