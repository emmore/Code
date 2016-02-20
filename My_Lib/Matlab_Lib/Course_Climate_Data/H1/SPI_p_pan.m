function Z=SPI_p_pan(Data,scale)
clc;
%Data=load('precip.txt'); % Data : Monthly Data vector (not a matrix)
nseas=12/scale; % nseas : number of season (for monthly data nseas=12)
erase_yr=ceil(scale/12);
% Data setting to scaled dataset
A1=[];
for is=1:scale, A1=[A1,Data(is:length(Data)-scale+is)];end
XS=sum(A1,2);

if(scale>1), XS(1:nseas*erase_yr-scale+1)=[];   end

for is=1:nseas
    tind=is:nseas:length(XS);
    Xn=XS(tind);
    [zeroa]=find(Xn==0);
    Xn_nozero=Xn;Xn_nozero(zeroa)=[];
    q=length(zeroa)/length(Xn);
    parm=gamfit(Xn_nozero);
    Gam_xs=q+(1-q)*gamcdf(Xn,parm(1),parm(2));
    AAA = unifcdf(Gam_xs,-0.0001,1.0001);
    Z(tind) = norminv(AAA);
end
Z=Z';
%{
plot(Z,'DisplayName','Z','YDataSource','Z','linewidth',2);figure(gcf)
ylim([-4 4])
hline = refline([0 0]);
set(hline,'Color','k')
xlabel([int2str(scale) ' Month'])
ylabel('SPI')
%}
