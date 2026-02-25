function data = steepdscproj(gradf, x1, x2, x, e, gamma, sk)
    k = 1;
    gfv = double(subs(gradf, {x1,x2}, {x(1,k),x(2,k)}));

    while norm(gfv) >= e
        xbar = x(:,k) - sk*gfv;

        if xbar(1) < -10
            xbar(1) = -10;
        elseif xbar(1) > 5
            xbar(1) = 5;
        end

        if xbar(2) < -8
            xbar(2) = -8;
        elseif xbar(2) > 12
            xbar(2) = 12;
        end

        x(:,k+1) = x(:,k) + gamma*(xbar - x(:,k));

        k = k + 1;
        if k > 1600
            break;
        end

        gfv = double(subs(gradf, {x1,x2}, {x(1,k),x(2,k)}));
    end

    data.x = x;
    data.k = k;
end

