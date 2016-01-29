function result_p=mi_p_q(filename)
lag_max=7;
NUM=36;
result_p=ones(NUM,lag_max+1);
dd=readin(filename,1,0);
m=size(dd,1);
m=m-NUM*10*(lag_max+1);
for i=10:10:NUM*10
d=readin(filename,i,lag_max);
if i<80;
nsample=54;
else
nsample=ceil(m/i);
end
dd=d(1:nsample,:);
y=dd(:,3*(lag_max+1));
for j=0:lag_max
    x_p=[];
    for p=0:j
        x_p=[x_p dd(:,(3*(lag_max-p)+1))];
    end  
    result_p(i/10,j+1)=MI(x_p,y);
end
end
end
