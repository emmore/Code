function r=UniformScaling(z,w)
length=size(z,1);
r=ones(w,1);
if length==w
    r=z;
else
    for i=1:w
        r(i,1)=z(ceil(i*length/w),1);
    end
end
end



