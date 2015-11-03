function m=Ergodicity()
result=[];
day_a=8;
dep_a=0.4;
initials=0.3;
initialep=3;
b=0;
m=[];
entro=[];
for i=1:1000
    [rain I ep r s]=Mont_Carlo(initials,initialep,day_a,dep_a,b);
    result=[result s(1:150,:)];
end
for i=1:size(result,1)
    z=mean(result(i,:));
    m=[m z];
end 
xlabel('Time/d');
ylabel('Ensemble Average Soil Moisture');
end