close all;
clear;
clc;

syms f(x,y);
f(x,y) = (x^3)*exp(-(x^2)-(y^4));

[X, Y] = meshgrid(-4:0.05:4, -4:0.05:4);

Z = double(subs(f, {x,y}, {X,Y}));
 
surf(X,Y,Z);
title('f(x,y)', FontSize=14);
xlabel('x', FontSize=15, FontWeight='bold');
ylabel('y', FontSize=15, FontWeight='bold');
zlabel('z', FontSize=15, FontWeight='bold', Rotation=0);

figure(2);
fcontour(f);
hold on;
plot(-1.224, 0, Marker='*', MarkerEdgeColor='r');
title('f(x,y) - Contour plot', FontSize=14);
xlabel('x', FontSize=15, FontWeight='bold');
ylabel('y', FontSize=15, FontWeight='bold', Rotation=0);

