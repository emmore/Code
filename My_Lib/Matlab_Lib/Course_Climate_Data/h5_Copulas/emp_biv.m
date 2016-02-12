function y=emp_biv(d)

% Compute the empirical probability

n=length(d);
bp=zeros(n,1);

for i=1:n
    
    td=zeros(n,3);
    
    td(d(:,1)<=d(i,1),1)=1;
    td(d(:,2)<=d(i,2),2)=1;
    
    td(:,3)=td(:,1).*td(:,2);
    bp(i,1)=sum(td(:,3));
    
end

% Gringorten plotting position (bivariate)

y=(bp-0.44)./(n+0.12);