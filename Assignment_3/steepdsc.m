function data = steepdsc(gradf, x1, x2, x, e, gamma)
    k = 1;
    gfv = double(subs(gradf, {x1,x2}, {x(1,k),x(2,k)}));

    while norm(gfv) >= e
        x(:,k+1) = x(:,k) - gamma*gfv;
        k = k + 1;
        gfv = double(subs(gradf, {x1,x2}, {x(1,k),x(2,k)}));
    end

    data.x = x;
    data.k = k;
end

