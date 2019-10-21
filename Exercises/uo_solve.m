function [xk,dk,alk,iWk,Hk]= uo_solve(x,f,g,h,eps,kmax,almax,almin,rho,c1,c2,iW,isd)
    xk = []; dk = []; alk = []; iWk = []; Hk = [];
    k = 0;
    I = eye(length(x));
    H = I;
    while (norm(g(x)) > eps && k <= kmax)
        if (isd == 1)
            d = -g(x);
        elseif (isd == 3)
            d = -H*g(x);
        else
            fprintf('Invalid code');
            break;
        end
        [al, iWout] = uo_BLS(x, d, f, g, h, almax, almin, rho, c1, c2, iW);
        x1 = x + al*d;
        s = x1 - x;
        y = g(x1)-g(x);
        p = 1/(y'*s);
        P = I-p*s*y';
        H = P*H*P+p*(s*s');
        k = k +1;
        x = x1;
        xk = [xk, x];
        dk = [dk, d];
        alk = [alk, al];
        iWk = [iWk, iWout];
        Hk = [Hk, H];
    end
end


