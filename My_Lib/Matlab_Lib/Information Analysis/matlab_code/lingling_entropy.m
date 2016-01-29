function result=lingling_entropy(filename)
lag_max=7;
NUM=82;
result=ones(NUM,1);
dd=readin(filename,1,0);
m=size(dd,1);
m=m-NUM*10*(lag_max+1);
for i=10:10:NUM*10
d=readin(filename,i,lag_max);
nsample=ceil(m/i);
y=d(1:nsample,3*(lag_max+1));
result(i/10)=entropy(y); 
end
end  