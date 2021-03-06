function [bestnet,bestselect,bestneuron,performance]=PSO_ANN(pc)
clc;
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/p_result.mat');
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/full_index.mat');
%%%%%%%%%Implement PCA to precipiation data%%%%%%%%%%%%%%
SCORE=LPCA_p(p_result,1);
m=6;%m is the input delaying length
LE=500;%parameter estimation period
%%%%%%%%%Select the pc(th) eof.
p=SCORE(:,pc);
g_performance=[-1,-1];
%%%%%%%%%Iteratively select inputs
for time=1:10
    performance(time,:)=[-1,-1];
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
    Ie=I(:,1:LE);d
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
    N=20;%number of particles in one community
    c1=1.1;%rate of following community best
    c2=1.1;%rate of following historical best
    T=30;%iteration times
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for neuron=15:15
        clear community;
        for j=1:N
            community{j}.w1=rand(neuron,m*n)-0.5;
            community{j}.w2=rand(1,neuron)-0.5;
            community{j}.b1=rand(neuron,1)-0.5;
            community{j}.b2=rand()-0.5;
            community{j}.r=rand();
            
            community{j}.vw1=0.2*(rand(neuron,m*n)-0.5);
            community{j}.vw2=0.2*(rand(1,neuron)-0.5);
            community{j}.vb1=0.2*(rand(neuron,1)-0.5);
            community{j}.vb2=0.2*(rand()-0.5);
            community{j}.vr=0.2*rand();
            
            community{j}.bw1=community{j}.w1;
            community{j}.bw2=community{j}.w2;
            community{j}.bb1=community{j}.b1;
            community{j}.bb2=community{j}.b2;
            community{j}.br=community{j}.r;
        
            net=feedforwardnet(neuron);
            net=configure(net,Ie,Oe);
            net.performParam.regularization =community{j}.r;
            net.trainParam.showWindow=0;
            net.iw{1,1}=community{j}.w1;
            net.lw{2,1}=community{j}.w2;
            net.b{1}=community{j}.b1;
            net.b{2}=community{j}.b2;
            net = train(net,Ie,Oe);
            a=corrcoef(net(Ie),Oe);
            b=corrcoef(net(Iv),Ov);
            community{j}.performance=[a(1,2),b(1,2)];
            community{j}.bperformance=[a(1,2),b(1,2)];
            if community{j}.performance(1,1)>performance(time,1)&&community{j}.performance(1,2)>performance(time,2)
               performance(time,:)=community{j}.performance;
               g_best=community{j};
            end
        end
        
        for t=1:T
            for j=1:N
                community{j}.vw1=community{j}.vw1+c1*rand*(community{j}.bw1-community{j}.w1)+c2*rand*(g_best.w1-community{j}.w1);
                community{j}.vw2=community{j}.vw2+c1*rand*(community{j}.bw2-community{j}.w2)+c2*rand*(g_best.w2-community{j}.w2);
                community{j}.vb1=community{j}.vb1+c1*rand*(community{j}.bb1-community{j}.b1)+c2*rand*(g_best.b1-community{j}.b1);
                community{j}.vb2=community{j}.vb2+c1*rand*(community{j}.bb2-community{j}.b2)+c2*rand*(g_best.b2-community{j}.b2);
                community{j}.vr=community{j}.vr+c1*rand*(community{j}.br-community{j}.r)+c2*rand*(g_best.r-community{j}.r);
                
                community{j}.w1=community{j}.vw1+community{j}.w1;
                community{j}.w2=community{j}.vw2+community{j}.w2;
                community{j}.b1=community{j}.vb1+community{j}.b1;
                community{j}.b2=community{j}.vb2+community{j}.b2;
                community{j}.r=min(max(community{j}.vr+community{j}.r,0.001),0.99);
                
                net=feedforwardnet(neuron);
                net=configure(net,Ie,Oe);
                net.performParam.regularization =community{j}.r;
                net.trainParam.showWindow=0;
                net.iw{1,1}=community{j}.w1;
                net.lw{2,1}=community{j}.w2;
                net.b{1}=community{j}.b1;
                net.b{2}=community{j}.b2;
                net = train(net,Ie,Oe);
                a=corrcoef(net(Ie),Oe);
                b=corrcoef(net(Iv),Ov);
                community{j}.performance=[a(1,2),b(1,2)];
                
                if community{j}.performance(1,1)>community{j}.bperformance(1)&&community{j}.performance(1,2)>community{j}.bperformance(2)
                    community{j}.bperformance=community{j}.performance;
                    community{j}.bw1=community{j}.w1;
                    community{j}.bw2=community{j}.w2;
                    community{j}.bb1=community{j}.b1;
                    community{j}.bb2=community{j}.b2;
                    community{j}.br=community{j}.r;
                    if community{j}.performance(1,1)>performance(time,1)&&community{j}.performance(1,2)>performance(time,2)
                        performance(time,:)=community{j}.performance;
                        g_best=community{j};
                    end
                end
            end  
        end
        if performance(time,1)>g_performance(1,1)&&performance(time,2)>g_performance(1,2)
            g_performance=performance(time,:);
            bestselect=select;
            bestnet=g_best;
            bestneuron=neuron;
        end
    end
    disp(g_performance);
end
end