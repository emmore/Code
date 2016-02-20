function result=SPI_CRU(prcp,scale)
[lon,lat,len_p]=size(prcp);
result=ones(lon,lat);
for i=1:lon
    for j=1:lat
        q=(SPI_pan(prcp(i,j,:),scale))';
        result(i,j)=q(end);
    end
end
surf(result);
view([0,90]);
colorbar;

        