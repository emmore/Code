function discretize()
pd = makedist('Normal');
x = -3:.1:3;
pdf_normal = pdf(pd,x);
plot(x,pdf_normal,'k');
xlabel('X');
ylabel('f(X)');
hold on;
plot([0,0],[0,pdf(pd,0)]);
hold on;
plot([-1.5,-1.5],[0,pdf(pd,-1.5)]);
hold on;
plot([-1,-1],[0,pdf(pd,-1)]);
hold on;
plot([-0.5,-0.5],[0,pdf(pd,-0.5)]);
hold on;
plot([1.5,1.5],[0,pdf(pd,1.5)]);
hold on;
plot([1,1],[0,pdf(pd,1)]);
hold on;
plot([0.5,0.5],[0,pdf(pd,0.5)]);
hold on;
plot([0,0],[pdf(pd,0)+0.01,0.445]);
hold on;
plot([0.5,0.5],[pdf(pd,0.5)+0.01,0.445]);
set(gca,'YTick',[])
set(gca,'XTick',[])
hold off;




