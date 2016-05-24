function Model()
clc;
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/p_result.mat');
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/climate_index.mat');

%Input&Output Prepare    
k=1;
for i=1:length(p_result)
    if mod(i,12)<5 || mod (i,12)>10
        wp_result(k,:,:)=p_result(i,:,:);
        k=k+1;
    end
end
[COEFF,SCORE,latent]=LPCA_p(wp_result,0);


mpc=4;
Output=SCORE(:,1:mpc);
for i=1:mpc
    Mean_1(i)=mean(Output(:,i));
    Var_1(i)=var(Output(:,i));
    Output(:,i)=normalization_1(Output(:,i));
end
EstLength=ceil(length(Output)*0.85);
m_p=2;
m_i=1;

for j=1:length(Output)-max(m_p,m_i)
    for k=0:m_i
        Input(j,:)=[Input(j,:),index(j+k,[2,3,4])];
    end







eOutput=Output(1:EstLength,:);
vOutput=Output(EstLength+1:length(Output),:);
eInput=Input(1:EstLength,:);
vInput=Input(EstLength+1:length(Output),:);

%Simulation
for pc=1:mpc
    %Linear Model%
    leInput=[eInput ones(size(eInput,1),1)];
    lvInput=[vInput ones(size(vInput,1),1)];
    fac=inv(leInput'*leInput)*leInput'*eOutput;
    lseOutput=leInput*fac;
    lsvOutput=lvInput*fac;
    ssr_le=sqrt(mean((lseOutput-eOutput).^2));
    ssr_lv=sqrt(mean((lsvOutput-vOutput).^2));
    
    
    %ANN Model%
    
    
    
    
    
    
    
    
    
    %SVM Model%
     