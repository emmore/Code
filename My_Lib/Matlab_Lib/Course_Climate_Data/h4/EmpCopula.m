function y=EmpCopula(xd,yd,sc)

% (1) Get accumulated prep (xd) and soil moisture (yd) data for the specific time scale (sc)
% (2) Compute the Empirical MSDI from the data

% Get the accumulated data of the time scale sc

A1=[];B1=[];

for i=1:sc,
    A1=[A1,xd(i:length(xd)-sc+i)];
    B1=[B1,yd(i:length(yd)-sc+i)];
end

X=sum(A1,2);Y=sum(B1,2);

% Compute the MSDI

n=length(X);
p=zeros(n,1);

for k=1:12
    d1=X(k:12:n);
    d2=Y(k:12:n);
    p(k:12:n,1)=emp_biv([d1,d2]);
end

y=norminv(p);


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