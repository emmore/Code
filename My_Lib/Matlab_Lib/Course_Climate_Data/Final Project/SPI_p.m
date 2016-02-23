function Z=SPI_p(Data,scale)
nseas=12/scale; 
for is=1:nseas
    tind=is:nseas:length(Data);
    Xn=Data(tind);
    [zeroa]=find(Xn==0);
    Xn_nozero=Xn;
    Xn_nozero(zeroa)=[];
    q=length(zeroa)/length(Xn);
    parm=gamfit(Xn_nozero);
    Gam_Data=q+(1-q)*gamcdf(Xn,parm(1),parm(2));
    AAA = unifcdf(Gam_Data,-0.0001,1.0001);
    Z(tind) = norminv(AAA);
end
Z=Z';

