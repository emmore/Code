function [yc,z,h,t]=clustering_draw(A)
A=zscore(A);
y=pdist(A,'Euclid');%����ŷ�Ͼ���
yc=squareform(y);
z=linkage(y);
[h,t]=dendrogram(z);%���ӻ�������