function  Final_draw(id)
set(gca,'FontSize',16);
%data focsed
mi=['mi' id];
en_ab=['e',id];
load('matlab',mi);
load('matlab',en_ab);
MI=eval(mi);
EN_ABS=eval(en_ab);
EN_RL=ones(36,1);
for i=10:10:360
    EN_RL(i/10)=EN_ABS(i/10)+1.44*log(10/i);
end
data=MI;
 

diff_ep=data(:,8:14)-data(:,1:7);
n4=[id 'diff_ep'];
[x,y]=meshgrid(1:7,10:10:360);
[xx,yy]=meshgrid(linspace(1,7,28),linspace(10,360,144));
new_diff_ep=griddata(x,y,diff_ep,xx,yy,'v4');
surf(xx,yy,new_diff_ep,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
shading interp;
axis([1 7 10 360  0.0  2]); 
xlabel('Input Steps');
ylabel('Temporal Scale /d');
zlabel('I(R;P,PE)-I(R;P) /bit');
view([0,90]);
colorbar;
savefig([n4 '.fig']);

diff_q=data(:,15:21)-data(:,8:14);
n5=[id 'diff_q'];
[x,y]=meshgrid(1:7,10:10:360);
[xx,yy]=meshgrid(linspace(1,7,28),linspace(10,360,144));
new_diff_q=griddata(x,y,diff_q,xx,yy,'v4');
surf(xx,yy,new_diff_q,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
shading interp;
axis([1 7 10 360  0.0  2]); 
xlabel('Input Steps');
ylabel('Temporal Scale /d');
zlabel('I(R;P,PE,R_{former})-I(R;P,PE) /bit');
view([0,90]);
colorbar;
savefig([n5 '.fig']);

tmp=data(:,1:7);
p=[];
for i=1:6
    p(:,i)=tmp(:,i+1)-tmp(:,i);
end
n6=[id 'pdiff_former'];
[x,y]=meshgrid(1:6,10:10:360);
[xx,yy]=meshgrid(linspace(1,6,28),linspace(10,360,144));
new_p=griddata(x,y,p,xx,yy,'v4');
surf(xx,yy,new_p,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
shading interp;
axis([1 6 10 360  0.0  2]); 
xlabel('Input Steps');
ylabel('Temporal Scale /d');
zlabel('I(R;P) /bit');
view([0,90]);
colorbar;
savefig([n6 '.fig']);

tmp=data(:,8:14);
p=[];
for i=1:6
    p(:,i)=tmp(:,i+1)-tmp(:,i);
end
n7=[id 'epdiff_former'];
[x,y]=meshgrid(1:6,10:10:360);
[xx,yy]=meshgrid(linspace(1,6,28),linspace(10,360,144));
new_p=griddata(x,y,p,xx,yy,'v4');
surf(xx,yy,new_p,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
shading interp;
axis([1 6 10 360  0.0  2]); 
xlabel('Input Steps');
ylabel('Temporal Scale /d');
zlabel('I(R;P) /bit');
view([0,90]);
colorbar;
savefig([n7 '.fig']);

tmp=data(:,15:21);
p=[];
for i=1:6
    p(:,i)=tmp(:,i+1)-tmp(:,i);
end
n8=[id 'qdiff_former'];
[x,y]=meshgrid(1:6,10:10:360);
[xx,yy]=meshgrid(linspace(1,6,28),linspace(10,360,144));
new_p=griddata(x,y,p,xx,yy,'v4');
surf(xx,yy,new_p,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
shading interp;
axis([1 6 10 360  0.0  2]); 
xlabel('Input Steps');
ylabel('Temporal Scale /d');
zlabel('I(R;P) /bit');
view([0,90]);
colorbar;
savefig([n8 '.fig']);

%model focsed
mingzi=['data' id];
load('matlab',mingzi);
zzz=[id 'MI'];
data=eval(mingzi);
x=10:10:360;
tp=data(:,2);
cs=data(:,3);
by=data(:,4);
plot(x,cs,':o',x,tp,':^',x,by,':+');
xlim([10 360]);
xlabel('Temporal Scale/d');
ylabel('MI/bit');
lgnd = legend('TPWB(StateVariable+Input)','TPWB(Simulation)','Buydyko(Simulation)');
set(lgnd,'color','none');

title(['ID=' id]);
savefig([zzz '.fig']);

%AU
mi=['mi' id];
load('matlab',mi);
MI=eval(mi);
data=MI;
en_r=EN_RL*ones(1,7);

p=en_r-data(:,1:7);
n1=[id 'p_rela'];
[x,y]=meshgrid(1:7,10:10:360);
[xx,yy]=meshgrid(linspace(1,7,28),linspace(10,360,144));
new_p=griddata(x,y,p,xx,yy,'v4');
surf(xx,yy,new_p,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
shading interp;
axis([1 7 10 360  0.0  2]); 
xlabel('Input Steps');
ylabel('Temporal Scale /d');
zlabel('I(R;P) /bit');
view([0,90]);
colorbar;
savefig([n1 '.fig']);


ep=en_r-data(:,8:14);
n2=[id 'pep_rela'];
[x,y]=meshgrid(1:7,10:10:360);
[xx,yy]=meshgrid(linspace(1,7,28),linspace(10,360,144));
new_ep=griddata(x,y,ep,xx,yy,'v4');
surf(xx,yy,new_ep,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
shading interp;
axis([1 7 10 360  0.0  2]); 
xlabel('Input Steps');
ylabel('Temporal Scale /d');
zlabel('I(R;P,PE) /bit');
view([0,90]);
colorbar;
savefig([n2 '.fig']);


pepq=en_r-data(:,15:21);
n3=[id 'pepq_rela'];
[x,y]=meshgrid(1:7,10:10:360);
[xx,yy]=meshgrid(linspace(1,7,28),linspace(10,360,144));
new_pepq=griddata(x,y,pepq,xx,yy,'v4');
surf(xx,yy,new_pepq,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
shading interp;
axis([1 7 10 360  0.0  2]); 
xlabel('Input Steps');
ylabel('Temporal Scale /d');
zlabel('I(R;P,PE,R_{former}) /bit');
view([0,90]);
colorbar;
savefig([n3 '.fig']);




%EU
data=eval(mingzi);
name=['mi' id];
load('matlab',name);
mi=eval(name);
input=max(mi,[],2);

x=10:10:360;
 
tp=data(:,2);
by=data(:,4);
plot(x,(input-tp),'--*',x,(input-by),':o');
xlim([10 360]);
xlabel('Temporal Scale /d');
ylabel('Epistemic Uncertainty /bit');
lgnd = legend('EU_{TPWB}','EU_{Budyko}');
set(lgnd,'color','none');
savefig([id 'EU' '.fig']);
end