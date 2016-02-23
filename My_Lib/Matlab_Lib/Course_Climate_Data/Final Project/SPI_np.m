function result=SPI_np(Data,scale)
n=length(Data);
result=zeros(n,1);
nseas=12/scale; 
for k=1:nseas   
    d=Data(k:nseas:n);
    result(k:nseas:n,1)=empdis(d);
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


