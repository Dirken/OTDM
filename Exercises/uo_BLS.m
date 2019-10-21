function [al,iWout] = uo_BLS(x, d, f, g, h, almax, almin, rho, c1, c2, iW)
    % iWout = 0. 
    % iWout = 1: Just WC1 
    al = almax;
    WC1 = @(a) f(x + a*d) <= (f(x) + c1*g(x)'*d*a);
    WC2 = @(a) g(x + a*d)'*d >= c2*g(x)'*d;
    
    SWC2 = @(a) abs(g(x + a*d)'*d) <= c2*abs(g(x)'*d);
    
    % Exact line search (quadratic f)
    if iW == 0
        al = -(g(x)'*d)/(d'*h(x)*d);
    else
        if iW == 1
            wolfeCondition = @(a) WC1(a) && WC2(a);
        elseif iW == 2
            wolfeCondition = @(a) WC1(a) && SWC2(a);
        end
    
        while ~wolfeCondition(al) && al > almin
            al = rho*al;
        end
    end
    
    if (WC1(al) && SWC2(al))
        iWout = 3;
    elseif (WC1(al) && WC2(al))
        iWout = 2;
    elseif (WC1(al))
        iWout = 1;
    else 
        iWout = 0;
    end
end