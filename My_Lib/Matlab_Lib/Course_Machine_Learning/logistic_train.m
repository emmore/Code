function [weights] = logistic_train(data,labels,epsilon,maxiterations)
% [weights] = logistic_train(data,labels,epsilon,maxiterations)
% code to train a logistic regression classifier
%
% INPUTS:
% data = n x (d+1) matrix with n samples and d features, where
% column d+1 is all ones (corresponding to the intercept term)
% labels = n x 1 vector of class labels (taking values 0 or 1)
% epsilon = optional argument specifying the convergence
% criterion. Let pi be the probability predicted by the model
% for data point i and deltai be the absolute change in this
% probability since the last iteration. Let delta be the average
% of the deltai?s, over all the training data points. When delta
% becomes lower than epsilon, then halt.
% (if unspecified, use a default value of 10?-5)
% maxiterations = optional argument that specifies the
% maximum number of iterations to execute (useful when
% debugging in case your code is not converging correctly!)
% (if unspecified can be set to 1000)

% OUTPUT:
% weights = (d+1) x 1 vector of weights where the weights
% correspond to the columns of "data"

clc;
j=1;
n=size(data,1);
d=size(data,2);
weights=zeros(d,1);
sig=ones(n,1);
u=eye(n);
diff=100*ones(d,1);
%Calculate the Hessian & Gradient
while j<maxiterations && mean(abs(diff))>epsilon
    for i=1:n
        sig(i)=sigmoid(weights,data(i,:));
        u(i,i)=sig(i)*(1-sig(i));
    end
    H=data'*u*data;
    grad=data'*(labels-sig);
    diff=H\grad;
    weights=weights+diff;
    j=j+1;
end
end


function y=sigmoid(theta,x)
y=1/(1+exp(-dot(theta,x)));
end



