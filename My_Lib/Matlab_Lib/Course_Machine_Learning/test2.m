D = 500; % set the dimensionality
% data for class 1
mu1 = 3*ones(1,D); Sigma1 = eye(D); N1 = 50000;
xdata1 = [mvnrnd(mu1, Sigma1, N1) ones(N1,1)];
% data for class 2
mu2 = 5*ones(1,D); Sigma2 = eye(D); N2 = 50000;
xdata2 = [mvnrnd(mu2, Sigma2, N2) ones(N2,1)];
xdata = [xdata1; xdata2];
labels = [ zeros(N1,1); ones(N2,1) ];