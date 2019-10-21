function [wk,dk,alk,iWk]=uo_GM(w,f,g,eps,kmax,epsBLS,kmaxBLS,almax,c1,c2)
k = 1; %iteration indicator
wk = [w];
dk = [];
alk = [];
iWk = [];

while norm(g(w)) > eps && k < kmax
   %Descent direction: negative gradient
   d = -g(w);  
   %If we are not in the first iteration, we need to update the value of
   %almax
   if k ~= 1
       almax = 2*(f(wk(:,k)) - f(wk(:,k-1)))/(g(wk(:,k))'*d);
   end
   %New BLS based on interpolations
   [al, iWout] = om_uo_BLSNW32(f, g, w, d, almax, c1, c2, kmaxBLS, epsBLS); 
   
   %Update the variables
   w = w + al*d;
   wk = [wk w];
   dk = [dk d];
   alk = [alk al];
   iWk = [iWk iWout];
   k = k + 1;
end

end