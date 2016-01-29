function z=leonenko_mi_2(x,y)
m=size(x,1);
p=size(y,1);
if m~=p
    error('Bad sizes of arguments');
end
k=15;
distance_x=ones(m,m);
distance_y=ones(m,m);
for i=1:m
    for j=1:m
        distance_x(i,j)=Euclidean_norm(x(i,:),x(j,:));
        distance_y(i,j)=Euclidean_norm(y(i,:),y(j,:));
    end
end
for i=1:m
    distance_x(i,:)=sort(distance_x(i,:));
    distance_y(i,:)=sort(distance_y(i,:));
end
phi_nx=zeros(m,1);
phi_ny=zeros(m,1);
for i=1:m
    for j=1:m
        if Euclidean_norm(x(j),x(i))<distance_x(i,k+1) 
            phi_nx(i)=phi_nx(i)+1;
        end
        if Euclidean_norm(y(j),y(i))<distance_y(i,k+1) 
            phi_ny(i)=phi_ny(i)+1;
        end
    end
end
for i=1:m
    phi_nx(i)=digamma(phi_nx(i));
    phi_ny(i)=digamma(phi_ny(i));
end
z=digamma(k)+digamma(m)-(sum(phi_nx)+sum(phi_ny))/m-1/k;
end
 

    

