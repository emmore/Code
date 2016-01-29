function [mi au an]=information(data)
column=size(data,2);
input=data(:,1:(column-1));
output=data(:,column);
eo=entropy(output);
ei=entropy_ICA(input);
ea=entropy_ICA(data);
mi=eo+ei-ea;
au=ea-ei;
an=ea/(eo+ei);
end


 

