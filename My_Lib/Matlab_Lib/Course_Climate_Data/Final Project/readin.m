filename='/Users/penn/Documents/Data/monthly_P_T/Climate Research Unit/cru_ts3.23.1901.2014.pre.dat.nc';
lon=ncread(filename,'lon');
lat=ncread(filename,'lat');
for i=1:length(lon)
    for j=1:length(lat)
        pre=ncread(filename,'pre',[i,j,1],[1,1,inf]);
        %calculate
        
    end
end
