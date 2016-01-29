function z=svm_norm(x,y)
[m,n]=size(x);
mm=ceil(3*m/5);
for i=1:n
    x(:,i)=boxcox(x(:,i));
    maximum=max(x(:,i));
    minimum=min(x(:,i));
    sc=maximum-minimum;
    for j=1:m
        x(j,i)=(x(j,i)-minimum)/sc;
    end
end
a='-s 3 -t 2  ';
zz='-c 512.2  -g 1.3 -p 0.01'; 
model=svmtrain(y(1:mm,:),x(1:mm,:),[a,zz]); 
%[z, mse, dec_values] = svmpredict(y,x,model);
[z, mse, dec_values] = svmpredict(y(mm+1:m,:),x(mm+1:m,:),model);
v_gbest=mse(3);
p_gbest=zz;
for cost=-5:1:5
    for epsilon=-13:1:-1
        for gamma=0:0.1:2
            zz=['-c ',num2str(2^cost), ' -g ', num2str(gamma), ' -p ', num2str(2^epsilon)];
            model=svmtrain(y(1:mm,:),x(1:mm,:),[a,zz]); 
            [z, mse, dec_values] = svmpredict(y(mm+1:m,:),x(mm+1:m,:),model);
            if mse(3)>v_gbest
                v_gbest=mse(3);
                p_gbest=zz;
            end
        end
    end
end
model=svmtrain(y(1:mm,:),x(1:mm,:),[a,p_gbest]); 
[z, mse, dec_values] = svmpredict(y,x,model);
end