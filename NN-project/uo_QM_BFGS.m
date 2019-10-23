function [wk,niter]=uo_QM_BFGS(w,f,g,epsG,kmax,epsal,kmaxBLS,almax,c1,c2)

I = eye(length(w));
k = 1; %iterator
wk = [w];
w_prev = -1; %value of previous w

while norm(g(w)) > epsG && k < kmax 
    
    if k == 1
        H = I;
    else 
        sk = w - w_prev;
        yk = g(w) - g(w_prev);
        pk = 1/(yk'*sk);
        H = (I - pk*sk*yk')*H*(I - pk*yk*sk') + pk*sk*sk';
    end
    d = -H*g(w);
    if k ~= 1
        almax = 2*(f(wk(:,k)) - f(wk(:,k-1)))/(g(wk(:,k))'*d);
    end
    [al, ~] = uo_BLSNW32(f, g, w, d, almax, c1, c2, kmaxBLS, epsal);
    
    %Update variables
    w_prev = w;
    w = w + al*d;
    wk = [wk w];
    k = k + 1;
   
end
niter=k;
end