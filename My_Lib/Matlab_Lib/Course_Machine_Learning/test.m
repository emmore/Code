data=[ones(20,2)+rand(20,2);-ones(40,2)+rand(40,2)];
labels=[ones(20,1);zeros(40,1)];
epsilon=0.000001;
maxiterations=1000;

[weights] = logistic_train(data,labels,epsilon,maxiterations);


result=ones(60,1);
for i=1:60
result(i)=sigmoid(data(i,:),weights);
end
plot(result);





load 'labels.txt'; 
y = labels;
load 'binary_features.txt'; 
data = binary_features;
x=[data ones(length(data),1)];



k=1;
likelihood=zeros(length(1:10),1);
for maxiterations=1:10
    weights=logistic_train(x,y,epsilon,maxiterations);

    result=ones(length(data),1);
    for i=1:length(data)
        result(i)=sigmoid(x(i,:),weights);
    end
        chat=result>0.5;
    accuracy(k)=100*sum(y==chat)/length(y);
    for i=1:length(data)
        likelihood(k)=likelihood(k)+y(i)*log(sigmoid(x(i,:),weights))+(1-y(i))*log(1-sigmoid(x(i,:),weights));
    end
    k=k+1;
end

fig1=plot(1:10,accuracy(1:10));
xlabel('Iteration Times');
ylabel('Accuracy %');
saveas(gcf,'accuracy.eps');

fig2=plot(1:10,likelihood(1:10));
xlabel('Iteration Times');
ylabel('Log-Likelihood');
saveas(gcf,'likelihood.eps');

N=[10, 20, 50, 100, 200, 500, 1000, 2000];
maxiterations=30;
epsilon=0.0001;
Naccuracy=zeros(length(N),1);
for i=1:length(N)
    ye=y(1:N(i),:);
    xe=x(1:N(i),:);
    
    yv=y(N(i)+1:length(y),:);
    xv=x(N(i)+1:length(y),:);
    
    weights=logistic_train(xe,ye,epsilon,maxiterations);

    result=ones(length(yv),1);
    for j=1:length(yv)
        result(j)=sigmoid(xv(j,:),weights);
    end
    chat=result>0.5;
    Naccuracy(i)=100*sum(yv==chat)/length(yv);
end
fig2=plot(N,Naccuracy);
xlabel('Estimation Data Length');
ylabel('Accuracy %');
saveas(gcf,'length_accuracy.eps');

weights=logistic_train(x,y,epsilon,maxiterations,1,5000);
result=ones(length(data),1);
for i=1:length(data)
    result(i)=sigmoid(x(i,:),weights);
end
chat=result>0.5;
accuracy=100*sum(y==chat)/length(y);

D = 500; % set the dimensionality
% data for class 1
mu1 = 3*ones(1,D); Sigma1 = eye(D); N1 = 50000;
xdata1 = [mvnrnd(mu1, Sigma1, N1) ones(N1,1)];
% data for class 2
mu2 = 5*ones(1,D); Sigma2 = eye(D); N2 = 50000;
xdata2 = [mvnrnd(mu2, Sigma2, N2) ones(N2,1)];
xdata = [xdata1; xdata2];
labels = [ zeros(N1,1); ones(N2,1) ];


epsilon=0.001;
maxiterations=30;
k=1;
accuracy2=zeros(length(50:50:10000),1);
for m=50:100:10000
%weights1=logistic_train(xdata,labels,epsilon,maxiterations,0,70000);
weights2=logistic_train(xdata,labels,epsilon,maxiterations,1,m);
%result1=ones(length(xdata),1);
result2=ones(length(xdata),1);
for i=1:length(xdata)
%    result1(i)=sigmoid(xdata(i,:),weights1);
    result2(i)=sigmoid(xdata(i,:),weights2);
end
%chat1=result1>0.5;
chat2=result2>0.5;
%accuracy1=100*sum(labels==chat1)/length(labels);
accuracy2(k)=100*sum(labels==chat2)/length(labels);
k=k+1;
end
    
    
    
    
    
    epsilon=0.001;
maxiterations=30;

m=50;
%weights1=logistic_train(xdata,labels,epsilon,maxiterations,0,70000);
weights2=logistic_train(xdata,labels,epsilon,maxiterations,1,m);
%result1=ones(length(xdata),1);
result2=ones(length(xdata),1);
for i=1:length(xdata)
%    result1(i)=sigmoid(xdata(i,:),weights1);
    result2(i)=sigmoid(xdata(i,:),weights2);
end
%chat1=result1>0.5;
chat2=result2>0.5;
%accuracy1=100*sum(labels==chat1)/length(labels);
accuracy2=100*sum(labels==chat2)/length(labels);
