function [X,y] = uo_nn_dataset(seed, ncol, target, freq)
%%
N = [
    0 0 1 0 0, 0 1 1 0 0, 0 0 1 0 0, 0 0 1 0 0, 0 0 1 0 0, 0 0 1 0 0, 0 1 1 1 0; % 1
    0 1 1 1 0, 1 0 0 0 1, 0 0 0 0 1, 0 0 0 1 0, 0 0 1 0 0, 0 1 0 0 0, 1 1 1 1 1; % 2
    0 1 1 1 0, 1 0 0 0 1, 0 0 0 0 1, 0 0 1 1 0, 0 0 0 0 1, 1 0 0 0 1, 0 1 1 1 0; % 3
    0 0 1 1 0, 0 1 0 1 0, 1 0 0 1 0, 1 0 0 1 0, 1 1 1 1 1, 0 0 0 1 0, 0 0 0 1 0; % 4
    1 1 1 1 1, 1 0 0 0 0, 1 1 1 1 0, 0 0 0 0 1, 0 0 0 0 1, 1 0 0 0 1, 0 1 1 1 0; % 5
    0 0 1 1 1, 0 1 0 0 0, 1 0 0 0 0, 1 1 1 1 0, 1 0 0 0 1, 1 0 0 0 1, 0 1 1 1 0; % 6
    1 1 1 1 1, 0 0 0 0 1, 0 0 0 0 1, 0 0 0 1 0, 0 0 1 0 0, 0 1 0 0 0, 1 0 0 0 0; % 7
    0 1 1 1 0, 1 0 0 0 1, 1 0 0 0 1, 0 1 1 1 0, 1 0 0 0 1, 1 0 0 0 1, 0 1 1 1 0; % 8
    0 1 1 1 0, 1 0 0 0 1, 1 0 0 0 1, 0 1 1 1 1, 0 0 0 0 1, 0 0 0 0 1, 0 1 1 1 0; % 9
    0 1 1 1 0, 1 0 0 0 1, 1 0 0 0 1, 1 0 0 0 1, 1 0 0 0 1, 1 0 0 0 1, 0 1 1 1 0; % 0
    ];
N = N';
%%
xval     = 10;
maxsigma = 1.;
minsigma = 0.25;
if xval > 0
    N = xval*((N-1)+N);
end
if ~isempty(seed) rng(seed); end;
nT = size(target,2);
nPixels = size(N,1);
%% Generation
for j=1:ncol
    if rand() < (freq-0.1*nT)/(1-0.1*nT)
        i = target(randi([1,nT]));
    else
        i = randi(10);
    end
    X(:,j) = N(:,i);
    if isempty(target)
        y(j) = i;
    else
        
        if any(i == target)
            y(j) = 1;
        else
            y(j) = 0;
        end
    end
end
%% Blur
for j=1:ncol
    l = zeros(1,nPixels);
    sigma = minsigma + (maxsigma-minsigma)*rand();
    for k = 1:nPixels
        ii = randi([1 nPixels]);
        while l(ii)==1
            ii = randi([1 nPixels]);
        end
        l(ii) = 1;
        if X(ii,j) > 0
            X(ii,j) =  xval + sigma*xval*randn();
        else
            X(ii,j) = -(xval + sigma*xval*randn());
        end
    end
end
end
