function z=Budyko(x,y)
m=size(x,1);
P=x(:,1);
EP=x(:,2);
z=ones(m,1);
Q_o=ones(m,1);
c1=0.4;
c2=0.4;
w=0.4;
N=700;
T=50;
range=[0.00001 0.99];
zz=rand(1,N);
p=(range*[(ones(1,N)-zz);zz]);
v=0.1*p;
value=ones(1,N);
n_value=ones(1,N);
for j=1:N
    for i=1:m
       % p(1,j) is the parameter;
        Q_o(i)=power((power(P(i),1/(1-p(1,j)))+power(EP(i),1/(1-p(1,j)))),(1-p(1,j)))-EP(i);
    end 
    value(j)=(y-Q_o)'*(y-Q_o);
end
p_best=p;
[v_best,lab]=min(value); 
g_best=p(:,lab);
for i=1:T
    v=w*v+c1*rand*(p_best-p)+c2*rand*(g_best*ones(1,N)-p);
    p=p+v; 
    for k=1:N
        for q=1:1
            if p(q,k)<range(q,1)|| p(q,k)>range(q,2)
                 p(q,k)=rand*(range(q,2)-range(q,1))+range(q,1);
            end
        end
    end
    for j=1:N
        for q=1:m
             % p(1,j) is the parameter;      
             Q_o(q)=power((power(P(q),1/(1-p(1,j)))+power(EP(q),1/(1-p(1,j)))),(1-p(1,j)))-EP(q);
        end 
        n_value(j)=(y-Q_o)'*(y-Q_o);
        if n_value(j)<value(j)
            p_best(:,j)=p(:,j);
            value(j)=n_value(j);
            if n_value(j)<v_best
                g_best=p(:,j);
                v_best=n_value(j);
            end
        end
    end
end
for i=1:m
     % g_best(1) is the parameter;
    z(i)=power((power(P(i),1/(1-g_best(1)))+power(EP(i),1/(1-g_best(1)))),(1-g_best(1)))-EP(i);
end 
end