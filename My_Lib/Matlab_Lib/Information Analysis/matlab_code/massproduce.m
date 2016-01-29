function [result_r,result]=massproduce(i)
nsample=ceil(18000/i);
lag_max=7;
d=data(i,lag_max);
dd=d(1:nsample,:);
result_r=ones(1,lag_max+1);
result=ones(1,lag_max+1);
y=dd(:,3*(lag_max+1));
for j=0:lag_max
    x=dd(:,((lag_max-j)*3+1):(lag_max*3+2));
    x_r=[];
    for p=0:j
        x_r=[x_r dd(:,(3*(lag_max-p)+1):(3*(lag_max-p)+2))];
    end   
    result_r(j+1)=MI(x_r,y);
    result(j+1)=MI(x,y);
end
end

 
 