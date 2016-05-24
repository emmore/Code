function [ratio_m,ratio_v]=Monthly_Precipitation_Ratio(months)
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/p_result.mat');
s_m_result=zeros(size(p_result,2),size(p_result,3));
sv_m_result=zeros(size(p_result,2),size(p_result,3));
for n=1:12
    for i=1:size(p_result,2)
        for j=1:size(p_result,3)
            p_m_result(n,:,i,j)=squeeze(p_result(n:12:length(p_result),i,j));
            v_m_result(n,i,j)=var(squeeze(p_m_result(n,:,i,j)));
            m_m_result(n,i,j)=mean(squeeze(p_m_result(n,:,i,j)));
            s_m_result(i,j)=s_m_result(i,j)+m_m_result(n,i,j);
            sv_m_result(i,j)=sv_m_result(i,j)+v_m_result(n,i,j);
        end
    end
end
sm=zeros(size(p_result,2),size(p_result,3));
sv=zeros(size(p_result,2),size(p_result,3));
for n=1:length(months)
    for i=1:size(p_result,2)
        for j=1:size(p_result,3)
            sm(i,j)=m_m_result(n,i,j)+sm(i,j);
            sv(i,j)=v_m_result(n,i,j)+sv(i,j);
        end
    end
end
ratio_m=sm./s_m_result;
ratio_v=sv./sv_m_result;
end
   



    