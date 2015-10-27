function [longitude,latitude,result]=Shapefile_cali(filename,target)
%boundary description
    %---------rectangle--------
    lon_max=-114-8.0/60;
    lon_min=-124-26.0/60;
    lat_min=32.533333333;
    lat_max=42.0;
    %---------slash-----------
    %slash=[start,end,position] 
    %position=-1 means keep the left; 
    %position=1 means keep the right; 
    slash1={[39 -120] [42 -120] -1};
    slash2={[39 -120] [34 -115] -1};
    slash={slash1 slash2};

 
%data readin 
    lon=ncread(filename,'lon');
    lat=ncread(filename,'lat');
    lon_scale=lon(2)-lon(1);
    lat_scale=lat(2)-lat(1);
    a=find(lon>=(lon_min-0.99*lon_scale)&lon<=(lon_max+0.99*lon_scale));
    b=find(lat>=(lat_min-0.99*lat_scale)&lat<=(lat_max+0.99*lat_scale));
    result=ncread(filename,target,[a(1) b(1) 1],[length(a) length(b) inf]);
%    result=ncread(filename,target);


%shape file
    % longitude & latitude  
    for i=1:length(a)
        longitude(i)=lon(a(i));
    end
    for i=1:length(b)
        latitude(i)=lat(b(i));
    end
    
    %----------triangle shape------------
    for i=1:size(slash,2)
        if slash{i}{1}(1)>slash{i}{2}(1)
            low=slash{i}{2};
            high=slash{i}{1};
        else
            low=slash{i}{1};
            high=slash{i}{2};
        end
        bb=find(latitude>=(low(1)-0.99*lat_scale)&latitude<=(high(1)+0.99*lat_scale));
        for j=bb(1):bb(end)
            for k=1:length(a)
                if ((latitude(j)-low(1))*(high(2)-low(2))-(high(1)-low(1))*(longitude(k)-low(2)))*slash{i}{3}>0
                    result(k,j,:)=NaN;
                end
            end
        end
    end    
end
 
 
            


