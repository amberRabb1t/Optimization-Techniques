function data = fibonac(e, l, a, b, f, x)
    k = 1;
    n = 0;

    while fibonacci(n+1) <= (b(k) - a(k))/l
        n = n+1;
    end
    
    x1k = a(k) + (fibonacci(n-1)/fibonacci(n+1))*(b(k)-a(k));
    x2k = a(k) + (fibonacci(n)/fibonacci(n+1))*(b(k)-a(k));
    fx1k = subs(f, x, x1k);
    fx2k = subs(f, x, x2k);
    noc = 2;
    while 1
        if fx1k > fx2k
            a(k+1) = x1k;
            b(k+1) = b(k);
            x1k = x2k;
            x2k = a(k+1) + (fibonacci(n-k)/fibonacci(n-k+1))*(b(k+1)-a(k+1));
            if k == n-2
                x2k = x1k + e;
                if fx2k > subs(f, x, x2k)
                    a(n) = x1k;
                    b(n) = b(n-1);
                else
                    a(n) = a(n-1);
                    b(n) = x2k;
                end
                noc = noc + 1;
                break;
            else
                fx1k = fx2k;
                fx2k = subs(f, x, x2k);
                k = k + 1;
            end
        else
            a(k+1) = a(k);
            b(k+1) = x2k;
            x2k = x1k;
            x1k = a(k+1) + (fibonacci(n-k-1)/fibonacci(n-k+1))*(b(k+1)-a(k+1));
            if k == n-2
                x2k = x1k + e;
                if subs(f, x, x1k) > fx1k
                    a(n) = x1k;
                    b(n) = b(n-1);
                else
                    a(n) = a(n-1);
                    b(n) = x2k;
                end
                noc = noc + 1;
                break;
            else
                fx2k = fx1k;
                fx1k = subs(f, x, x1k);
                k = k + 1;
            end
        end
        noc = noc + 1;
    end
    data.a = a;
    data.b = b;
    data.noc = noc;
end
