function [Xtr,ytr,wo,tr_acc,Xte,yte,te_acc,niter,tex] = uo_nn_solve(num_target, tr_freq,tr_seed,tr_p,te_seed,te_q,la,epsG,kmax,ils,ialmax,kmaxBLS,epsal,c1,c2,isd,icg,irc,nu,iheader)
tic
te_freq = 0;
[Xtr,ytr]=uo_nn_dataset(tr_seed,tr_p,num_target,tr_freq);
[Xte,yte]=uo_nn_dataset(te_seed,te_q,num_target,te_freq);
w=zeros(35,1);

sig = @(X) 1./(1+exp(-X)); %activation function (sigmoid function)
y = @(X,w) sig(w'*sig(X)); %output signal --> returns a probability
%Loss function with L2 regularization with parameter(la) and its gradient
L = @(w) norm(y(Xtr,w)-ytr)^2 + (la*norm(w)^2)/2;
gL = @(w) 2*sig(Xtr)*((y(Xtr,w)-ytr).*y(Xtr,w).*(1-y(Xtr,w)))'+la*w;

if isd == 1 %GM
    [wk,niter]=uo_GM(w,L,gL,epsG,kmax,epsal,kmaxBLS,ialmax,c1,c2);  
%elseif isd == 2 %CGM-PR+

elseif isd == 3 %QM-BFGS
    [wk,niter]=uo_QM_BFGS(w,L,gL,epsG,kmax,epsal,kmaxBLS,ialmax,c1,c2);
end
kmaxO = size(wk,2);
wo = wk(:,kmaxO);
%uo_nn_Xyplot(Xtr,ytr,wo);

%Train accuracy
y_calc = y(Xtr, wo);
sum_tr = 0;
for i = 1:tr_p
    sum_tr = sum_tr + (round(y_calc(i)) == ytr(i));
end
tr_acc = double(sum_tr*100/ tr_p);

%Compute test accuracy
if num_target == 9 && la == 1.0 && isd == 3
    uo_nn_Xyplot(Xte,yte,wo);
end
y_calc = y(Xte, wo);
sum_te = 0;
for i = 1:te_q
    sum_te = sum_te + (round(y_calc(i)) == yte(i));
end
te_acc = double(sum_te*100/ te_q);
tex=toc;

end
