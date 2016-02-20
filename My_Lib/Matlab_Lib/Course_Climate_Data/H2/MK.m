function [z,trend]=MK(data,sig)
s=0;
for i=1:length(data)-1
    for j=i+1:length(data)
        s=s+P_or_N(data(j)-data(i));
    end
end
sigma=sqrt(length(data)*(length(data)-1)*(2*length(data)+5)/18);
z=(s-P_or_N(s))/sigma;
trend=0;
if z<norminv(sig/2)
    trend=-1;
elseif z>norminv(1-sig/2)
    trend=1;
end
end


function y=P_or_N(x)
if x>0
    y=1;
else
    if x<0;
        y=-1;
    else
        y=0;
    end
end
end





            
        
            