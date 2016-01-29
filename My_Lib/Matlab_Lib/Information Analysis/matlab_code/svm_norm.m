function z=svm_norm(x,y)
[m,n]=size(x);
 for i=1:n
     maximum=max(x(:,i));
     minimum=min(x(:,i));
     sc=maximum-minimum;
    for j=1:m
         x(j,i)=-1+2*(x(j,i)-minimum)/sc;
     end
 end
c1=1.1;
c2=1.1;
w=0.3;
N=500;
T=4;
range=[0.1 2000;0.0001 0.3; 0.00015  3];                               
z=rand(1,N);
p=(range*[(ones(1,N)-z);z]);                   
v=0.1*p;     
value=ones(1,N);
n_value=ones(1,N);
for i=1:N
    value(i)=svmtrain(y ,x ,['-s 3 -t 2  -c ',num2str(p(1,i)), ' -g ', num2str(p(3,i)), ' -p ', num2str(p(2,i)), ' -v 5']);
end
p_best=p;
[v_best,lab]=min(value); 
g_best=p(:,lab);
for i=1:T
    v=w*v+c1*rand*eye(3)*(p_best-p)+c2*rand*eye(3)*(g_best*ones(1,N)-p);
    p=p+v; 
    for k=1:N
        for q=1:3
            if p(q,k)<range(q,1)|| p(q,k)>range(q,2)
                 p(q,k)=rand*(range(q,2)-range(q,1))+range(q,1);
            end
        end
    end
    for j=1:N
        n_value(i)=svmtrain(y ,x ,['-s 3 -t 2  -c ',num2str(p(1,j)), ' -g ', num2str(p(3,j)), ' -p ', num2str(p(2,j)), ' -v 5']);
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
        
model=svmtrain(y ,x ,['-s 3 -t 2  -c ',num2str(g_best(1)), ' -g  ', num2str(g_best(3)), ' -p ', num2str(g_best(2))]);
z= svmpredict(y,x,model);
end