n=5;%number of PC
m=6;%m is the input number; m*n is the input size
L=20;%neuron number of middle layer.

p=SCORE(:,1:n);
for i=1:size(p,2)
    tempt=p(:,i);
    p(:,i)=(tempt-min(tempt))./(max(tempt)-min(tempt));
end

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
Os=sim(net,I);
