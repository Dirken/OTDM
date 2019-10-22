clear;
%
tr_freq     = .5;
tr_seed     = 48103345;
tr_p        = 250;
te_seed     = 39958013;
te_q        = tr_p;
% Parameters for optimization:
epsG = 10^-6; kmax = 5000;                                    % Stopping criterium:
ils=1; ialmax = 2; kmaxBLS=30; epsal=10^-3; c1=0.01; c2=0.45; % Linesearch:
icg = 2; irc = 2 ; nu = 1.0;                                  % Search direction:
%
iheader = 1;
fileID = fopen('uo_nn_batch.csv','w');
for num_target = 1:10
    for la = [0.0, 1.0, 10.0]
        for isd = [1 3]
            [Xtr,ytr,wo,tr_acc,Xte,yte,te_acc,niter,tex]=uo_nn_solve(num_target, tr_freq,tr_seed,tr_p,te_seed,te_q,la,epsG,kmax,ils,ialmax,kmaxBLS,epsal,c1,c2,isd,icg,irc,nu,iheader);
            if iheader == 1 fprintf(fileID,'num_target;   la; isd; niter;     tex; te_acc;\n'); end
            fprintf(fileID,'         %1i; %4.1f;   %1i;  %4i; %7.4f;  %5.1f;\n', mod(num_target,10), la, isd, niter, tex, te_acc);
            iheader=0;
        end
    end
end
fclose(fileID);
