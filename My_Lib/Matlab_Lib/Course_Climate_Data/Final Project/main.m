function main()
cd '/Users/penn/Documents/Code/Github/My_Lib/Matlab_Lib/Course_Climate_Data/Final Project';
filename='/Users/penn/Documents/Data/monthly_P_T/Climate Research Unit/cru_ts3.23.1901.2014.pre.dat.nc';
lon=ncread(filename,'lon');
lat=ncread(filename,'lat');
T=1368;
result_np=NaN(length(lon),length(lat),4,T);
result_p=NaN(length(lon),length(lat),4,T);
scales=[1,3,6,12];
precipitation=ncread(filename,'pre',[1,1,1],[length(lon),length(lat),inf]);
for i=1:length(lon)
    for j=1:length(lat)
        if isfinite(precipitation(i,j,1))
            pre=squeeze(precipitation(i,j,:));
            for k=1:4
                %aggregate
                pre_a=aggregate(pre,scales(k));
                %calculate
                result_np(i,j,k,1:T-scales(k)+1)=SPI_np(pre_a,scales(k));
                result_p(i,j,k,1:T-scales(k)+1)=SPI_p(pre_a,scales(k));
                disp([i,j,k]);
            end
        end
    end
end
save('result_np.mat','result_np');
save('result_p.mat','result_p');
end