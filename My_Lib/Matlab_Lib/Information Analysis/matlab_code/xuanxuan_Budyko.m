function [result,nash]=xuanxuan_Budyko()
lag_max=7;
scale_max=60;
d=data(scale_max,lag_max);
m=size(d,1);
result=ones(scale_max,1); 
nash=ones(scale_max,1);
for i=1:scale_max
    d=data(i,lag_max);
    dd=d(1:m,:);
    y=dd(:,3*(lag_max+1));
    x=dd(:,(lag_max*3+1):(lag_max*3+2));
    z=Budyko(x,y);
    average=mean(y)*ones(m,1);
    ddd=(y-average)'*(y-average);
    nash(i)=1-(y-z)'*(y-z)/ddd;
    result(i)=leonenko_mi(z,y);
end
end