function why_stable_important()
day_a=10;
dep_a=0.5;
initials=0.3;
initialep=3;
b=0;
[rain ep r s]=Mont_Carlo(initials,initialep,day_a,dep_a,b);
result=[];
J=11;
for k=1:J
    m=10*power(2,k-1);
    tempt=s(1:m,:);
    q=[];
    for j=1:power(2,J-k)
        q=[q;tempt];
    end
    result=[result q];
end
set(gca,'FontSize',24);
boxplot(result);
set(gca,'xtick',1:J, 'xticklabel',{'10d','20d','40d','80d','160d','320d','640d','1280d','2560d','5120d','10240d'});
ylabel('归一化土壤蓄水量');
end

       
