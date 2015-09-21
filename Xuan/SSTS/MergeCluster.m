function [c,sub,error]=MergeCluster(c,sub)
error=inf;
if(size(c,2)>2)
    for i=1:size(c,2)-1
        for j=i+1:size(c,2)
            c1=c{i};
            c2=c{j};
            c1.aver=(c1.aver+c2.aver)/2;
            c1.member=[c1.member c2.member];
            c1.error=0.0;
            for k=1:size(c1.member,2)
                 c1.error=c1.error+norm((c1.aver-c1.member{k}.content),2);
            end
            if error>c1.error
                cc=c1;
                l1=i;
                l2=j;
                error=c1.error;
            end
        end
    end
    c{l1}=cc;
    c(l2)=[];
end
end