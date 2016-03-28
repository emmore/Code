function [bestnet,bestselect,performance]=PSO_ANN(pc)
clc;
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/p_result.mat');
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/full_index.mat');
%%%%%%%%%Implement PCA to precipiation data%%%%%%%%%%%%%%
[COEFF,SCORE,latent]=LPCA_p(p_result,1);
m=6;%m is the input delaying length
LE=500;%parameter estimation period
%%%%%%%%%Select the pc(th) eof.
p=SCORE(:,pc);
performance=[-1,-1];
%%%%%%%%%Iteratively select inputs
for time=1:10
%%%%%%%%%Input Selection%%%%%%%%%%%%%
    select=rand(1,size(index,2))>0.9*ones(1,size(index,2));
    for i=1:size(select)
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
    
    net=feedforwardnet(15);
    net.performParam.regularization =0.25;
    net.trainParam.mu_max=1e10;
    net.trainParam.mu_inc=1.2;
    net.trainParam.showWindow=0;
    net = train(net,Ie,Oe);
    Ose=net(Ie);
    Osv=net(Iv);
end