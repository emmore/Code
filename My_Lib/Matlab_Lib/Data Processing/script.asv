n=5;%number of PC
m=6;%m is the input number; m*n is the input size


p=SCORE(:,1:n);
for i=1:size(p,2)
    tempt=p(:,i);
    p(:,i)=(tempt-min(tempt))./(max(tempt)-min(tempt));
end


for i=1:length(p)-m-1
    

