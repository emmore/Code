function r=MK(sequence)
sequence=squeeze(sequence(sequence>=-100));
l=size(sequence,1);
s=0;
r=0;
var=l*(2*l+5)*(l-1)/18.0;
if l~=0
    for i=1:l-1
        for j=i+1:l
            s=s+sign(sequence(j)-sequence(i));
        end
    end
    r=s/sqrt(var);
end
end
