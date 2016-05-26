function [result_e,result_v,ssr_le,ssr_lv,ssr_svme,ssr_svmv,var_matrix_svm_e,var_matrix_svm_v,var_matrix_mean_e,var_matrix_mean_v,nash_e,nash_v]=PSO_SVM()
clc;
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/p_result.mat');
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/climate_index.mat');
 
%%%%%%%%%Implement PCA to precipiation data%%%%%%%%%%%%%%
[COEFF,SCORE,latent]=LPCA_p(p_result,0);
m=2;%m is the input delaying length

mpc=4;
for pc=1:mpc
%%%%%%%%%Select the pc(th) eof.
    p=SCORE(:,pc);
%%%%%%%%%Iteratively select inputs
%%%%%%%%%Input Selection%%%%%%%%%%%%%
    indexselect=[1,0,0,1,1,1,1,1,1,1,1];
    for i=1:length(indexselect)
        if indexselect(i)==1;
            p=[p index(:,i)];
        end
    end
    n=size(p,2);
%%%%%%%%%Input Preparation after selection%%%%%%%%%%%%%
    I=[];
    O=[];
    for i=1:length(p)-m-1
        if mod(i+m,12)<5|| mod(i+m,12)>10
            input=reshape(p(i:i+m-1,:),[m*n,1]);
            output=p(i+m,1);
            I=[I,input];
            O=[O,output];
        end
    end
    LE=ceil(length(O)*0.85);
    Ie=mapminmax(I(:,1:LE));
    Iv=mapminmax(I(:,LE+1:length(I)));
    %Adj_e(pc,:)=[min(O(1,1:LE)),max(O(1,1:LE))];
    %Adj_v(pc,:)=[min(O(1,LE+1:length(O))),max(O(1,LE+1:length(O)))];
    [Oe,pse(pc)]=mapminmax(O(1,1:LE));
    [Ov,psv(pc)]=mapminmax(O(1,LE+1:length(O)));
    Ie=Ie';
    Iv=Iv';
    Oe=Oe';
    Ov=Ov';
    
    %%%%%%%%%%%%%Linear Model%%%%%%%%%%%%%%%%%
    lIe=[Ie, ones(size(Ie,1),1)];
    lIv=[Iv, ones(size(Iv,1),1)];
    fac=(lIe'*lIe)\lIe'*Oe;
    lsOe=lIe*fac;
    lsOv=lIv*fac;
    ssr_le(pc)=sqrt(mean((lsOe-Oe).^2));
    ssr_lv(pc)=sqrt(mean((lsOv-Ov).^2));
    
    %%%%%%%%%%%%%SVM Model%%%%%%%%%%%%%%%%%%%%
    N=200;%number of particles in one community
    c1=1.0;%rate of following community best
    c2=1.0;%rate of following historical best
    T=4;%iteration times
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear community;
    n_performance=[100,100];
    for j=1:N
            community{j}.p(1)=2^(-10+j*15.0/N);
            community{j}.p(2)=2^(-14+j*12.0/N);
            community{j}.v(1)=0.05*community{j}.p(1);
            community{j}.v(2)=0.05*community{j}.p(2);
            community{j}.best=community{j}.p; 
            model=svmtrain(double(Oe),double(Ie),['-s 3 -t 2  -g '  num2str(community{j}.p(2))  ' -c ' num2str(community{j}.p(1)) ' -p 0.18 -q ']);
            a=sqrt(mean((svmpredict(double(Oe),double(Ie),model,'-q')-Oe).^2));
            b=sqrt(mean((svmpredict(double(Ov),double(Iv),model,'-q')-Ov).^2));
            community{j}.performance=[a,b];
            community{j}.bperformance=[a,b];
            if community{j}.performance(1,1)<n_performance(1,1)%&&community{j}.performance(1,2)<n_performance(1,2)
               n_performance=community{j}.performance;
               g_best=community{j}.p;
            end
     end
        
     for t=1:T
         for j=1:N
                community{j}.v=community{j}.v+c1*rand*(community{j}.best-community{j}.p)+c2*rand*(g_best-community{j}.p);
                community{j}.p=community{j}.p+community{j}.v;
				community{j}.p(1)=max(community{j}.p(1),15);
				community{j}.p(2)=max(community{j}.p(2),0.01); 
                
                a=svmtrain(double(Oe),double(Ie),['-s 3 -t 2  -g '  num2str(community{j}.p(2))  ' -c ' num2str(community{j}.p(1)) ' -p 0.18 -q -v 5']);
                %a=sqrt(mean((svmpredict(double(Oe),double(Ie),model,'-q')-Oe).^2));
                model=svmtrain(double(Oe),double(Ie),['-s 3 -t 2  -g '  num2str(community{j}.p(2))  ' -c ' num2str(community{j}.p(1)) ' -p 0.18 -q ']);
                b=sqrt(mean((svmpredict(double(Ov),double(Iv),model,'-q')-Ov).^2));
                 
                community{j}.performance=[a,b];
                disp(community{j}.performance);
                if community{j}.performance(1,1)<community{j}.bperformance(1)%&&community{j}.performance(1,2)>community{j}.bperformance(2)
                    community{j}.bperformance=community{j}.performance;
                    community{j}.best=community{j}.p;
                    if community{j}.performance(1,1)<n_performance(1,1)%&&community{j}.performance(1,2)>n_performance(1,2)
                        n_performance=community{j}.performance;
                        g_best=community{j}.p;
                    end
                end
        end  
    end
    model=svmtrain(double(Oe),double(Ie),['-s 3 -t 2  -g '  num2str(g_best(2))  ' -c ' num2str(g_best(1)) ' -p 0.18 -q ']);
    
    svmOe(:,pc)=svmpredict(double(Oe),double(Ie),model,'-q');
    svmOv(:,pc)=svmpredict(double(Ov),double(Iv),model,'-q');
    ssr_svme(pc)=sqrt(mean((svmOe(:,pc)-Oe).^2));
    ssr_svmv(pc)=sqrt(mean((svmOv(:,pc)-Ov).^2));
end
OE_SVM=[];
OV_SVM=[];
for pc=1:mpc
    %OE_SVM=[OE_SVM,svmOe(:,pc)*(tem1(2)-tem1(1))+tem1(1)];
    OE_SVM=[OE_SVM,mapminmax('reverse',svmOe(:,pc),pse(pc))];
    OV_SVM=[OV_SVM,mapminmax('reverse',svmOv(:,pc),psv(pc))];
    %OV_SVM=[OV_SVM,svmOv(:,pc)*(tem2(2)-tem2(1))+tem2(1)];
end
result_e=OE_SVM*COEFF(1:mpc,:);
result_v=OV_SVM*COEFF(1:mpc,:);

p=[];
for i=1:length(p_result)-m-1
    if mod(i+m,12)<5|| mod(i+m,12)>10
        d=p_result(i+m+1,:,:);
        d=d(d>=0);
        p=[p;d'];
    end
end

vvar_matrix_svm_e=zeros(length(result_e),1);
vvar_matrix_svm_v=zeros(length(result_v),1);
for i=1:length(result_e)
    vvar_matrix_svm_e(i)=mean(sqrt((result_e(:,i)-p(1:size(result_e,1),i)).^2));
    vvar_matrix_mean_e(i)=mean(sqrt((mean(p(1:size(result_e,1),i))-p(1:size(result_e,1),i)).^2));
    vvar_matrix_svm_v(i)=mean(sqrt((result_v(:,i)-p(size(result_e,1)+1:size(result_e,1)+size(result_v,1),i)).^2));
    vvar_matrix_mean_v(i)=mean(sqrt((mean(p(size(result_e,1)+1:size(result_e,1)+size(result_v,1),i))-p(size(result_e,1)+1:size(result_e,1)+size(result_v,1),i)).^2));
end

var_matrix_svm_e=nan(size(p_result,2),size(p_result,3));
var_matrix_svm_v=nan(size(p_result,2),size(p_result,3));
var_matrix_mean_e=nan(size(p_result,2),size(p_result,3));
var_matrix_mean_v=nan(size(p_result,2),size(p_result,3));
nash_e=nan(size(p_result,2),size(p_result,3));
nash_v=nan(size(p_result,2),size(p_result,3));

q=1;
for j=1:size(p_result,3)       
    for i=1:size(p_result,2)
        if not(isnan(p_result(10,i,j)))
            var_matrix_svm_e(i,j)=vvar_matrix_svm_e(q);
            var_matrix_svm_v(i,j)=vvar_matrix_svm_v(q);
            
            var_matrix_mean_e(i,j)=vvar_matrix_mean_e(q);
            var_matrix_mean_v(i,j)=vvar_matrix_mean_v(q);
            
            nash_e(i,j)=1-var_matrix_svm_e(i,j)^2/var_matrix_mean_e(i,j)^2;
            nash_v(i,j)=1-var_matrix_svm_v(i,j)^2/var_matrix_mean_v(i,j)^2;
            q=q+1;
        end
    end
end
end


