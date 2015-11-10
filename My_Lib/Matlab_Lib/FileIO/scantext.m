function result=scantext(filename)
fid=fopen(filename,'r');
c=textscan(fid,'%d %f %f %f %f %f %f %f %f %f %f %f %f',66,'HeaderLines',1,'emptyValue', NaN);
result=[];
for i=1:12
	result=[result c{i+1}];
end
result(result<-98)=0;
end



