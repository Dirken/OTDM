function [wk,dk,alk,Hk,iWk]=uo_QM_BFGS(w,f,g,eps,kmax,epsBLS,kmaxBLS,almax,c1,c2)

I = eye(length(w));
k = 1; %iteration indicator
wk = [w];
w_prev = 0; %value of previous w
dk  = [];
alk = [];
iWk = [];

while norm(g(w)) > eps && k < kmax
    
    %H equals the identity if we are at the first iteration
    if k == 1
        H = I;
    else %BFGS update formulae
        sk = w - w_prev;
        yk = g(w) - g(w_prev);
        pk = 1/(yk'*sk);
        H = (I - pk*sk*yk')*H*(I - pk*yk*sk') + pk*sk*sk';
    end
    d = -H*g(w);
    
    %If we are not in the first iteration, we need to update the value of
    %almax
    if k ~= 1
        almax = 2*(f(wk(:,k)) - f(wk(:,k-1)))/(g(wk(:,k))'*d);
    end
    %New BLS based on interpolations
    [al, iWout] = om_uo_BLSNW32(f, g, w, d, almax, c1, c2, kmaxBLS, epsBLS);
    
    %Update the variables
    w_prev = w;
    w = w + al*d;
    wk = [wk w];
    dk = [dk d];
    alk = [alk al];
    Hk = [Hk H];
    iWk = [iWk iWout];
    k = k + 1;
   
end

end