function z=leonenko_mi(x,y)
m=size(x,1); 
k=4;
distance=ones(m,m);
k_dis=ones(m,1);
for i=1:m
    for j=1:m
        distance(i,j)=max([abs(x(i,:)-x(j,:)),abs(y(i,:)-y(j,:))]);
    end
end


for i=1:m
    distance(i,:)=sort(distance(i,:));
    k_dis(i)=distance(i,k+1);
end
phi_nx=ones(m,1);
phi_ny=ones(m,1);
for i=1:m
    for j=1:m
        if abs(x(j)-x(i))<k_dis(i) 
            phi_nx(i)=phi_nx(i)+1;
        end
        if abs(y(j)-y(i))<k_dis(i) 
            phi_ny(i)=phi_ny(i)+1;
        end
    end
end
for i=1:m
    phi_nx(i)=psi(phi_nx(i));
    phi_ny(i)=psi(phi_ny(i));
end
z=psi(k)+psi(m)-(sum(phi_nx)+sum(phi_ny))/m;
end
 

    

