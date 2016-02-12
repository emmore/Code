cd 'C:\Users\chrs-134\Documents\Github\Code\My_Lib\Matlab_Lib\Course_Climate_Data\h5_Copulas';
data=load('td.txt');
dp=data(:,1);
ds=data(:,2);%+normrnd(0,0.001,length(data),1);
disp=empdis(dp);
diss=empdis(ds);

%copname='Frank';
copname='Gumbel';
copname='Clayton';
theta=copulafit(copname,[disp,diss]);

 
N=20;
u = linspace(0,1,N);
[u1,u2] = meshgrid(u,u);
y = copulacdf(copname,[u1(:),u2(:)],theta);
[C,h]=contour(u1,u2,reshape(y,N,N),10);
clabel(C,h,'manual')
xlabel('c.d.f. of Precipitation')
ylabel('c.d.f. of Soil Mositure')
title(['Copulas of Precipitation and Soil Moisture Estimated with ' copname]);

[dp1,ds1]=meshgrid(dp(1:71:396),ds(1:71:396));
[disp1,diss1]=meshgrid(disp(1:71:396),diss(1:71:396));
value=copulacdf(copname,[disp1(:),diss1(:)],theta);
[C,h]=contour(dp1,ds1,reshape(value,length(disp1),length(diss1)),10);
clabel(C,h,'manual')
xlabel('Precipitation')
ylabel('Soil Mositure')
title(['Union Distribution of Precipitation and Soil Moisture Estimated with ' copname]);



p=emp_biv([dp,ds]);
dd=sortrows([disp,diss,p],1);
disp2=dd(:,1);
diss2=dd(:,2);
p=dd(:,3);
[xi,yi]=meshgrid(disp2,diss2);
zi = griddata(disp2,diss2,p,xi,yi);
[C,h]=contour(xi,yi,zi,10);
clabel(C,h,'manual')
xlabel('c.d.f. of Precipitation')
ylabel('c.d.f. of Soil Mositure')
title('Empirical Copulas of Precipitation and Soil Moisture');

p=emp_biv([dp,ds]);
dd=sortrows([dp,ds,p],1);
dp2=dd(:,1);
ds2=dd(:,2);
p=dd(:,3);
[xi,yi]=meshgrid(dp2,ds2);
zi = griddata(dp2,ds2,p,xi,yi);
[C,h]=contour(xi,yi,zi,5);
clabel(C,h,'manual')
xlabel('Precipitation')
ylabel('Soil Mositure')
title('Empirical Union Distribution of Precipitation and Soil Moisture');





 

 
