function [z,p_approx,COEFF,SCORE]=PCA_p(p_result)
p_approx=p_result;

for i=1:12
    pmonth_real=[];
    pmonth=p_result(i:12:size(p_result,1),:,:);
    for j=1:size(pmonth,1)
        d=squeeze(pmonth(j,:,:));
        pmonth_real=[pmonth_real d(d>=0)];
    end
    pmonth_real=pmonth_real';
    pmean=mean(pmonth_real);
    [COEFF,SCORE,latent]=princomp(pmonth_real);
    snr=cumsum(latent)./sum(latent);
    x=1:50;
    y=snr(1:50);
    z=plot(x,y);
    axis([1 50 0 1])
    text(double(x(i*2)),double(y(i*2)),int2str(i));
    title('Information Contribution of Principle Vectors')
    xlabel('Principle Vector Amounts') % x-axis label
    ylabel('Signal Noise Ratio') % y-axis label
 
    hold all;
 
    j=1;
    while snr(j)<0.99
       qapprox=bsxfun(@plus,pmean,SCORE(:,1:j)*COEFF(:,1:j)'); 
       qapprox_remap=zeros(size(p_result,2),size(p_result,3));
       qreal_remap=zeros(size(p_result,2),size(p_result,3));
       for year=1:size(pmonth,1)
           num=0;
           for longitude=1:size(p_result,3)
               for latitude=1:size(p_result,2)
                   qreal_remap(latitude,longitude)=p_result(i+(year-1)*12,latitude,longitude);
                   if  p_result(1,latitude,longitude)>=0
                        num=num+1;
                        qapprox_remap(latitude,longitude)=qapprox(year,num); 
                        p_approx(i+(year-1)*12,latitude,longitude)=qapprox(year,num); 
                   else
                        p_approx(i+(year-1)*12,latitude,longitude)=NaN;
                        qapprox_remap(latitude,longitude)=NaN;
                   end
               end
           end
       end
%{
       surf(qapprox_remap);
       axis off;
       view([0,90]);
       grid off;
       str=sprintf('%d Month Precipitation \n %d Principles %f SNR ',i,j,snr(j));
       title(str);
       str2=sprintf('p_%d_%d',i,j);
       saveas(gcf,[str2 '.png']);  
%}
       j=j+1;
    end
end
end
