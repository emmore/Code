function [yc,z,h,t]=clustering_draw(A)
A=zscore(A);
y=pdist(A,'Euclid');%计算欧氏距离
yc=squareform(y);
z=linkage(y);
[h,t]=dendrogram(z);%可视化聚类树