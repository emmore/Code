function [c,sub,error]=CreateCluster(c,sub)
error=inf;
if(size(sub,2)>2)
    %find motif x y and cluster the two.
    [first,second]=NMKMotif(sub);
    nc.aver=(sub(first).content+sub(second).content)/2;
    nc.member={sub(first) sub(second)};
    nc.error=norm(sub(first).content-nc.aver,2)+norm(sub(second).content-nc.aver,2);
    c{end+1}=nc;
    error=nc.error;
    %erase elements that contain x or y   %
    aa=nc.member{1}.start;
    bb=nc.member{1}.end;
    cc=nc.member{2}.start;
    dd=nc.member{2}.end;
    M=sort([aa bb cc dd]);
    sub=sub(([sub.end]<M(1))|([sub.start]>M(2) & [sub.end]<M(3)) | [sub.start]>M(4));
end
end









