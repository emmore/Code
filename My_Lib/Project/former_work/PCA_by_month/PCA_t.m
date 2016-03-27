function [z,t_approx,coeff,score,nth_vector]=PCA_t(t_result,n)
t_approx=t_result;
nth_vector=zeros(size(t_result,1),size(t_result,2),size(t_result,3));
for i=1:12
    tmonth_real=[];
    tmonth=t_result(:,:,i:12:size(t_result,3));
    for j=1:size(tmonth,3)
        d=squeeze(tmonth(:,:,j));
        tmonth_real=[tmonth_real d(d>=-1000)];
    end
    tmonth_real=tmonth_real';
    pmean=mean(tmonth_real);
    [COEFF,SCORE,latent]=princomp(tmonth_real);
    coeff(i,:,:)=COEFF;
    score(i,:,:)=SCORE;
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
%    while snr(j)<0.99
    while j<2
       qapprox=bsxfun(@plus,pmean,SCORE(:,1:j)*COEFF(:,1:j)');  
       nq=SCORE(:,n)*(COEFF(:,n)');
%      qapprox_remap=zeros(size(t_result,2),size(t_result,3));
       qreal_remap=zeros(size(t_result,2),size(t_result,3));
       for year=1:size(tmonth,3)
           num=0;
           for mm=1:size(t_result,1)
               for nn=1:size(t_result,2)
                   qreal_remap(mm,nn)=t_result(mm,nn,i+(year-1)*12);
                   if  t_result(mm,nn,1)>=-1000
                        num=num+1;
                        nth_vector(mm,nn,i+(year-1)*12)=nq(year,num); 
                        t_approx(mm,nn,i+(year-1)*12)=qapprox(year,num); 
                   else
                        t_approx(mm,nn,i+(year-1)*12)=NaN;
                        nth_vector(mm,nn,i+(year-1)*12)=NaN;
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
hold off;
end
