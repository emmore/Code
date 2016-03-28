function [O,Oe,Os,Ov,perf]=trial_error_seperate(norm_pca,norm_ann,pc)
clc;
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/p_result.mat');
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/index.mat');
[COEFF,SCORE,latent]=LPCA_p(p_result,norm_pca);
n=1;%number of PC
m=6;%m is the input number; m*n is the input size
%L=30;%neuron number of middle layer
LE=500;%parameter estimation period
p=SCORE(:,pc:pc+n-1);
%%%%%%%%%
%p=[p mei];
q=nan(792,1);
for i=1:792
    q(i)=sin(pi*(i+2.5)/6);
end
p=[p q mei pna];
%p=[p,q,mei,pna]; %not so bas pc1 0.75
%p=[p amo ao mei nao nino12 nino3 pna soi wp];
%p=[p nao mei];
%%%%%%%%%
n=size(p,2);
if norm_ann==1
    for i=1:size(p,2)
        p(:,i)=normalization_1(p(:,i));
    end
elseif norm_ann==2
    for i=1:size(p,2)
        p(:,i)=normalization_2(p(:,i));
    end
end

 
pe=p(1:LE,:);
pv=p(LE+1:length(p),:);
I=[];
O=[];
for i=1:length(pe)-m-1
    input=reshape(pe(i:i+m-1,:),[m*n,1]);
    output=pe(i+m,1)';
    I=[I,input];
    O=[O,output];
end

Iv=[];
Ov=[];
for i=1:length(pv)-m-1
    input=reshape(pv(i:i+m-1,:),[m*n,1]);
    output=pv(i+m,1)';
    Iv=[Iv,input];
    Ov=[Ov,output];
end


net = feedforwardnet(45);
net.performParam.regularization =0.45;
net.trainParam.mu_max=2;
net.trainParam.mu_inc=1.2;
net = train(net,I,O);
Oe=net(I);
Os = net(Iv);
perf=perform(net,Ov,Os);