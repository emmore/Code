function [COEFF,SCORE,latent]=LPCA_p(p_result,norm)
%long series PCA without clarifing months.
p=[];
for i=1:length(p_result)
    d=p_result(i,:,:);
    d=d(d>=0);
    p=[p;d'];
end
if norm==1
    for i=1:size(p,2)
        p(:,i)=normalization_1(p(:,i));
    end
elseif norm==2
    for i=1:size(p,2)
        p(:,i)=normalization_2(p(:,i));
    end
end

[COEFF,SCORE,latent]=princomp(p);
%{
snr=cumsum(latent)./sum(latent);
x=1:50;
y=snr(1:50);
z=plot(x,y);
axis([1 50 0.75 1])
title('Information Contribution of Principle Vectors')
xlabel('Principle Vector Amounts') % x-axis label
ylabel('Signal Noise Ratio') % y-axis label
%}
end