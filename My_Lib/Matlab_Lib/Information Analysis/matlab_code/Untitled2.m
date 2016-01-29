for i=130:1:800
    for j=0.0001:0.001:0.05
        zz=['-c ',num2str(i), ' -g', num2str(j)];
        model=svmtrain(y(1:mm,:),x(1:mm,:),[a,zz,b]); 
        [z, mse, dec_values] = svmpredict(y(mm+1:m,:),x(mm+1:m,:),model);
        if mse(3)>v_gbest
            v_gbest=mse(3);
            p_gbest=zz;
        end
    end
end
v_gbest=mse(3);
p_gbest=zz;



