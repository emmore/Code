function d=data(scale,previous)
[po epo qo]=textread('C:\Users\new\Desktop\11532500.dly','%f %f %f');
length=fix(size(po,1)/scale)-previous;
d=ones(length,(previous+1)*3);
for i=1:length
    for j=0:previous
        z=(i-1)*scale+j*scale;
        d(i,(3*j+1):3*(j+1))=[sum(po((z+1):(z+scale))) sum(epo((z+1):(z+scale))) sum(qo((z+1):(z+scale)))];
    end
end
end