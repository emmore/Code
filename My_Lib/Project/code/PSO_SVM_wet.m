function [result ,Oe, Ov]=PSO_SVM_wet(pc)
clc;
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/p_result.mat');
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/full_index.mat');
%%%%%%%%%Implement PCA to precipiation data%%%%%%%%%%%%%%
SCORE=LPCA_p(p_result,1);
m=6;%m is the input delaying length
%%%%%%%%%Select the pc(th) eof.
p=SCORE(:,pc);
%%%%%%%%%Iteratively select inputs
for time=1:3
    rng('shuffle');
%%%%%%%%%Input Selection%%%%%%%%%%%%%
    result{time}.select=rand(1,size(index,2))>0.5*ones(1,size(index,2));
    %result{time}.select(2)=1;
    result{time}.performance=[100 100];
    for i=1:size(result{time}.select,2)
        if result{time}.select(i)==1;
            p=[p index(:,i)];
        end
    end
    n=size(p,2);
%%%%%%%%%Input Preparation after selection%%%%%%%%%%%%%
    I=[];
    O=[];
    for i=1:length(p)-m-1
        if mod(i+m,12)<5 || mod(i+m,12)>10
            input=reshape(p(i:i+m-1,:),[m*n,1]);
            output=p(i+m,1);
            I=[I,input];
            O=[O,output];
        end
    end
    LE=ceil(length(O)*0.6);
    Ie=mapminmax(I(:,1:LE));
    Iv=mapminmax(I(:,LE+1:length(I)));
    Oe=mapminmax(O(1,1:LE));
    Ov=mapminmax(O(1,LE+1:length(O)));
%{
    I=mapminmax(I);
    O=mapminmax(O);
    Ie=I(:,1:LE);
    Iv=I(:,LE+1:length(I));
    Oe=mapminmax(O(1,1:LE));
    Ov=mapminmax(O(1,LE+1:length(O)));
%}
    
    Ie=Ie';
    Iv=Iv';
    Oe=flipud(Oe');
    Ov=flipud(Ov');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% particle swarm optimizer for initial weights and b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Parameters for PSO%%%%%%%%%%%%%%%
    N=100;%number of particles in one community
    c1=1.0;%rate of following community best
    c2=1.0;%rate of following historical best
    T=4;%iteration times
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear community;
    n_performance=[100,100];
    for j=1:N
            community{j}.p=[10 1].*rand(1,2);
            community{j}.v=0.2*[10,1].*rand(1,2);
            community{j}.best=community{j}.p; 
            model=svmtrain(double(Oe),double(Ie),['-s 3 -t 2  -g '  num2str(community{j}.p(2))  ' -c ' num2str(community{j}.p(1)) ' -p 0.3 -q ']);
            %a=sqrt(mean((svmpredict(double(Oe),double(Ie),model,'-q')-Oe).^2));
            %b=sqrt(mean((svmpredict(double(Ov),double(Iv),model,'-q')-Ov).^2));
            a=svmtrain(double(Oe),double(Ie),['-s 3 -t 2  -g '  num2str(community{j}.p(2))  ' -c ' num2str(community{j}.p(1)) ' -p 0.3 -v 10 -q ']); 
            b=1;
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
				community{j}.p(1)=min(max(community{j}.p(1),0),20);
				community{j}.p(2)=max(community{j}.p(2),0.000001); 
                
                model=svmtrain(double(Oe),double(Ie),['-s 3 -t 2  -g '  num2str(community{j}.p(2))  ' -c ' num2str(community{j}.p(1)) ' -p 0.3 -q ']);
                %a=sqrt(mean((svmpredict(double(Oe),double(Ie),model,'-q')-Oe).^2));
                %b=sqrt(mean((svmpredict(double(Ov),double(Iv),model,'-q')-Ov).^2));
                a=svmtrain(double(Oe),double(Ie),['-s 3 -t 2  -g '  num2str(community{j}.p(2))  ' -c ' num2str(community{j}.p(1)) ' -p 0.3 -v 10 -q ']); 
                b=1;
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
    if n_performance(1,1)<result{time}.performance(1,1)%&&n_performance(1,2)>result{time}.performance(1,2)
         result{time}.performance=n_performance;
         result{time}.p=g_best;
    end
    x=result{time}.select;
    disp(x);
    disp(n_performance);
    model=svmtrain(double(Oe),double(Ie),['-s 3 -t 2  -g '  num2str(g_best(2))  ' -c ' num2str(g_best(1)) ' -p 0.3 -q ']);
    result{time}.Ose=svmpredict(double(Oe),double(Ie),model,'-q');
    %model=svmtrain(double(Ov),double(Iv),['-s 3 -t 2 -p 0.1 -q -c ' num2str(result{time}.p(1)) ' -g '  num2str(result{time}.p(2))]);
    result{time}.Osv=svmpredict(double(Ov),double(Iv),model,'-q');
end
save('result.mat','result');
end
