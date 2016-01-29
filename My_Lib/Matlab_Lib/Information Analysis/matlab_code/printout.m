function f=printout(label)
num=10;
previous=5;
rows=num*previous;
f=ones(rows,6);
f(:,1)=label;
for i=1:rows
    f(i,2)=i-1-previous*fix(i/(previous+0.00001));
    f(i,3)=ceil(i/previous);
end
for i=1:rows
    [f(i,4) f(i,5) f(i,6)]=information(readin(f(i,1),f(i,2),f(i,3)));
end
end

 