function [c,sub,error]=UpdateCluster(c,sub)
error=inf;
if(not(isempty(c))&&(not(isempty(sub))))
    for i=1:size(c,2)
        trial=c{i};
        t=SubsequenceMatching(sub,trial.aver);
        trial.aver=(trial.aver+sub(t).content)/2;
        trial.member{end+1}=sub(t);
        trial.error=0;
        for k=1:size(trial.member,2)
            trial.error=trial.error+norm((trial.aver-trial.member{k}.content),2);
        end
        if error>trial.error
            c{i}=trial;
            i_BSF=i;
            error=trial.error;
            T=t;
        end
    end
    c{i_BSF}=trial;
    aa=sub(T).start;
    bb=sub(T).end;
    sub=sub(([sub.start]>aa | [sub.end]<bb));
end
end
    