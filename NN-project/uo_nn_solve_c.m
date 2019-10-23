function [Xtr,ytr,wo,tr_acc,Xte,yte,te_acc,tex] = uo_nn_solve_c(num_target, tr_freq,tr_seed,tr_p,te_seed,te_q, W)
tic
te_freq = 0;
[Xtr,ytr]=uo_nn_dataset(tr_seed,tr_p,num_target,tr_freq);
[Xte,yte]=uo_nn_dataset(te_seed,te_q,num_target,te_freq);

sig = @(X) 1./(1+exp(-X)); %activation function (sigmoid function)
y = @(X,w) sig(w'*sig(X)); %output signal --> returns a probability

te_acc = 0;
tr_acc = 0;
for j= 1:5
if (num_target(j) == 0)
    wo=W(:,10);
else
    wo = W(:,num_target(j));
end
%uo_nn_Xyplot(Xtr,ytr,wo);

%Train accuracy
y_calc = y(Xtr, wo);
sum_tr = 0;
for i = 1:tr_p
    sum_tr = sum_tr + (round(y_calc(i)) == ytr(i));
end
tr_acc_digit = double(sum_tr*100/ tr_p);
tr_acc = tr_acc + tr_acc_digit;
%Compute test accuracy
y_calc = y(Xte, wo);
sum_te = 0;
for i = 1:te_q
    sum_te = sum_te + (round(y_calc(i)) == yte(i));
end
te_acc_digit = double(sum_te*100/ te_q);
te_acc = te_acc + te_acc_digit;
end 
tr_acc = tr_acc/5;
te_acc = te_acc/5;
tex=toc;

end
