function [first,second]=NMKMotif(subsequence)
n=size(subsequence,2);
d=ones(n,n);
for i=1:n
    for j=1:n
        if subsequence(i).end<subsequence(j).start || subsequence(i).start<=subsequence(j).end
            d(i,j)=norm(subsequence(i).content-subsequence(j).content);
        else
            d(i,j)=inf;
        end
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