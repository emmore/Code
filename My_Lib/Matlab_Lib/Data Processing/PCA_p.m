function [COEFF,SCORE,latent,tsquare]=PCA_p(p_result)
p_approx=p_result;
pmonth_real=[];
%p_amount=3; %select 3 principles.
for i=1:12
    pmonth=p_result(i:12:size(p_result,1),:,:);
    for j=1:size(pmonth,1)
        d=squeeze(pmonth(j,:,:));
        pmonth_real=[pmonth_real d(d>=0)];
    end
    pmonth_real=pmonth_real';
    pmean=mean(pmonth_real);
%   qres=bsxfun(@minus,q,qmean);
    [COEFF,SCORE,latent,tsquare]=princomp(pmonth_real);
    snr=cumsum(latent)./sum(latent);
%   SNR=snr_s(p_amount);
%   qapprox=bsxfun(@plus,qmean,SCORE(:,1:p_amount)*COEFF(:,1:p_amount)');
    j=1;
    while snr(j)<0.99
       qapprox=bsxfun(@plus,pmean,SCORE(:,1:j)*COEFF(:,1:j)');
       num=1;
       for year=1:size(pmonth,1)
           for longitude=1:size(p_result,3)
               for latitude=1:size(p_result,2)
                   if isreal(pmonth(1,latitude,longitude))
                        p_approx(i+(year-1)*12,latitude,longitude)=qapprox(year,num);
                        num=num+1;
                   else
                        p_approx(i+(year-1)*12,latitude,longitude)=NaN;
                   end
               end
           end
       end
       j=j+1;
    end
end
end
