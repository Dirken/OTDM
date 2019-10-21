clear;
% Problem
f = @(x) x(1)^2 + x(2)^3 + 3*x(1)*x(2); 
g = @(x) [ 2*x(1)+3*x(2) ; 3*x(2)^2 + 3*x(1)]; 
h = @(x) [ 2, 3; 3, 6*x(2)];
x = [-3;-1];

% Input parameters.
eps = 10^-6; kmax = 1500; % Stopping criterium:
almax = 2; almin = 10^-3; rho=0.5;c1=0.01;c2=0.45; iW = 0; % Linesearch:
isd = 3; icg = 2; irc = 0 ; nu = 0.1; % Search direction:

% Optimization
[xk,dk,alk,iWk,Hk] = uo_solve(x,f,g,h,eps,kmax,almax,almin,rho,c1,c2,iW,isd);

niter = size(xk,2); xo = xk(:,niter);
fk = []; gk = []; rk = []; gdk = [];
for k = 1:niter     fk = [fk,f(xk(:,k))]; gk=[gk,g(xk(:,k))]; end % f(xk) and g(xk)
for k = 1:niter-1   rk = [rk,(fk(k+1)-f(xo))/(fk(k)-f(xo))]; end % Rate of convergence
for k = 1:niter-1   gdk = [gdk,gk(:,k)'*dk(:,k)]; end % Descent condition
rk=[rk,NaN]; gdk = [gdk,0];
fprintf('[uo_FDM_CE21]\n');
fprintf('   eps=%3.1e, kmax= %4d\n', eps, kmax');
fprintf('   almax= %2d, almin= %3.1e, rho= %4.2f\n', almax, almin, rho);
fprintf('   c1 = %3.2f, c2= %3.2f, iW= %1d\n', c1, c2, iW);
fprintf('   isd= %1d\n', isd);
fprintf('   k x(1) x(2) iW g''*d ||g|| r\n');
for k = 1:niter
    fprintf('%5d %7.4f %7.4f %3d %+3.1e %4.2e %3.1e\n', k, xk(1,k), xk(2,k), iWk(k), gdk(k), norm(gk(:,k)), rk(k));
end
fprintf(' k x(1) x(2) iW g''*d ||g|| r\n[uo_FDM_CE21]\n');
xylim=[0 0 0 0];
subplot(2,1,1); uo_solve_plot(f, xk, gk, xylim, 1, 0); subplot(2,1,2); uo_solve_plot(f, xk, gk, xylim, 2, 0);