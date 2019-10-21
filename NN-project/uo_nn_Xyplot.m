function uo_nn_Xyplot(Xds,yds,wo)
cla;hold off;
sig = @(X)          1./(1+exp(-X));
y   = @(X,w)        sig(w'*sig(X));
acc = @(Xds,yds,wo) 100*sum(yds==round(y(Xds,wo)))/size(Xds,2);
num = zeros(7,5);
%
iwo=1; if size(wo,1)==0, wo=zeros(35,1); iwo=0; end
%
posi = 1;
posf = size(Xds,2);
iplot = 0;
%
% iplot : = 0 -> plot every position
%       : = 1 -> plot only wrong recognitions.
if iplot == 0
    n=posf-posi+1;
    sp_r = round(sqrt(2*n/5));
    sp_c = ceil((posf-posi+1)/sp_r);
    range = posi:posf;
else
    range =[];
    for i=posi:posf
        if round(y(Xds(:,i),wo)) ~= yds(i)
            range =[range,i];
        end
        n=size(range,2);
        sp_r = 1;
        sp_c = n;
    end
end
im = zeros(1,n);
isp = 0;
for i=range
    if iplot== 0 || (iplot == 1 && round(y(Xds(:,i),wo)) ~= yds(i))
        for j=1:7
            num(j,1:5)=Xds((j-1)*5+1:(j-1)*5+5,i);
        end
        isp = isp+1;
        im(i)=subplot(sp_r,sp_c,isp);
        imagesc(num);  set(gca,'YTicklabel',[],'XTicklabel',[]);
        title(num2str(i),'FontSize',12);
        if ~iwo
            colormap(gray)
        else
            if round(y(Xds(:,i),wo)) == yds(i)
                if yds(i)==1
                    colormap(im(i),summer);
                else
                    colormap(im(i),winter);
                end
            else
                if yds(i)==1
                    colormap(im(i),autumn);
                else
                    colormap(im(i),spring);
                end
            end
        end
    end
end
end
