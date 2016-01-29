function [z,S]=TPWB(x,y)
m=size(x,1);
P=x(:,1);
EP=x(:,2);
E=ones(m,1);
z=ones(m,1);
Q_o=ones(m,1);
S=ones(m+1,1);
S(1)=100;


c1=0.4;
c2=0.4;
w=0.4;
N=1000;
T=20;
range=[20 2000;0.01 0.99];
zz=rand(1,N);
p=(range*[(ones(1,N)-zz);zz]);
v=0.1*p;
value=ones(1,N);
n_value=ones(1,N);
for j=1:N
    for i=1:m
        if EP(i)==0
             E(i)=0.0;
        else    
        E(i)=p(2,j)*EP(i)*tanh((P(i)+S(i))/EP(i));
        end
        if P(i)==0
            Q_o(i)=S(i)-E(i);
        else
        Q_o(i)=(P(i)+S(i)-E(i))*tanh((P(i)+S(i)-E(i))/p(1,j));
        end
        S(i+1)=P(i)+S(i)-Q_o(i)-E(i);
    end 
   
    value(j)=(y-Q_o)'*(y-Q_o);
end
p_best=p;
[v_best,lab]=min(value); 
g_best=p(:,lab);
for i=1:T
    v=w*v+c1*rand*eye(2)*(p_best-p)+c2*rand*eye(2)*(g_best*ones(1,N)-p);
    p=p+v; 
    for k=1:N
        for q=1:2
            if p(q,k)<range(q,1)|| p(q,k)>range(q,2)
                 p(q,k)=rand*(range(q,2)-range(q,1))+range(q,1);
            end
        end
    end
    for j=1:N
        for q=1:m
            E(q)=p(2,j)*EP(q)*tanh((P(q)+S(q))/EP(q));
            Q_o(q)=(P(q)+S(q)-E(q))*tanh((P(q)+S(q)-E(q))/p(1,j));
            S(q+1)=P(q)+S(q)-Q_o(q)-E(q);
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
    E(i)=g_best(2)*EP(i)*tanh((P(i)+S(i))/EP(i));
    z(i)=(P(i)+S(i)-E(i))*tanh((P(i)+S(i)-E(i))/g_best(1));
    S(i+1)=P(i)+S(i)-z(i)-E(i);
end 
end