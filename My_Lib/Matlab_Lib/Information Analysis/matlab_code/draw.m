function draw(data)
[m,n]=size(data);
[x,y]=meshgrid(1:n,1:m);
[xx,yy]=meshgrid(linspace(1,n,300),linspace(1,m,100));
new_data=griddata(x,y,data,xx,yy,'v4');

mesh(xx,yy,new_data);
shading interp;
axis([1 n 1 m 0.00  3.7]); 
xlabel('Previous Input Steps');
ylabel('Time Scale(10d)');
zlabel('MI(Q;P,EP,Q_{pre}) (Nat)');
end



