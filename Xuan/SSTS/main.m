function [p E]=main(sequence,w,f)
p={};
E=[];
sub=SubsequenceExtranction(sequence,w,f);
c={};
error=0;
while error ~= inf
    [c1,s1,error1]=CreateCluster(c,sub);
    [c2,s2,error2]=UpdateCluster(c,sub);
    [c3,s3,error3]=MergeCluster(c,sub);
    if error1<=error2 && error1<=error3
        c=c1;
        sub=s1;
        error=error1;
    else
        if error2<=error1 && error2<=error3
            c=c2;
            sub=s2;
            error=error2;
        else
            if error3<=error1 && error3<=error2
                c=c3;
                sub=s3;
                error=error3;
            end
        end
    end
    p{end+1}={c};
    E=[E error];
end
n=size(p,2);

for i=1:n
    m=size(p{i}{1},2);
    for j=1:m
        t=size(p{i}{1}{j}.member,2);
        cc=rand(1,3);
        for k=1:t
%            plot(p{i}{1}{j}.member{k}.start:p{i}{1}{j}.member{k}.end, sequence(p{i}{1}{j}.member{k}.start:p{i}{1}{j}.member{k}.end,:),color(j));
%            plot(p{i}{1}{j}.member{k}.start:p{i}{1}{j}.member{k}.end, sequence(p{i}{1}{j}.member{k}.start:p{i}{1}{j}.member{k}.end,:),'Color',[k/(1+t),k/(1+t),k/(1+t)]);
            plot(p{i}{1}{j}.member{k}.start:p{i}{1}{j}.member{k}.end, sequence(p{i}{1}{j}.member{k}.start:p{i}{1}{j}.member{k}.end,:),'Color',cc);
            hold on;
        end
    end
    name=num2str(i);
    saveas(gcf,[name '.png']);
    hold off;
end
end
