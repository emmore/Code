function y=empdis(d)

%  Compute the empirical probability

n=length(d);bp=zeros(n,1);

for i=1:n
    bp(i,1)=sum(d(:,1)<=d(i,1));
end

% Gringorten plotting position

y=(bp-0.44)./(n+0.12);

%  Weibull plotting position

% y=(bp)./(n+1);