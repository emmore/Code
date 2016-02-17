n=5;%number of PC
m=6;%m is the input number; m*n is the input size
L=40;%neuron number of middle layer
LE=500;%parameter estimation period
LV=length(SCORE)-LE;%validataion period


p=SCORE(:,1:n);
for i=1:size(p,2)
    tempt=p(:,i);
    p(:,i)=(tempt-min(tempt))./(max(tempt)-min(tempt));
end

pe=p(1:LE,:);
pv=p(LE+1:length(p),:);

I=[];
O=[];
for i=1:length(p)-m-1
    input=reshape(p(i:i+m-1,:),[m*n,1]);
    output=p(i+m,:)';
    I=[I,input];
    O=[O,output];
end

R=repmat([0 1],m*n,1);
S=[L,n];
net=newff(R,S,{'tansig','purelin'});
net=train(net,I,O);

Iv=[];
Ov=[];
for i=1:length(pv)-m-1
    input=reshape(pv(i:i+m-1,:),[m*n,1]);
    output=pv(i+m,:)';
    Iv=[Iv,input];
    Ov=[Ov,output];
end

Os=sim(net,Iv);
