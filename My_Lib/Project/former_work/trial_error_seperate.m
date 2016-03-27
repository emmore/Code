function [O,Oe,Os,Ov,perf]=trial_error_seperate(norm_pca,norm_ann,pc)
load('/Users/penn/Documents/Code/Github/My_Lib/Matlab_Lib/Data Processing/result.mat');
load('pna.mat');
[COEFF,SCORE,latent]=LPCA_p(p_result,norm_pca);
n=5;%number of PC
m=12;%m is the input number; m*n is the input size
mm=4;%mm is the input length of indices
%L=30;%neuron number of middle layer
LE=500;%parameter estimation period
p=SCORE(:,1:n);
%%%%%%%%%
pna=pna(1:length(p),:);
pna=(mapminmax(pna'))';
pnae=pna(1:LE);
pnav=pna(LE+1:length(p),:);
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
    tpna=pnae(i+m-mm:i+m-1);
    output=pe(i+m,:)';
    I=[I,[input;tpna]];
    O=[O,output];
end
O=O(pc,:);

Iv=[];
Ov=[];
for i=1:length(pv)-m-1
    input=reshape(pv(i:i+m-1,:),[m*n,1]);
    tpna=pnae(i+m-mm:i+m-1);
    output=pv(i+m,:)';
    Iv=[Iv,[input;tpna]];
    Ov=[Ov,output];
end
Ov=Ov(pc,:);


net = feedforwardnet(10);
net.performParam.regularization =0.01;
net = train(net,I,O);
Oe=net(I);
Os = net(Iv);
perf=perform(net,Ov,Os);