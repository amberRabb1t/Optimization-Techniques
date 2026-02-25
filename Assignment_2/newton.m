function data = newton(f, x, y, gradf, Hf, xv, e, stepstate, stepvalue)
    k = 1;

    if stepstate==1
        gamma = stepvalue;
        while 1
            gfv = double(subs(gradf, {x,y}, {xv(1,k),xv(2,k)}));
            if norm(gfv) < e
                break;
            end
            dk = -double(subs(Hf, {x,y}, {xv(1,k),xv(2,k)}))\gfv;
            xv(:,k+1) = xv(:,k) + gamma*dk;
            k = k + 1;
        end
    end

    if stepstate==2
        syms fm(t);
        while 1
            gfv = double(subs(gradf, {x,y}, {xv(1,k),xv(2,k)}));
            if norm(gfv) < e
                break;
            end
            dk = -double(subs(Hf, {x,y}, {xv(1,k),xv(2,k)}))\gfv;
            fm(t) = subs(f, {x,y}, {xv(1,k)+t*dk(1),xv(2,k)+t*dk(2)});
            gamma = bisectderiv(0.01, 0, 10, fm, t);
            xv(:,k+1) = xv(:,k) + gamma*dk;
            k = k + 1;
        end
    end
    
    if stepstate==3
        while 1
            gfv = double(subs(gradf, {x,y}, {xv(1,k),xv(2,k)}));
            if norm(gfv) < e
                break;
            end
            dk = -double(subs(Hf, {x,y}, {xv(1,k),xv(2,k)}))\gfv;
            gamma = armijorule(0.001, 0.3, 5.7, f, x, y, xv(:,k), dk, gfv);
            xv(:,k+1) = xv(:,k) + gamma*dk;
            k = k + 1;
            if norm(xv(:,k) - xv(:,k-1)) < 10^(-8)
                break;
            end
        end
    end
    
    data.xv = xv;
    data.k = k;
end

