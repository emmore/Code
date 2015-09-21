function [A,yc,z,h,t]=Normal_Mass_Produce(data)
%function a=Normal_Mass_Produce(data)
A=[];
for i=201:276
    value=Data_Extraction(data,i);
    if(size(value,1)<106)
        z=(1.2309e+008)*ones((106-size(value,1)),1);
        value=[value;z];
    end
    A=[A;value'];
end
[yc,z,h,t]=clustering_draw(A);
end