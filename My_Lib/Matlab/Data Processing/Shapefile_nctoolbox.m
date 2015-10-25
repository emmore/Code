function [longtitude,latitude,result]=Shapefile_nctoolbox(lon_min,lon_max,lat_min,lat_max,filename,target)
ds=ncdataset(filename);
lon=ncread(filename,'lon');
lat=ncread(filename,'lat');
a=find(lon>=lon_min &lon<=lon_max);
b=find(lat>=lat_min &lat<=lat_max);
result=ds.data(target);
lon_num=length(a);
lat_num=length(b);
longtitude=linspace(lon_min,lon_max,(lon_max-lon_min)/(lon(2)-lon(1)));
latitude=linspace(lat_min,lat_max,(lat_max-lat_min)/(lat(2)-lat(1)));
result=result(:,b(1):b(lat_num),a(1):a(lon_num));
end


