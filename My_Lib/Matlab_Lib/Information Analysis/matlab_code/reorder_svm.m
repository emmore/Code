function [z,zz,ph_svm,ph_l,ph_m]=reorder_svm(xx,yy)
[m,n]=size(xx);
temp=randperm(m);
x=ones(m,n);
y=ones(m,1);
for i=1:m
    x(i,:)=xx(temp(i),:);
    y(i)=yy(temp(i));
end
z=[svm_norm(x,y) y];
ph_svm=corrcoef(z(:,1),y);
ph_l=corrcoef(x*regress(y,x),y);
xxx=xx(:,(n-1):n);
[zz,ph_m]=TPWB(xxx,yy);
end
 
 
