function result=main()
result=ones(365,6);
for i=30:5:100
    for j=0:5
        d=data(i,j);
        x=d(:,1:(j*3+2));
        y=d(:,j*3+3);
        result(i,(j+1))=MI(x,y);
    end
end
end