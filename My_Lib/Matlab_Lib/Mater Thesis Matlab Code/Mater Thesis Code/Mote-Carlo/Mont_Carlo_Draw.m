function result=Mont_Carlo_Draw()
length=400;
w=1:length;
set(gca,'FontSize',24);
initial=0.3;
for i=1:4
    [rain ep r s]=Mont_Carlo(initial,4);
    cc=rand(1,3);
    plot(s(1:length,:),'Color',cc);
    hold on;
end
xlabel('时间/天');
ylabel('土壤蓄水量');
hold off;

result=[];

initial=rand();
for i=1:200
    [rain ep r s]=Mont_Carlo(initial,3);
    result=[result s(1:150,:)];
end
for i=1:size(result,1)
    result(i,:)=sort(result(i,:));
end
surf(result);
shading interp;
xlabel('土壤蓄水量');
ylabel('时间/天');
set(gca,'xtick',[]);
view([0,90]);
colorbar;
end

    


    














 