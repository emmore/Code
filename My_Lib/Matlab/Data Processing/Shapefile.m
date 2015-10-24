function [longtitude,latitude,result]=Shapefile(lon_min,lon_max,lat_min,lat_max,filename,target)
lon=ncread(filename,'lon');
lat=ncread(filename,'lat');
a=find(lon>=lon_min &lon<=lon_max);
b=find(lat>=lat_min &lat<=lat_max);
lon_num=length(a);
lat_num=length(b);
longtitude=linspace(lon_min,lon(2)-lon(1),lon_max);
latitude=linspace(lat_min,lat(2)-lat(1),lat_max);
result=ncread(filename,target,[a(1) b(1) 1],[lon_num lat_num inf],[1 1 1]);
end


