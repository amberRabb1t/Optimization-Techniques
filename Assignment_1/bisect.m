function data = bisect(e, l, a, b, f, x)
    k = 1;
    noc = 0;
    while b(k) - a(k) >= l
        x1k = (a(k) + b(k))/2 - e;
        x2k = (a(k) + b(k))/2 + e;
        if subs(f, x, x1k) < subs(f, x, x2k)
            a(k+1) = a(k);
            b(k+1) = x2k;
        else
            a(k+1) = x1k;
            b(k+1) = b(k);
        end
        k = k + 1;
        noc = noc + 2;
    end
    data.a = a;
    data.b = b;
    data.noc = noc;
end
