function [first,second]=MKMotif(sub)
subsequence=[];
n=size(sub,2);
for i=1:n
    subsequence=[subsequence sub(i).content];
end
d=ones(n,n);
for i=1:n
    for j=1:n
        d(i,j)=norm(subsequence(:,i)-subsequence(:,j),2);
    end
end
tmpt=inf;
for i=1:n
    for j=1:n
        if (d(i,j)<tmpt)&&(d(i,j)>0)
            tmpt=d(i,j);
            first=i;
            second=j;
        end
    end
end
end