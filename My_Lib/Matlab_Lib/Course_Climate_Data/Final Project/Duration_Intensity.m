function [Duration,Intensity]=Duration_Intensity(SPI)
threshould=0;
nSPI=find(SPI<=threshould);
if isempty(nSPI)
    Duration=NaN;
    Intensity=NaN;
else
    End_point=[nSPI(diff(nSPI)>1);nSPI(end)];
    Duration=diff([0;find(diff(nSPI)>1);length(nSPI)]);
    Intensity=[];
    for i=1:length(Duration)
        Intensity=[Intensity;sum(SPI(End_point(i)-Duration(i)+1:End_point(i)))];
    end
end
end