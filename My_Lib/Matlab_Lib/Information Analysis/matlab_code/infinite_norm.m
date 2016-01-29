function z=infinite_norm(a,b)
n=size(a,2);
distance=ones(1,n);
for i=1:n
    distance(i)=abs(a(i)-b(i));
end
z=max(distance);
end


