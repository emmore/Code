Data=xlsread('TempPrecip.xlsx');
M=size(Data,1);
Y=M/12;
P_Max=zeros(Y,1);
P_s=zeros(Y,1);
T_Max=zeros(Y,1);
T_Aver=zeros(Y,1);
T_Min=zeros(Y,1);
for i=1:Y
    pmax=0;
    tmax=0;
    tmin=1000;
    m=(i-1)*12;
    for j=1:12
        if Data(m+j,3)>pmax
            pmax=Data(m+j,3);
        end
        if Data(m+j,2)>tmax
            tmax=Data(m+j,2);
        end
        if Data(m+j,2)<tmin
            tmin=Data(m+j,2);
        end
        P_s(i)=P_s(i)+Data(m+j,3);
        T_Aver(i)=T_Aver(i)/12.0+Data(m+j,2);
    end
    P_Max(i)=pmax;
    T_Max(i)=tmax;
    T_Min(i)=tmin;
end


s=0.01;
[z(1),t(1)]=MK(P_Max,s);
[z(2),t(2)]=MK(P_s,s);
[z(3),t(3)]=MK(T_Max,s);
[z(4),t(4)]=MK(T_Min,s);
[z(5),t(5)]=MK(T_Aver,s);

Draw(P_Max,'Annual Monthly Precipitation Maxima');
Draw(P_s,'Annual Precipitation');
Draw(T_Max,'Annual Monthly Temperature Maxima');
Draw(T_Aver,'Annual Temperature');
Draw(T_Min,'Annual Monthly Temperature Minima');


    