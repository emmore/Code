function [COEFF,SCORE,latent,tsquare]=PCA_p(p_result)
q=[];
p_amount=3; %select 3 principles.
for i=1:12
    pmonth=p_result(i:12:size(p_result,1),:,:);
    for j=1:size(pmonth,1)
        d=squeeze(pmonth(j,:,:));
        q=[q d(d>=0)];
    end
    qmean=mean(q);
%   qres=bsxfun(@minus,q,qmean);
    [COEFF,SCORE,latent,tsquare]=princomp(q);
    snr_s=cumsum(latent)./sum(latent);
    SNR=snr_s(p_amount);
    qapprox=bsxfun(@plus,qmean,SCORE(:,1:p_amount)*COEFF(:,1:p_amount)');
    
end
