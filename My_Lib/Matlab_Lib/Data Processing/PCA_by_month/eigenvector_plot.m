function result=eigenvector_plot(eigenvector,n,k,p_result)
eigen=squeeze(eigenvector(n,:,:));
result=NaN(size(p_result,2),size(p_result,3));
num=0;
for longitude=1:size(p_result,3)
    for latitude=1:size(p_result,2)
        if  p_result(1,latitude,longitude)>=0
            num=num+1;
            result(latitude,longitude)=eigen(num,k);
        end
    end
end
surf(result);
view([0,90]);
colorbar;
end
    