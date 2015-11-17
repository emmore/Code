function [COEFF,SCORE,latent,tsquare]=PCA_p(p_result)
q=[];
for i=1:12
    pmonth=p_result(i:12:size(p_result,1),:,:);
    for j=1:size(pmonth,1)
        d=squeeze(pmonth(j,:,:));
        q=[q d(d>=0)];
    end
    [COEFF,SCORE,latent,tsquare]=princomp(q);       
end
