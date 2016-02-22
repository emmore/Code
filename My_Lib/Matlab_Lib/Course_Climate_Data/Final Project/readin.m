filename='/Users/penn/Documents/Data/monthly_P_T/Climate Research Unit/cru_ts3.23.1901.2014.pre.dat.nc';
lon=ncread(filename,'lon');
lat=ncread(filename,'lat');
T=1368;
result=NaN(length(lon),length(lat),4,T);
scales=[1,3,6,12];
for i=1:length(lon)
    for j=1:length(lat)
        if isreal(ncread(filename,'pre',[1,1,1],[1,1,1]))
            pre=squeeze(ncread(filename,'pre',[i,j,1],[1,1,inf]));
            for k=1:4
                %aggregate
                pre_a=aggregate(pre,scales(k));
                %calculate
                result(i,j,k,1:T-scales(k)+1)=SPI_np(pre_a);
            end
        end
    end
end
