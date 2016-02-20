function Z=SPI_np_pan(Data,scale)

% This code computes the Standardized Precipitation Index (SPI)
% non-parametrically. The code is part of the Standardized Drought Analysis
% Toolbox (SDAT) developed at the University of California, Irvine 
% This code can be used to generate other univariate drought indicators
% including Standardized Soil Moisture Index (SSI), Standardized Runoff Index (SRI) 
% and Standardized Relative Humidity Index (SRHI). 

% Input data include
% 1- A vector of input precipitation, soil moisture, runoff, etc (see below "load tp")
% 2- Time scaleale (scale). Common time scaleales are 1-, 3-, 6-, and 12-month 

% Reference:  
% Hao Z., AghaKouchak A., Nakhjiri N., Farahmand A., 2014, Global Integrated Drought Monitoring and Prediction System, scaleientific Data, 1:140001, 1-10, doi: 10.1038/sdata.2014.1.

% Load the sample precipitation data
%tp=load('precip.txt');   % input data
%tp=load('PrecipVec.txt');
% Define the time scaleale (e.g., 6-month SPI)
%scale=12; %        % scaleale : 1,3,12,48

dp=Data(:,1);

nm=length(dp);

Z=zeros(nm,1);

%if at least one observation is missing in data, do not calculate SPI
if length(dp(dp>=0))./length(dp)~=1
       disp('no observation exist.')
       Z(:,1)=nan;
else

% Comput the empirical SPI (Gringorten)

Z(1:scale-1,1)=nan;
Z(scale:end,1)=SPIComp(dp,scale);

end
% Plot the figure for SPI
%{
figure(1)

plot(1:nm,SPIvector,'b','LineWidth',2)
ylim([-4 4])
hline = refline([0 0]);
set(hline,'Color','k')
ylabel('SPI')



xlabel([int2str(scale) ' month'])

%xlim([250 397])
save SPIvector SPIvector
%}

function SI=SPIComp(md,scale)

% (1) Get the precipitation data for the specific time scaleale
% (2) Compute the Empirical drought index (SPI) from the data

% Get the data for the time scaleale scale

A1=[];

for i=1:scale,
    A1=[A1,md(i:length(md)-scale+i)];
end

Y=sum(A1,2);

% Compute  SPI

n=length(Y);

SI=zeros(n,1);

for k=1:12
    
    d=Y(k:12:n);
    SI(k:12:n,1)=empdis(d);
end

SI(:,1)=norminv(SI(:,1));


function y=empdis(d)

%  Compute the empirical probability (Gringorten)

n=length(d);
bp=zeros(n,1);

for i=1:n
    bp(i,1)=sum(d(:,1)<=d(i,1));
end

y=(bp-0.44)./(n+0.12);


