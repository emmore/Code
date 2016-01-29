function [dd,corref]=ICA_LS(a,b)
a=[a(:,1:3) a(:,5) a(:,4)];
c=a(:,1:4);
d=a(:,5);
[result,A,W]=fastica(c');
z=regress(b,[result' d]);
[num nn]=size(W);
trans=[W',zeros(nn,1);zeros(1,num),1];
ddd=trans*z;
dd=[ddd(1:3,:);ddd(5,:);ddd(4,:)];
corref=corrcoef([result' d]*z,b);
end 
