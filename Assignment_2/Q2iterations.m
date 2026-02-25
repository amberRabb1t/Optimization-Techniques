close all;
clear;
clc;

syms f(x,y);
f(x,y) = (x^3)*exp(-(x^2)-(y^4));
gradf = gradient(f);

qa1 = steepdsc(f, x, y, gradf, [0;0], 0.001, 1, 0.9);
qa2 = steepdsc(f, x, y, gradf, [-1;-1], 0.001, 1, 0.9);
qa3 = steepdsc(f, x, y, gradf, [1;1], 0.001, 1, 0.9);

qb1 = steepdsc(f, x, y, gradf, [0;0], 0.001, 2, 0.9);
qb2 = steepdsc(f, x, y, gradf, [-1;-1], 0.001, 2, 0.9);
qb3 = steepdsc(f, x, y, gradf, [1;1], 0.001, 2, 0.9);

qc1 = steepdsc(f, x, y, gradf, [0;0], 0.001, 3, 0.9);
qc2 = steepdsc(f, x, y, gradf, [-1;-1], 0.001, 3, 0.9);
qc3 = steepdsc(f, x, y, gradf, [1;1], 0.001, 3, 0.9);

figure(1);
plot(1:qa1.k, double(subs(f, {x,y}, {qa1.xv(1,:),qa1.xv(2,:)})), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'f(xk) vs k','Steepest Descent with (x0,y0)=(0,0) and γk=0.9 (constant)'});
xlabel('k (iterations)', FontWeight='bold');
ylabel('f(xk)', FontWeight='bold', Rotation=0);

figure(2);
plot(1:qa2.k, double(subs(f, {x,y}, {qa2.xv(1,:),qa2.xv(2,:)})), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'f(xk) vs k','Steepest Descent with (x0,y0)=(-1,-1) and γk=0.9 (constant)'});
xlabel('k (iterations)', FontWeight='bold');
ylabel('f(xk)', FontWeight='bold', Rotation=0);

figure(3);
plot(1:qa3.k, double(subs(f, {x,y}, {qa3.xv(1,:),qa3.xv(2,:)})), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'f(xk) vs k','Steepest Descent with (x0,y0)=(1,1) and γk=0.9 (constant)'});
xlabel('k (iterations)', FontWeight='bold');
ylabel('f(xk)', FontWeight='bold', Rotation=0);

figure(4);
plot(1:qb1.k, double(subs(f, {x,y}, {qb1.xv(1,:),qb1.xv(2,:)})), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'f(xk) vs k','Steepest Descent with (x0,y0)=(0,0) and γk that minimizes f(xk+γk*dk)'});
xlabel('k (iterations)', FontWeight='bold');
ylabel('f(xk)', FontWeight='bold', Rotation=0);

figure(5);
plot(1:qb2.k, double(subs(f, {x,y}, {qb2.xv(1,:),qb2.xv(2,:)})), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'f(xk) vs k','Steepest Descent with (x0,y0)=(-1,-1) and γk that minimizes f(xk+γk*dk)'});
xlabel('k (iterations)', FontWeight='bold');
ylabel('f(xk)', FontWeight='bold', Rotation=0);

figure(6);
plot(1:qb3.k, double(subs(f, {x,y}, {qb3.xv(1,:),qb3.xv(2,:)})), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'f(xk) vs k','Steepest Descent with (x0,y0)=(1,1) and γk that minimizes f(xk+γk*dk)'});
xlabel('k (iterations)', FontWeight='bold');
ylabel('f(xk)', FontWeight='bold', Rotation=0);

figure(7);
plot(1:qc1.k, double(subs(f, {x,y}, {qc1.xv(1,:),qc1.xv(2,:)})), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'f(xk) vs k','Steepest Descent with (x0,y0)=(0,0) and γk chosen by the Armijo rule'});
xlabel('k (iterations)', FontWeight='bold');
ylabel('f(xk)', FontWeight='bold', Rotation=0);

figure(8);
plot(1:qc2.k, double(subs(f, {x,y}, {qc2.xv(1,:),qc2.xv(2,:)})), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'f(xk) vs k','Steepest Descent with (x0,y0)=(-1,-1) and γk chosen by the Armijo rule'});
xlabel('k (iterations)', FontWeight='bold');
ylabel('f(xk)', FontWeight='bold', Rotation=0);

figure(9);
plot(1:qc3.k, double(subs(f, {x,y}, {qc3.xv(1,:),qc3.xv(2,:)})), LineStyle='--', Color='r', Marker='*', MarkerEdgeColor='b');
title({'f(xk) vs k','Steepest Descent with (x0,y0)=(1,1) and γk chosen by the Armijo rule'});
xlabel('k (iterations)', FontWeight='bold');
ylabel('f(xk)', FontWeight='bold', Rotation=0);

