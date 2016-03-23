function result=Index_Similarity(index1,index2)
st=max(index1(1,1),index2(1,1));
en=min(index1(end,1),index2(end,1));
index1=index1(find(index1(:,1)==st):find(index1(:,1)==en),2:13);
index2=index2(find(index2(:,1)==st):find(index2(:,1)==en),2:13);
index1(index1<-99)=0;
index2(index2<-99)=0;
[a,b]=size(index1);
index1=reshape(normalization_2(reshape(index1,[a*b,1])),[a,b]);
[a,b]=size(index2);
index2=reshape(normalization_2(reshape(index2,[a*b,1])),[a,b]);
result=norm(index2-index1)/(en-st+1);
end
