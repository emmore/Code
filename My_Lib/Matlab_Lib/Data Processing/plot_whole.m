lbl={'*','o','d','^','+'};
colo=[[1 1 0];[1 0 1];[0 1 1];[1 0 0];[0 1 0]];

for i=1:1
plot(Oe(i,:),O(i,:),lbl{i},'Color',colo(i,:));
hold on;
end
plot(-1:1,-1:1);
axis([-1,1,-1,1]);
legend('1','2','3','4','5');
str=corrcoef(Oe,O);
str=['R=' num2str(str(2,1))];
dim=[.2 .5 .3 .3];
annotation('textbox',dim,'String',str,'FitBoxToText','on');
hold off;

for i=1:1
plot(Os(i,:),Ov(i,:),lbl{i},'Color',colo(i,:));
hold on;
end
plot(-1:1,-1:1);
%axis([-1,1,-1,1]);
legend('1','2','3','4','5');
str=corrcoef(Os,Ov);
str=['R=' num2str(str(2,1))];
dim=[.2 .5 .3 .3];
annotation('textbox',dim,'String',str,'FitBoxToText','on');
hold off;