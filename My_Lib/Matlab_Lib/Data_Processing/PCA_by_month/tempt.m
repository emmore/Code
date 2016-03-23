function r=tempt(indices)
r=zeros(12,1);
for i=1:12
    s=indices(:,i);
    s=s(s>-99);
    r(i)=MK(s);
end