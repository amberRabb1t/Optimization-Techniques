close all;
clear;
clc;

syms f(x,y);
f(x,y) = (x^3)*exp(-(x^2)-(y^4));
gradf = gradient(f);
Hf = hessian(f);

qa1 = newton(f, x, y, gradf, Hf, [0;0], 0.001, 1, 0.9);
qa2 = newton(f, x, y, gradf, Hf, [-1;-1], 0.001, 1, 0.9);
qa3 = newton(f, x, y, gradf, Hf, [1;1], 0.001, 1, 0.9);

qb1 = newton(f, x, y, gradf, Hf, [0;0], 0.001, 2, 0.9);
qb2 = newton(f, x, y, gradf, Hf, [-1;-1], 0.001, 2, 0.9);
qb3 = newton(f, x, y, gradf, Hf, [1;1], 0.001, 2, 0.9);

qc1 = newton(f, x, y, gradf, Hf, [0;0], 0.001, 3, 0.9);
qc2 = newton(f, x, y, gradf, Hf, [-1;-1], 0.001, 3, 0.9);
qc3 = newton(f, x, y, gradf, Hf, [1;1], 0.001, 3, 0.9);

figure(1);
fcontour(f);
hold on;
plot(qa1.xv(1,:), qa1.xv(2,:), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'Convergence path','Newton with (x0,y0)=(0,0) and γk=0.9 (constant)'});
xlabel('x', FontWeight='bold');
ylabel('y', FontWeight='bold', Rotation=0);

figure(2);
fcontour(f);
hold on;
plot(qa2.xv(1,:), qa2.xv(2,:), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'Convergence path','Newton with (x0,y0)=(-1,-1) and γk=0.9 (constant)'});
xlabel('x', FontWeight='bold');
ylabel('y', FontWeight='bold', Rotation=0);

figure(3);
fcontour(f);
hold on;
plot(qa3.xv(1,:), qa3.xv(2,:), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'Convergence path','Newton with (x0,y0)=(1,1) and γk=0.9 (constant)'});
xlabel('x', FontWeight='bold');
ylabel('y', FontWeight='bold', Rotation=0);

figure(4);
fcontour(f);
hold on;
plot(qb1.xv(1,:), qb1.xv(2,:), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'Convergence path','Newton with (x0,y0)=(0,0) and γk that minimizes f(xk+γk*dk)'});
xlabel('x', FontWeight='bold');
ylabel('y', FontWeight='bold', Rotation=0);

figure(5);
fcontour(f);
hold on;
plot(qb2.xv(1,:), qb2.xv(2,:), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'Convergence path','Newton with (x0,y0)=(-1,-1) and γk that minimizes f(xk+γk*dk)'});
xlabel('x', FontWeight='bold');
ylabel('y', FontWeight='bold', Rotation=0);

figure(6);
fcontour(f);
hold on;
plot(qb3.xv(1,:), qb3.xv(2,:), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'Convergence path','Newton with (x0,y0)=(1,1) and γk that minimizes f(xk+γk*dk)'});
xlabel('x', FontWeight='bold');
ylabel('y', FontWeight='bold', Rotation=0);

figure(7);
fcontour(f);
hold on;
plot(qc1.xv(1,:), qc1.xv(2,:), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'Convergence path','Newton with (x0,y0)=(0,0) and γk chosen by the Armijo rule'});
xlabel('x', FontWeight='bold');
ylabel('y', FontWeight='bold', Rotation=0);

figure(8);
fcontour(f);
hold on;
plot(qc2.xv(1,:), qc2.xv(2,:), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'Convergence path','Newton with (x0,y0)=(-1,-1) and γk chosen by the Armijo rule'});
xlabel('x', FontWeight='bold');
ylabel('y', FontWeight='bold', Rotation=0);

figure(9);
fcontour(f);
hold on;
plot(qc3.xv(1,:), qc3.xv(2,:), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'Convergence path','Newton with (x0,y0)=(1,1) and γk chosen by the Armijo rule'});
xlabel('x', FontWeight='bold');
ylabel('y', FontWeight='bold', Rotation=0);

