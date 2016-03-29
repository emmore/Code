function [bestnet,bestselect,performance]=PSO_ANN(pc)
clc;
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/p_result.mat');
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/full_index.mat');
%%%%%%%%%Implement PCA to precipiation data%%%%%%%%%%%%%%
SCORE=LPCA_p(p_result,1);
m=6;%m is the input delaying length
LE=500;%parameter estimation period
%%%%%%%%%Select the pc(th) eof.
p=SCORE(:,pc);
performance=[-1,-1];
%%%%%%%%%Iteratively select inputs
for time=1:10
%%%%%%%%%Input Selection%%%%%%%%%%%%%
    select=rand(1,size(index,2))>0.75*ones(1,size(index,2));
    for i=1:size(select,2)
        if select(i)==1;
            p=[p index(:,i)];
        end
    end
    n=size(p,2);
%%%%%%%%%Input Preparation after selection%%%%%%%%%%%%%
    I=[];
    O=[];
    for i=1:length(p)-m-1
        input=reshape(p(i:i+m-1,:),[m*n,1]);
        output=p(i+m,1);
        I=[I,input];
        O=[O,output];
    end
    Ie=I(:,1:LE);
    Iv=I(:,LE+1:length(I));
    for i=1:size(Ie,1)
        Ie(i,:)=mapminmax(Ie(i,:));
        Iv(i,:)=mapminmax(Iv(i,:));
    end
    Oe=mapminmax(O(1,1:LE));
    Ov=mapminmax(O(1,LE+1:length(O)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% particle swarm optimizer for initial weights and b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Parameters for PSO%%%%%%%%%%%%%%%
    N=400;%number of particles in one community
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for neuron=10:2:24
        for j=1:N
            community{j}.w1=rand(neuron,m*n)-0.5;
            community{j}.w2=rand(1,neuron)-0.5;
            community{j}.b1=rand(neuron,1)-0.5;
            community{j}.b2=rand()-0.5;
            net=feedforwardnet(neuron);
            net.performParam.regularization =0.25;
            net.trainParam.showWindow=0;
            net.iw{1,1}=community{j}.w1;
            net.lw{2,1}=community{j}.w2;
            net.b{1}=community{j}.b1;
            net.b{2}=community{j}.b2;
            net = train(net,Ie,Oe);
            a=corrcoef(net(Ie),Oe);
            b=corrcoef(net(Iv),Ov);
            community{j}.performance=[a(1,2),b(1,2)];
            if community{j}.performance(1)>performance(1)&&community{j}.performance(2)>performance(2)
               performance=community{j}.performance;
               p_best=community{j};
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    net=feedforwardnet(15);
    net.performParam.regularization =0.25;
    net.trainParam.mu_max=1e10;
    net.trainParam.mu_inc=1.2;
    net.trainParam.showWindow=0;
    net = train(net,Ie,Oe);
    Ose=net(Ie);
    Osv=net(Iv);
end
end