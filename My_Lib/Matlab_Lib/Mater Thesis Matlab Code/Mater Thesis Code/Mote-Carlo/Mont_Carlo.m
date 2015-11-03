function [rain I ep r s]=Mont_Carlo(initials,initialep,day_a,dep_a,b)
rain=[0];
for i=1:4000
    z=exprnd(day_a);
    depth=exprnd(dep_a);
    for j=1:floor(z)
        rain=[rain;0.0];
    end
    rain=[rain;depth];
end

s=initials*ones(size(rain,1),1);
ep=0.01*initialep*ones(size(rain,1),1);
r=zeros(size(rain,1),1);
I=zeros(size(rain,1)-1,1);
for i=1:size(rain,1)-1
    if(rain(i)>0)
        a=(1+b)*(1-power(1-s(i),1/(1+b)));
        if(a+rain(i)>1+b)
            s(i+1)=1;
            I(i)=1-rain(i);
            r(i+1)=s(i)+rain(i)-1;
        else
            s(i+1)=s(i)+1-s(i)-power(1-(rain(i)+a)/(1+b),1+b);
            I(i)=1-rain(i)-power(1-(rain(i)+a)/(1+b),1+b);
            r(i+1)=max(0,rain(i)+s(i)-1+power(1-(rain(i)+a)/(1+b),1+b));
        end
    else
        if(s(i)<0)
            s(i+1)=0;
        else
            s(i+1)=s(i)*(1-ep(i));
        end
    end
end
end




        
        
        
    