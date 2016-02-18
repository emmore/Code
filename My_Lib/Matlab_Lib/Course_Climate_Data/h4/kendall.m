function tau = kendall(x,y)
%KENDALL Kendall's correlation coefficient.
% TAU = KENDALL(X,Y) returns Kendall's rank correlation coefficient tau for
% the vectors X and Y.
distfun = inline('xi-xj');
n = numel(x);
tau = sum(sign(pdist(x,distfun)) .* sign(pdist(y,distfun))) .* 2./(n.*(n-1));