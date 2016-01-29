function z=leonenko_entropy(x)
[m,n]=size(x);
distance=ones(m,m);
for i=1:m
    for j=1:m
        distance(i,j)=Euclidean_norm(x(i),x(j));
    end
end
for i=1:m
    distance(i,:)=sort(distance(i,:));
end
k=ceil(m^(2/(2+n)));
for i=1:m
    distance(i,k+1)=log(2*distance(i,k+1));
end
cd=(3.141592653^(n/2))/gamma(1+n/2)/2^n;
z=sum(distance(:,(k+1)))*n/m+psi(m)-psi(k)+log(cd);
end
    
