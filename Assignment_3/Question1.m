close all;
clear;
clc;

syms f(x1,x2);
f(x1,x2) = x1^2/3 + 3*x2^2;
gradf = gradient(f);

x0 = [1;1];
e = 0.001;
gk = [0.1 0.3 3 5];

for n=1:length(gk)
    q = steepdsc(gradf, x1, x2, x0, e, gk(n));

    figure;
    fcontour(f);
    hold on;
    plot(q.x(1,:), q.x(2,:), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
    title(sprintf('Convergence path\nSteepest Descent with x_0=(%g,%g), ε=%g and γ_k=%g (constant)', x0(1), x0(2), e, gk(n)), FontSize=15);
    xlabel('x_1', FontWeight='bold', FontSize=14);
    ylabel('x_2', FontWeight='bold', Rotation=0, FontSize=14);
    legend('f(x)', 'Iterations');

    figure;
    plot(1:q.k, double(subs(f, {x1,x2}, {q.x(1,:), q.x(2,:)})), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
    title(sprintf('f(x_k) vs k\nSteepest Descent with x_0=(%g,%g), ε=%g and γ_k=%g (constant)', x0(1), x0(2), e, gk(n)), FontSize=15);
    xlabel('k (number of iterations)', FontWeight='bold', FontSize=14);
    ylabel('f(x_k)', FontWeight='bold', Rotation=0, FontSize=14);
end

