data=features;
data(isnan(data))=0.5;
for i=1:size(features,2)
    data(:,i)=(data(:,i)-min(data(:,i)))/(max(data(:,i))-min(data(:,i)));
end
x=[data ones(length(data),1)];
y=target(:,1);
epsilon=0.00001;


k=1;
nn=50;
likelihood=zeros(nn,1);
accuracy=zeros(nn,1);
for maxiterations=1:nn
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

fig1=plot(1:nn,accuracy(1:nn));
xlabel('Iteration Times');
ylabel('Accuracy %');
saveas(gcf,'accuracy.eps');

fig2=plot(1:nn,likelihood(1:nn));
xlabel('Iteration Times');
ylabel('Log-Likelihood');
saveas(gcf,'likelihood.eps');
