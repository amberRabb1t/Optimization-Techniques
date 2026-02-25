close all;
clear;
clc;

syms x;
f(1) = 5^x + (2-cos(x))^2;
f(2) = (x-1)^2 + exp(x-5)*sin(x+3);
f(3) = exp(-3*x) - (sin(x-2)-2)^2;

a = -1;
b = 3;

l = 0.01;
emax = l/2 - 0.0001;
evec=emax/100:emax/100:emax;

e = 0.001;
lmax = 0.5;
lvec = 0.01:(lmax-0.01)/99:lmax;

v = zeros(6,100);

for i=1:3
    for j=1:100
        temp = bisect(evec(j), l, a, b, f(i), x);
        v(i,j) = temp.noc;
        temp = bisect(e, lvec(j), a, b, f(i), x);
        v(i+3,j) = temp.noc;
    end
end

for i=1:3
    figure(i);
    plot(evec, v(i,:), 'LineWidth', 1);
    xlabel('ε');
    ylabel('Number of objective function calls');
    title(sprintf('l=0.01 with variable ε, Objective function f%d', i));

    figure(i+3);
    plot(lvec, v(i+3,:), 'LineWidth', 1);
    xlabel('l');
    ylabel('Number of objective function calls');
    title(sprintf('e=0.001 with variable l, Objective function f%d', i));
end

lvalue = [0.01 0.3 0.5 0.8];

for i=1:3
    widthadj = 0.5;
    figure(i+6);
    for j=1:length(lvalue)
        temp = bisect(e, lvalue(j), a, b, f(i), x);
        plot(1:length(temp.a), temp.a, 'DisplayName', sprintf('αk, l = %.2f', lvalue(j)), 'LineWidth', widthadj);
        hold on;
        plot(1:length(temp.b), temp.b, 'DisplayName', sprintf('βk, l = %.2f', lvalue(j)), 'LineWidth', widthadj);
        widthadj = widthadj + 1;
        fprintf("Number of objective function calls for f%d l=%g is %d\n", i, lvalue(j), temp.noc);
    end
    xlabel('k');
    ylabel('αk & βk');
    title(sprintf('αk & βk vs k, f%d', i));
    legend;
    hold off;
end
