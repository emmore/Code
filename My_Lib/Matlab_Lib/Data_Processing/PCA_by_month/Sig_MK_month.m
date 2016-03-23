function Sig_MK_month(ptr,ttr)
ptr(ptr==0)=NaN;
ptr(abs(ptr)<=1.96)=0;
ptr(ptr>1.96)=1;
ptr(ptr<-1.96)=-1;
ttr(ttr==0)=NaN;
ttr(abs(ttr)<=1.96)=0;
ttr(ttr>1.96)=1;
ttr(ttr<-1.96)=-1;
for i=1:12
    surf(ptr(:,:,i));
    axis off;
    view([0,90]);
    grid off;
    str=sprintf('%d',i);
    saveas(gcf,[str '_p_sig' '.png']);
    
    surf(ttr(:,:,i)');
    axis off;
    view([0,90]);
    grid off;
    saveas(gcf,[str '_t_sig' '.png']);
end

 
