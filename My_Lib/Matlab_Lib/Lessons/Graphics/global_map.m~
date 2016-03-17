s=zeros(360,720);
figure('Color','white')
worldmap('World')
load coast 
plotm(lat,long)
latlim = [-90 90]; 
lonlim = [-180 180];
[lattt,lonnn] = meshgrat(latlim,lonlim,[360 720]);
pcolorm(lattt,lonnn,s);

