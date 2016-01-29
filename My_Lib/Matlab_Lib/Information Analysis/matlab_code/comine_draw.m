function comine_draw(shortdata,longdata)
[m,n]=size(shortdata);
[p,q]=size(longdata);
[x,y]=meshgrid(1:n,1:m);
[xx,yy]=meshgrid(linspace(1,n,300),linspace(1,m,100));
new_data=griddata(x,y,data,xx,yy,'v4');

mesh(xx,yy,new_data);
shading interp;
axis([1 n 1 m 0.00  2.8]); 
ylabel('Previous Input Steps');
xlabel('Time Scale(1d)');
zlabel('Mutual Information(Nat)');
end