function [mass_length,mass_height,h,t]=Mass_Produce(data)
mass_length=[];
mass_height=[];
for i=201:276
    value=Data_Extraction(data,i);
    [length,height]=Character_Extraction(value);
    mass_length=[mass_length;length'];
    mass_height=[mass_height;height'];
end
[yc,z,h,t]=clustering_draw(mass_height);
end