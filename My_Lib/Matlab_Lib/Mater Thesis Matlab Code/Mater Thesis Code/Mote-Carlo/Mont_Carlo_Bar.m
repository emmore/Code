function entro=Mont_Carlo_Bar()
set(gca,'FontSize',24);
result=[];
day_a=8;
dep_a=0.5;
initials=0.3;
initialep=3;
b=0;
m=[];
entro=[];
for i=1:400
    [rain I ep r s]=Mont_Carlo(initials,initialep,day_a,dep_a,b);
    result=[result s(1:150,:)];
end
for i=1:size(result,1)
    z=sort(result(i,:));
    entro=[entro entropy(z)];
    m=[m z'];
end

surf(m');
shading interp; 
xlabel('Resorted Soil Moisture','FontSize',18);
ylabel('T(d)','FontSize',18);
set(gca,'xtick',[]);
view([0,90]);
colormap(jet);
caxis([0,1]);
colorbar;

 
end