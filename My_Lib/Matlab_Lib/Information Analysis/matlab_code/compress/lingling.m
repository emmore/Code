function [result_p,result_r,result]=lingling(filename)
lag_max=7;
NUM=36;
result_p=ones(NUM,lag_max+1);
result_r=ones(NUM,lag_max+1);
result=ones(NUM,lag_max+1);
dd=readin(filename,1,0);
m=size(dd,1);
m=m-NUM*10*(lag_max+1);
for i=10:10:NUM*10
d=readin(filename,i,lag_max);
if i<80;
nsample=140;
else
nsample=ceil(m/i);
end
dd=d(1:nsample,:);
y=dd(:,3*(lag_max+1));
for j=0:lag_max
    x=dd(:,((lag_max-j)*3+1):(lag_max*3+2));
    x_r=[];
    x_p=[];
    for p=0:j
        x_r=[x_r dd(:,(3*(lag_max-p)+1):(3*(lag_max-p)+2))];
        x_p=[x_p dd(:,(3*(lag_max-p)+1))];
    end   
    result_r(i/10,j+1)=MI(x_r,y);
    result(i/10,j+1)=MI(x,y);
    result_p(i/10,j+1)=MI(x_p,y);
end
end
end

 