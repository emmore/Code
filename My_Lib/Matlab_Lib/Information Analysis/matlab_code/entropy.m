function Hx=entropy(y)
interval=3.73*std(y)*(length(y)^(-0.3333));
boxnumber=ceil((max(y)-min(y))/interval);
num=ones(boxnumber,1);
num(1)=length(find(y<(min(y)+interval)));
for i=2:boxnumber
    num(i)=length(find((y>=(min(y)+(i-1)*interval))&(y<(min(y)+i*interval))));
end;
Hx=0;
sl=interval*length(y);
for i=1:boxnumber
    if num(i)==0
        Hi=0;
    else
        Hi=-num(i)*log(num(i)/sl);
    end
    Hx=Hx+Hi;
end
Hx=Hx/length(y);
end
 













 