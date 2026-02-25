close all;
clear;
clc;

syms f(x1,x2);
f(x1,x2) = x1^2/3 + 3*x2^2;
gradf = gradient(f);

x0 = [5;-5];
e = 0.01;
gk = 0.5;
sk = 5;

q = steepdscproj(gradf, x1, x2, x0, e, gk, sk);

figure;
fcontour(f);
hold on;
plot(q.x(1,:), q.x(2,:), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title(sprintf('Convergence path\nProjected Steepest Descent with x_0=(%g,%g), ε=%g, γ_k=%g and s_k=%g (constants)', x0(1), x0(2), e, gk, sk), FontSize=15);
xlabel('x_1', FontWeight='bold', FontSize=14);
ylabel('x_2', FontWeight='bold', Rotation=0, FontSize=14);
legend('f(x)', 'Iterations');

figure;
plot(1:q.k, double(subs(f, {x1,x2}, {q.x(1,:), q.x(2,:)})), LineStyle=':', Color='r', Marker='*', MarkerEdgeColor='b');
title(sprintf('f(x_k) vs k\nProjected Steepest Descent with x_0=(%g,%g), ε=%g, γ_k=%g and s_k=%g (constants)', x0(1), x0(2), e, gk, sk), FontSize=15);
xlabel('k (number of iterations)', FontWeight='bold', FontSize=14);
ylabel('f(x_k)', FontWeight='bold', Rotation=0, FontSize=14);

