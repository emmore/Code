function z=Euclidean_norm(a,b)
n=size(a,2);
z=0.0;
for i=1:n
    z=z+(a(i)-b(i))^2;
end
z=z^0.5;
end