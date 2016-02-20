function result=aggregate(data,scale)
result=[];
for i=1:scale,
    result=[result,data(i:length(data)-scale+i)];
end
result=sum(result,2);
end