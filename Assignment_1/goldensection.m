function data = goldensection(l, a, b, f, x)
    k = 1;
    gamma = 0.618;
    x1k = a(k) + (1-gamma)*(b(k)-a(k));
    x2k = a(k) + gamma*(b(k)-a(k));
    fx1k = subs(f, x, x1k);
    fx2k = subs(f, x, x2k);
    noc = 2;
    while b(k) - a(k) >= l
        if fx1k > fx2k
            a(k+1) = x1k;
            b(k+1) = b(k);
            x1k = x2k;
            x2k = a(k+1) + gamma*(b(k+1)-a(k+1));
            fx1k = fx2k;
            fx2k = subs(f, x, x2k);
        else
            a(k+1) = a(k);
            b(k+1) = x2k;
            x2k = x1k;
            x1k = a(k+1) + (1-gamma)*(b(k+1)-a(k+1));
            fx2k = fx1k;
            fx1k = subs(f, x, x1k);
        end
        k = k + 1;
        noc = noc + 1;
    end
    data.a = a;
    data.b = b;
    data.noc = noc;
end
