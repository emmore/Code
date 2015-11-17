function A=Clustering(p_result)
%function a=Normal_Mass_Produce(data)
A=[];
lat=size(p_result,1);
lon=size(p_result,2);
for i=1:lat*lon
    if mod(i,lat)==0
        value=p_result(lat,i/lat,:);
    else
        value=p_result(mod(i,lat),(i-mod(i,lat))/lat+1,:);
    end
    A=[A;(squeeze(value))'];
end
[yc,z,h,t]=clustering_draw(A);
end