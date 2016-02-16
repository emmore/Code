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
weights=logistic_train(x,y,epsilon,maxiterations);

result=ones(length(data),1);
for i=1:length(data)
result(i)=sigmoid(x(i,:),weights);
end
chat=result>0.5;
accuracy=100*sum(y==chat)/length(y);
