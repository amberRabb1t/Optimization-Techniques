function min = bisectderiv(l, a, b, f, x)
    fderiv = diff(f);

    k = 1;
    n = 0;
    
    while (1/2)^n > l/(b(k)-a(k))
        n = n + 1;
    end

    while 1
        xk = (a(k)+b(k))/2;
        if subs(fderiv, x, xk) == 0
            break;
        elseif subs(fderiv, x, xk) > 0
            a(k+1) = a(k);
            b(k+1) = xk;
            if k == n
                break;
            else
                k = k + 1;
            end
        else
            a(k+1) = xk;
            b(k+1) = b(k);
            if k == n
                break;
            else
                k = k + 1;
            end
        end
    end
    min = xk;
end
