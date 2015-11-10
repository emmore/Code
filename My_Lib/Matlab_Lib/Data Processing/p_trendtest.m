function [ptr,ttr]=p_trendtest(p_result,t_result)
ptr=zeros(size(p_result,2),size(p_result,3));
ttr=zeros(size(t_result,1),size(t_result,2));
for i=1:size(p_result,2)
    for j=1:size(p_result,3)
        ptr(i,j)=MK(p_result(:,i,j));
    end
end
for i=1:size(t_result,1)
    for j=1:size(t_result,2)
        ttr(i,j)=MK(t_result(i,j,47*12+1:size(t_result,3)));
    end
end

for i=1:size(ttr,1)
    for j=1:size(ttr,2)
        if ttr(i,j)==0
            ttr(i,j)=NaN;
        end
    end
end

%{
for i=1:size(ttr,1)
    for j=1:size(ttr,2)
        if isreal(ttr(i,j))
            if ttr(i,j)>1.96
                ttr(i,j)=1;
            else 
                if ttr(i,j)<-1.96
                    ttr(i,j)=-1;
                else
                    if ttr(i,j)>=-1.96 && ttr(i,j)<=1.96
                        ttr(i,j)=0;
                    end
                end
            end
        end
    end
end
%} 

surf(ttr');
axis off;
colorbar;
view([0,90]);
grid off;
title('MK Statistic of Air Temperature');
saveas(gcf,'mk_t.png');
