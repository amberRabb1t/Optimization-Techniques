function step = armijorule(a, b, s, f, x, y, xvec, dk, gfv)
    fxk = double(subs(f, {x,y}, {xvec(1),xvec(2)}));

    m = 0;

    while 1
        gamma = s*b^m;
        xvec(:,2) = xvec(:,1) + gamma*dk;
        if fxk - double(subs(f, {x,y}, {xvec(1,2),xvec(2,2)})) >= -a*gamma*dk'*gfv
            break
        end
        m = m + 1;
    end

    step = gamma;
end
