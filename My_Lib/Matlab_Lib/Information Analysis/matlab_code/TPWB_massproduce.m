function result=TPWB_massproduce()
lag_max=7;
number=36;
result=ones(number,1);
d=data(1,0);
m=size(d,1);
m=m-360*(lag_max+1);
for i=10:10:number*10
d=data(i,lag_max);
nsample=ceil(m/i);
dd=d(1:nsample,:);
y=dd(:,3*(lag_max+1));
x=dd(:,((lag_max*3+1):(lag_max*3+2)));
z=TPWB(x,y);
result(i/10)=leonenko_mi(z,y);
end
end 