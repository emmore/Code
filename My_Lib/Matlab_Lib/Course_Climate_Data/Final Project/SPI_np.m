function result=SPI_np(Data)
n=length(Data);
result=zeros(n,1);
for k=1:12   
    d=Data(k:12:n);
    result(k:12:n,1)=empdis(d);
end
result(:,1)=norminv(result(:,1));


function y=empdis(d)
%  Compute the empirical probability (Gringorten)
n=length(d);
bp=zeros(n,1);

for i=1:n
    bp(i,1)=sum(d(:,1)<=d(i,1));
end

y=(bp-0.44)./(n+0.12);


