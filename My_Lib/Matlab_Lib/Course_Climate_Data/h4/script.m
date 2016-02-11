data=load('td.txt');
dp=data(:,1);
ds=data(:,2);
disp=empdis(dp);
diss=empdis(ds);

copname='Frank';
theta=copulafit(copname,[disp,diss]);
value=copulacdf(copname,[disp,diss],theta);
y=norminv(value);

value_e=emp_biv([dp,ds]);