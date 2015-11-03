function Mont_Carlo_T_Draw()
length=400;
day_a=8;
dep_a=0.5;
initials=0.3;
initialep=3;
b=0;
[rain I ep r s]=Mont_Carlo(initials,initialep,day_a,dep_a,b);
pic=plot(s(1:length));
xlabel('Time/d');
ylabel('Soil Moisture');



for i=1:1
    [rain I ep r s]=Mont_Carlo(initials,initialep,day_a,dep_a,b);
    cc=rand(1,3);
    plot(s(1:length,:),'Color',cc);
    hold on;
end
xlabel('T(d)');
ylabel('Soil Moisture');
hold off;


end