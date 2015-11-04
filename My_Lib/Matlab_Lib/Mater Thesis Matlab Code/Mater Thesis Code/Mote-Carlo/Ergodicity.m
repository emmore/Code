function [m,n]=Ergodicity()
result=[];
day_a=8;
dep_a=0.4;
initials=0.3;
initialep=3;
b=0;
m=[];
n=[];
for i=1:1000
    [rain I ep r s]=Mont_Carlo(initials,initialep,day_a,dep_a,b);
    result=[result s(1:400,:)];
    tempmean=[];
    for j=1:400
        tempmean=[tempmean mean(s(1:j))];
    end
    n=[n tempmean'];
end
for i=1:size(result,1)
    z=mean(result(i,:));
    m=[m z];
end 
 

for i=1:400
    n=[n mean(s(1:i))];
end

plot(m');
xlabel('Time/d','FontSize',24); 
ylabel('Average Soil Moisture','FontSize',24);
hold on;
plot(n');
legend('Ensemble Average','Temporal Average');

end