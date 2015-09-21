% w is the average length of the subcluster; f is the elastic
% coefficient.f>1
function sub=SubsequenceExtranction(list,w,f)
length=size(list,1);
short=ceil(w/f);
long=floor(w*f);
k=1;
for i=short:long
    for j=1:(length-i)+1
        z=list(j:j+i-1,:);
        z=UniformScaling(z,w);
        z=zscore(z);
        sub(k).content=z;
        sub(k).start=j;
        sub(k).end=j+i-1;
        k=k+1;
    end
end
end
    