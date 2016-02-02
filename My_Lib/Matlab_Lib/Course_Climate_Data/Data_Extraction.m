function [Pmax,Paver,Taver,Tmax,Tmin]=Data_Extraction()
	data=xlsread('TempPrecip.xlsx');
	Precip=data(:,3);
	Temp=data(:,2);
	year=length(Precip)/12;
	
	Pmax=zeros(year,1);
	Paver=zeros(year,1);
	Taver=zeros(year,1);
	Tmax=zeros(year,1);
	Tmin=zeros(year,1);

	for i=1:year
		Pmax(i)=max(Precip((i-1)*12+1:i*12));
		Paver(i)=mean(Precip((i-1)*12+1:i*12));
		Tmax(i)=max(Temp((i-1)*12+1:i*12));
		Tmin(i)=min(Temp((i-1)*12+1:i*12));
		Taver(i)=mean(Temp((i-1)*12+1:i*12));
	end
end
