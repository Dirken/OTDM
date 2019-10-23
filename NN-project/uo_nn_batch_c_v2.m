clear;
%
tr_freq     = .5;
tr_seed     = 48103345;
tr_p        = 250;
te_seed     = 39958013;
te_q        = tr_p;
% Parameters for optimization:
epsG = 10^-6; kmax = 5000;                                    % Stopping criterium:
ils=1; ialmax = 10 ; kmaxBLS=30; epsal=10^-3; c1=0.01; c2=0.45; % Linesearch:
icg = 2; irc = 2 ; nu = 1.0;                                  % Search direction:
%

%Best regularization parameter
la = 1.0;
%Best algorithm (BFGS)
isd = 3;

%Length digit series 
len = 5;

iheader = 1;
fileID = fopen('uo_nn_batch_c.csv','w');
for iter = 1:10
    rng('shuffle');
    num_target = randi([0, 9], 1, 5);
    [Xtr,ytr,wo,tr_acc,Xte,yte,te_acc,niter,tex]=uo_nn_solve_c(num_target, tr_freq,tr_seed,tr_p,te_seed,te_q,la,epsG,kmax,ils,ialmax,kmaxBLS,epsal,c1,c2,isd,icg,irc,nu,iheader);
    num_target = str2double(sprintf('%d',round(num_target)));
    if iheader == 1 fprintf(fileID,'num_target;   la; isd; niter;     tex; te_acc;\n'); end
    fprintf(fileID,'         %1i; %4.1f;   %1i;  %4i; %7.4f;  %5.1f;\n', num_target, la, isd, niter, tex, te_acc);
    iheader=0;
end
fclose(fileID);
