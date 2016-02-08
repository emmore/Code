function EmpCopMSDI

% This code computes the the Standardized Precipitation Index (SPI), 
% Standardized Soil Moisture Index (SSI), and Multivariate Standardized Drought Index (MSDI)
% empirically (MSDIe) and parametrically (MSDIp). 
%
% "td.txt" includes sample monthly precipitation and soil moisture data (>=30 years,vector).
%
% Ref Reference Publications:
% MSDIp:  Hao Z., AghaKouchak A., 2013, Multivariate Standardized Drought Index: A Parametric Multi-Index Model, Advances in Water Resources, 57, 12-18, doi: 10.1016/j.advwatres.2013.03.009.
% MSDIe   Hao Z., AghaKouchak A., 2014, A Nonparametric Multivariate Multi-Index Drought Monitoring Framework, Journal of Hydrometeorology, 15, 89-101, doi:10.1175/JHM-D-12-0160.1. 

% Developed by: Hydroclimate Research Group, University of Califnornia, Irvine
% Web:  http://drought.eng.uci.edu/msdi.html
% Last update:  8/24/2013


%% Compute SPI, SSI, MSDIe (nonparametric MSDI) and MSDIp (parametric MSDI) with monthly Precipitation and and Soil moisture data (ds.txt).

clc;clear all;close all;

%Load Precipitation and Soil Moisture Data
d=load('td.txt');

% Monthly precipitation vector (mm/day, mm/month, in/day, in/month)
dp=d(:,1);

%Monthly soil moisture vector 
ds=d(:,2);

%(1) Uncomment the below part to test the code using synthetic data
%  mu = [4 8]; Sigma = [.9 .4; .4 .3];
%  d = mvnrnd(mu, Sigma, 396);
%  figure(2);plot(d(:,1),d(:,2),'.');
%  dp=d(:,1);ds=d(:,2);

nm=length(dp);

% Specify the time scale (e.g., 6-month SPI or MSDI)

sc=6;

% Initialize matrices of drought indices

SPI=zeros(nm,1);SSI=zeros(nm,1);MSDIe=zeros(nm,1);MSDIp=zeros(nm,1);

% Compute the empirical SPI and SSI

SPI(1:sc-1,1)=nan;
SPI(sc:end,1)=SPIComp(dp,sc);

SSI(1:sc-1,1)=nan;
SSI(sc:end,1)=SPIComp(ds,sc);

% Compute the empirical MSDI

MSDIe(1:sc-1,1)=nan;
MSDIe(sc:end,1)=Dat2EmpMSDI(dp,ds,sc);

% Compute the parametric copula-based MSDI (change the copula family if needed)

MSDIp(1:sc-1,1)=nan;
MSDIp(sc:end,1)=Dat2CopMSDI(dp,ds,sc,'Frank');

% Plot the figure for the four indices

figure(1)

plot(1:nm,SPI,'g','LineWidth',2);
hold on;plot(1:nm,SSI,'b','LineWidth',2)
hold on;plot(1:nm,MSDIe,'r-.','LineWidth',2)
hold on;plot(1:nm,MSDIp,'k-.','LineWidth',2)

legend('SPI','SSI','MSDIe','MSDIp','Orientation','horizontal')
%MSDIe is based on Hao Z., AghaKouchak A., 2013, A Nonparametric Multivariate Multi-Index Drought Monitoring Framework, Journal of Hydrometeorology, in press.
%MSDIp is based on Hao Z., AghaKouchak A., 2013, Multivariate Standardized Drought Index: A Parametric Multi-Index Model, Advances in Water Resources, 57, 12-18, doi: 10.1016/j.advwatres.2013.03.009.

xk=[1980:2:2012];n=length(xk);

for i=1:n xt(i)=(xk(i)-1980).*12+1; end  % Get the position for the label
for i=1:n xl{i}=num2str(xk(i)); end  % Get the label for each year

