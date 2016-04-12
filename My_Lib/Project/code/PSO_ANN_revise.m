function result=PSO_ANN_revise(pc)
clc;
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/p_result.mat');
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/full_index.mat');
%%%%%%%%%Implement PCA to precipiation data%%%%%%%%%%%%%%
SCORE=LPCA_p(p_result,1);
m=6;%m is the input delaying length
%%%%%%%%%Select the pc(th) eof.
p=SCORE(:,pc);
%%%%%%%%%Iteratively select inputs
for time=1:1
%%%%%%%%%Input Selection%%%%%%%%%%%%%
    result{time}.select=rand(1,size(index,2))>2*ones(1,size(index,2));
    result{time}.performance=[-1 -1];
    for i=1:size(result{time}.select,2)
        if result{time}.select(i)==1;
            p=[p index(:,i)];
        end
    end
    n=size(p,2);
%%%%%%%%%Input Preparation after selection%%%%%%%%%%%%%
    I=[];
    O=[];
    for i=1:length(p)-m-1
%        if mod(i+m,12)<5 || mod(i+m,12)>10
            input=reshape(p(i:i+m-1,:),[m*n,1]);
            output=p(i+m,1);
            I=[I,input];
            O=[O,output];
%        end
    end
    LE=ceil(length(O)*0.7);
    Ie=mapminmax(I(:,1:LE));
    Iv=mapminmax(I(:,LE+1:length(I)));
    Oe=mapminmax(O(1,1:LE));
    Ov=mapminmax(O(1,LE+1:length(O)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% particle swarm optimizer for initial weights and b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Parameters for PSO%%%%%%%%%%%%%%%
    N=30;%number of particles in one community
    c1=1.0;%rate of following community best
    c2=1.0;%rate of following historical best
    T=30;%iteration times
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for neuron=16:3:25
        clear community;
        n_performance=[-1,-1];
        for j=1:N
            community{j}.p=rand(neuron*(m*n+2)+2,1)-0.5;
            community{j}.v=0.8*(rand(neuron*(m*n+2)+2,1)-0.5);
            community{j}.best=community{j}.p;
            net=feedforwardnet(neuron);
            net=configure(net,Ie,Oe);
            net.performParam.regularization =max(community{j}.p(end),0.4);
            net.iw{1,1}=reshape(community{j}.p(1:neuron*m*n,1),[neuron,m*n]);
            net.lw{2,1}=reshape(community{j}.p(neuron*m*n+1:neuron*m*n+neuron,1),[1,neuron]);
            net.b{1}=reshape(community{j}.p(neuron*m*n+neuron+1:neuron*m*n+2*neuron,1),[neuron,1]);
            net.b{2}=community{j}.p(neuron*m*n+2*neuron+1,1);
            net.trainParam.showWindow=0;
            net = train(net,Ie,Oe);
            a=corrcoef(net(Ie),Oe);
            b=corrcoef(net(Iv),Ov);
            community{j}.performance=[a(1,2),b(1,2)];
            community{j}.bperformance=[a(1,2),b(1,2)];
            if community{j}.performance(1,1)>n_performance(1,1)%&&community{j}.performance(1,2)>n_performance(1,2)
               n_performance=community{j}.performance;
               g_best=community{j}.p;
            end
        end
        
        for t=1:T
            for j=1:N
                community{j}.v=community{j}.v+c1*rand*(community{j}.best-community{j}.p)+c2*rand*(g_best-community{j}.p);
                community{j}.p=community{j}.p+community{j}.v;
                net=feedforwardnet(neuron);
                net=configure(net,Ie,Oe);
                net.performParam.regularization =min(max(community{j}.p(end),0.01),0.5);
                net.trainParam.showWindow=0;
                net.iw{1,1}=reshape(community{j}.p(1:neuron*m*n,1),[neuron,m*n]);
                net.lw{2,1}=reshape(community{j}.p(neuron*m*n+1:neuron*m*n+neuron,1),[1,neuron]);
                net.b{1}=reshape(community{j}.p(neuron*m*n+neuron+1:neuron*m*n+2*neuron,1),[neuron,1]);
                net.b{2}=community{j}.p(neuron*m*n+2*neuron+1,1);
                net = train(net,Ie,Oe);
                a=corrcoef(net(Ie),Oe);
                b=corrcoef(net(Iv),Ov);
                community{j}.performance=[a(1,2),b(1,2)];
                disp(community{j}.performance);
                if community{j}.performance(1,1)>community{j}.bperformance(1)%&&community{j}.performance(1,2)>community{j}.bperformance(2)
                    community{j}.bperformance=community{j}.performance;
                    community{j}.best=community{j}.p;
                    if community{j}.performance(1,1)>n_performance(1,1)%&&community{j}.performance(1,2)>n_performance(1,2)
                        n_performance=community{j}.performance;
                        g_best=community{j}.p;
                        if n_performance(1,1)>result{time}.performance(1,1)%&&n_performance(1,2)>result{time}.performance(1,2)
                            result{time}.performance=n_performance;
                            result{time}.neuron=neuron;
                            result{time}.p=g_best;
                        end
                    end
                end
            end  
        end
        disp(['neron number ' num2str(neuron)]);
        x=result{time}.select;
        disp(x);
        disp(n_performance);
    end
end
save('result.mat','result');k
end