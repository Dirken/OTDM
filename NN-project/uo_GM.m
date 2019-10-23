function [wk,niter]=uo_GM(w,f,g,epsG,kmax,epsal,kmaxBLS,almax,c1,c2)
k=1; %iterator
wk=[w];
w_prev = -1;
while norm(g(w)) > epsG && k < kmax 
   d = -g(w);  
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