set(gca,'xtick',xt,'xticklabel',xl);
hold on;plot(1:nm,-0.8.*ones(nm,1),'r') % Threshold -0.8
xlabel('Year');ylabel('Index');xlim([250 397])


function SI=SPIComp(md,sc)

% (1) Get the accumulated prep. and soil moisture data for the specific time scale
% (2)Compute the empirical (or parametric) drought index (SPI and SSI) from the data

% Get the accumulated data for the time scale sc

A1=[];

for i=1:sc
    A1=[A1,md(i:length(md)-sc+i)];
end

Y=sum(A1,2);

% Compute the SPI or SSI

n=length(Y);SI=zeros(n,1);

for k=1:12
    d=Y(k:12:n);
    
    % Parametric method
    
    %  [par,pc] = gamfit(d(d~=0));
    %  q=length(find(d==0))/length(d);
    %  SI(k:12:n,1)=q+(1-q).*gamcdf(d,par(1),par(2));
    
    %  Empirical method
    
    SI(k:12:n,1)=empdis(d);
end

SI(:,1)=norminv(SI(:,1));


function y=empdis(d)

%  Compute the empirical probability

n=length(d);bp=zeros(n,1);

for i=1:n
    bp(i,1)=sum(d(:,1)<=d(i,1));
end

% Gringorten plotting position

y=(bp-0.44)./(n+0.12);

%  Weibull plotting position

% y=(bp)./(n+1);


function y=Dat2EmpMSDI(xd,yd,sc)

% (1) Get accumulated prep (xd) and soil moisture (yd) data for the specific time scale (sc)
% (2) Compute the Empirical MSDI from the data

% Get the accumulated data of the time scale sc

A1=[];B1=[];

for i=1:sc,
    A1=[A1,xd(i:length(xd)-sc+i)];
    B1=[B1,yd(i:length(yd)-sc+i)];
end

X=sum(A1,2);Y=sum(B1,2);

% Compute the MSDI

n=length(X);
p=zeros(n,1);

for k=1:12
    d1=X(k:12:n);d2=Y(k:12:n);
    p(k:12:n,1)=emp_biv([d1,d2]);
end

y=norminv(p);


function y=Dat2CopMSDI(xd,yd,sc,st)

% (1) Get accumulated prep (xd) and soil moisture (yd) data for the specific time scale (sc)
% (2) Compute the copula based MSDI from the data

% Get the accumulated data of the scale sc

A1=[];B1=[];
for i=1:sc,
    A1=[A1,xd(i:length(xd)-sc+i)];
    B1=[B1,yd(i:length(yd)-sc+i)];
end

X=sum(A1,2);Y=sum(B1,2);

% Compute the MSDI

n=length(X);
SI=zeros(n,3);
cp=zeros(n,3);

for k=1:12
    
    copname=st;
    
    d1=X(k:12:n);
    d2=Y(k:12:n);
    
    %     Get the marginal (empirical) probability  (use Weibull)
    
    cp(k:12:n,1)=empdis(d1);
    cp(k:12:n,2)=empdis(d2);
    
    %     Fit the copula
    
    theta=copulafit(copname,[cp(k:12:n,1),cp(k:12:n,2)]);
    
    %     Compute the CDF
    
    cp(k:12:n,3)=copulacdf(copname,[cp(k:12:n,1),cp(k:12:n,2)],theta);
    
end

%  Compute standardized index (SPI,SSI and MSDI)

SI(:,1)=norminv(cp(:,1));
SI(:,2)=norminv(cp(:,2));
SI(:,3)=norminv(cp(:,3));

y=SI(:,3);



function y=emp_biv(d)

% Compute the empirical probability

n=length(d);
bp=zeros(n,1);

for i=1:n
    
    td=zeros(n,3);
    
    td(d(:,1)<=d(i,1),1)=1;
    td(d(:,2)<=d(i,2),2)=1;
    
    td(:,3)=td(:,1).*td(:,2);
    bp(i,1)=sum(td(:,3));
    
end

% Gringorten plotting position (bivariate)

y=(bp-0.44)./(n+0.12);

