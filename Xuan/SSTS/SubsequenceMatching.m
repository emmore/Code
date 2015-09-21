function num=SubsequenceMatching(sub,element)
distance=inf;
for i=1:size(sub,2)
    if norm(element-sub(i).content,2)<distance
        num=i;
        distance=norm(element-sub(i).content,2);
    end
end
end
