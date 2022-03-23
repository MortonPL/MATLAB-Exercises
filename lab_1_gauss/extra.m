% Liczenie uwarunkowań i promieni spektralnych  macierzy
n_max = 8;
cc1 = zeros(n_max, 1);
cc2 = zeros(n_max, 1);
sr1 = zeros(n_max, 1);
sr2 = zeros(n_max, 1);

for i = 1:n_max
    n = (2 ^ i) * 10;
    [A1, b] = Generate1(n);
    [A2, b] = Generate2(n);
    cc1(i) = cond(A1);
    cc2(i) = cond(A2);

    L_D = tril(A1);
    U = triu(A1, 1);
    M = inv(L_D) * -U;
    sr1(i) = abs(eigs(M, 1, 'largestabs'));
    L_D = tril(A2);
    U = triu(A2, 1);
    M = inv(L_D) * -U;
    sr2(i) = abs(eigs(M, 1, 'largestabs'));
    fprintf("Wykonano krok %d.\n", i);
end

disp("Wskaźniki uwarunkowania");
disp(cc1);
disp(cc2);
disp("Promienie spektralne");
disp(sr1);
disp(sr2);
