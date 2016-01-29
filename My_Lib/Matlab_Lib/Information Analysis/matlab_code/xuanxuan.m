function [result_p,result_r,result]=xuanxuan()
lag_max=7;
scale_max=60;
d=data(scale_max,lag_max);
m=size(d,1);
result_r=ones(scale_max,lag_max+1);
result_p=ones(scale_max,lag_max+1);
result=ones(scale_max,lag_max+1);
for i=1:scale_max
    d=data(i,lag_max);
    dd=d(1:150,:);
    y=dd(:,3*(lag_max+1));
    for j=0:lag_max
        x=dd(:,((lag_max-j)*3+1):(lag_max*3+2));
        x_r=[];
        x_p=[];
        for p=0:j
            x_r=[x_r dd(:,(3*(lag_max-p)+1):(3*(lag_max-p)+2))];
            x_p=[x_r dd(:,(3*(lag_max-p)+1))];
        end   
        result_p(i,j+1)=MI(x_p,y);
        result_r(i,j+1)=MI(x_r,y);
        result(i,j+1)=MI(x,y);
    end
end
end
    
    
    
 
 