function [Xtr,ytr,wo,tr_acc,Xte,yte,te_acc,niter,tex] = uo_nn_solve(num_target, tr_freq,tr_seed,tr_p,te_seed,te_q,la,epsG,kmax,ils,ialmax,kmaxBLS,epsal,c1,c2,isd,icg,irc,nu,iheader)
tic
[Xtr,ytr]=uo_nn_dataset(tr_seed,tr_p,num_target,tr_freq);
[Xte,yte]=uo_nn_dataset(te_seed, te_p,num_target,te_freq);

sig = @(X) 1./(1+exp(-X)); %activation function (sigmoid function)
y = @(X,w) sig(w'*sig(X)); %output signal --> returns a probability
%Loss function with L2 regularization with parameter(la) and its gradient
L = @(w) norm(y(Xtr,w)-ytr)^2 + (la*norm(w)^2)/2;
gL = @(w) 2*sig(Xtr)*((y(Xtr,w)-ytr).*y(Xtr,w).*(1-y(Xtr,w)))'+la*w;

if isd == 1 %GM
    [wk,dk,alk,iWk]=uo_GM(w,f,g,eps,kmax,epsBLS,kmaxBLS,almax,c1,c2);  
%elseif isd == 2 %CGM-PR+

elseif isd == 3 %QM-BFGS
    [wK,dk,alk,Hk,iWk]=uo_QM_BFGS(w,f,g,eps,kmax,epsBLS,kmaxBLS,almax,c1,c2);
end
%Train Accuracy

%Test Accuracy

tex=toc;

end
