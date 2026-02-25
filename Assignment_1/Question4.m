close all;
clear;
clc;

syms x;
f(1) = 5^x + (2-cos(x))^2;
f(2) = (x-1)^2 + exp(x-5)*sin(x+3);
f(3) = exp(-3*x) - (sin(x-2)-2)^2;

a = -1;
b = 3;

lmax = 0.5;
lvec = 0.01:(lmax-0.01)/99:lmax;

v = zeros(3,100);

for i=1:3
    for j=1:length(lvec)
        temp = bisectderiv(lvec(j), a, b, f(i), x);
        v(i,j) = temp.noc;
    end
end

for i=1:3
    figure(i);
    plot(lvec, v(i,:));
    xlabel('l');
    ylabel('Number of objective function calls');
    title(sprintf('variable l, Objective function f%d', i));
end

lvalue = [0.01 0.3 0.5 0.8];

for i=1:3
    widthadj = 0.5;
    figure(i+3);
    for j=1:length(lvalue)
        temp = bisectderiv(lvalue(j), a, b, f(i), x);
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
