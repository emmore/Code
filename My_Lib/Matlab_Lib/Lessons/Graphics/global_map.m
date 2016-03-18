function global_map(s)
[a,b]=size(s);
figure('Color','white')
worldmap('World')
load coast 
plotm(lat,long)
latlim = [-90 90]; 
lonlim = [-180 180];
[lattt,lonnn] = meshgrat(latlim,lonlim,[a b]);
pcolorm(lattt,lonnn,s);
