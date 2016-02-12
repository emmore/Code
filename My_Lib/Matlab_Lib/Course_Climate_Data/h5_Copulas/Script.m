cd 'C:\Users\chrs-134\Documents\Github\Code\My_Lib\Matlab_Lib\Course_Climate_Data\h5_Copulas';
data=load('td.txt');
dp=data(:,1);
ds=data(:,2);
disp=empdis(dp);
diss=empdis(ds);

%copname='Frank';
copname='Gumbel';
theta=copulafit(copname,[disp,diss]);


N=20;
u = linspace(0,1,N);
[u1,u2] = meshgrid(u,u);
y = copulacdf(copname,[u1(:),u2(:)],theta);
[C,h]=contour(u1,u2,reshape(y,N,N),10);
clabel(C,h)
xlabel('c.d.f. of Precipitation')
ylabel('c.d.f. of Soil Mositure')
title(['Copulas of Precipitation and Soil Moisture Estimated with ' copname]);

[dp1,ds1]=meshgrid(dp(1:5:396),ds(1:5:396));
[disp1,diss1]=meshgrid(disp(1:5:396),diss(1:5:396));
value=copulacdf(copname,[disp1(:),diss1(:)],theta);
[C,h]=contour(dp1,ds1,reshape(value,length(disp1),length(diss1)),10);
clabel(C,h)
xlabel('c.d.f. of Precipitation')
ylabel('c.d.f. of Soil Mositure')
title(['Copulas of Precipitation and Soil Moisture Estimated with ' copname]);





[xi,yi]=meshgrid(dp,ds);
z=griddata(dp,ds,value,xi,yi);
contour(xi,yi,z);

[xi,yi]=meshgrid(disp,diss);
z=griddata(disp,diss,value,xi,yi);
contour(xi,yi,z);



y=norminv(value);

value_e=emp_biv([dp,ds]);

 

 
