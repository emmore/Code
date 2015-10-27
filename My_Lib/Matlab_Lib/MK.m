function r=MK(sequence)
l=size(sequence);
s=0;
for i=1:l-1
	for j=i+1:l
		s=s+sign(sequence(j)-sequence(i));
	end
end
var=l*(2*l+5)*(l-1)/18.0;
r=s/sqrt(var);
end
