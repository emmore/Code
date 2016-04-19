function result=PSO_SVM(pc)
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
    result{time}.select=rand(1,size(index,2))>0.75*ones(1,size(index,2));
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
    LE=ceil(length(O)*0.7);
    Ie=mapminmax(I(:,1:LE));
    Iv=mapminmax(I(:,LE+1:length(I)));
    Oe=mapminmax(O(1,1:LE));
    Ov=mapminmax(O(1,LE+1:length(O)));
    Ie=Ie';
    Iv=Iv';
    Oe=Oe';
    Ov=Ov';
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
            community{j}.p=[100 1].*rand(1,2);
            community{j}.v=0.2*[100,1].*rand(1,2);
            community{j}.best=community{j}.p;
			a=svmtrain(double(Oe),double(Ie),['-s 3 -t 2 -v 3 -p 0.1 -q -c ' num2str(community{j}.p(1)) ' -g '  num2str(community{j}.p(2))]);
            b=svmtrain(double(Ov),double(Iv),['-s 3 -t 2 -v 3 -p 0.1 -q -c ' num2str(community{j}.p(1)) ' -g '  num2str(community{j}.p(2))]);
            %a=sqrt(mean((svmpredict(double(Oe),double(Ie),model)-Oe).^2));
            %b=sqrt(mean((svmpredict(double(Ov),double(Iv),model)-Ov).^2));
            community{j}.performance=[a,b];
            community{j}.bperformance=[a,b];
            if community{j}.performance(1,1)<n_performance(1,1)%&&community{j}.performance(1,2)>n_performance(1,2)
               n_performance=community{j}.performance;
               g_best=community{j}.p;
            end
        end
        
        for t=1:T
            for j=1:N
                community{j}.v=community{j}.v+c1*rand*(community{j}.best-community{j}.p)+c2*rand*(g_best-community{j}.p);
                community{j}.p=community{j}.p+community{j}.v;
				community{j}.p(1)=max(community{j}.p(1),20);
				community{j}.p(2)=max(community{j}.p(2),0.01);
				a=svmtrain(double(Oe),double(Ie),['-s 3 -t 2 -v 3 -p 0.1 -q -c ' num2str(community{j}.p(1)) ' -g '  num2str(community{j}.p(2))]);
                b=svmtrain(double(Ov),double(Iv),['-s 3 -t 2 -v 3 -p 0.1 -q -c ' num2str(community{j}.p(1)) ' -g '  num2str(community{j}.p(2))]);
                community{j}.performance=[a,b];
                disp(community{j}.performance);
                if community{j}.performance(1,1)<community{j}.bperformance(1)%&&community{j}.performance(1,2)>community{j}.bperformance(2)
                    community{j}.bperformance=community{j}.performance;
                    community{j}.best=community{j}.p;
                    if community{j}.performance(1,1)<n_performance(1,1)%&&community{j}.performance(1,2)>n_performance(1,2)
                        n_performance=community{j}.performance;
                        g_best=community{j}.p;
                        if n_performance(1,1)<result{time}.performance(1,1)%&&n_performance(1,2)>result{time}.performance(1,2)
                            result{time}.performance=n_performance;
                            result{time}.p=g_best;
                        end
                    end
                end
            end  
        end
        x=result{time}.select;
        disp(x);
        disp(n_performance);
end
save('result.mat','result');
end
