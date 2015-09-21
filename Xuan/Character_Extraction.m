function [length,height]=Character_Extraction(signal)
[c,l]=wavedec(signal,5,'db1');
a=wrcoef('a',c,l,'db1',5);
m=size(a,1);
length=ones(m,1);
height=ones(m,1);
j=1;
for i=1:m-1
   if a(i+1)==a(i)
       length(j)=length(j)+1;
   else
       height(j)=a(i+1)-a(i);
       j=j+1;
   end
end
length=length(1:j,:);
height=height(1:j-1,:);
end
    