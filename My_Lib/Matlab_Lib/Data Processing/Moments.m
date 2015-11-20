function [mean,variance]=Moments(data)
mean=zeros(12,size(data,2),size(data,3));
variance=zeros(12,size(data,2),size(data,3));
years=size(data,1)/12;
for i=1:size(data,1)
    month=mod(i,12);
    if month==0
        month=12;
    end
    mean(month,:,:)=mean(month,:,:)+data(i,:,:);
end
mean=mean./12;
for i=1:size(data,1)
    month=mod(i,12);
    if month==0
        month=12;
    end
    variance(month,:,:)=variance(month,:,:)+(data(i,:,:)-mean(month,:,:)).^2;
end
variance=variance/(years-1);
months=['Jan';'Feb'; 'Mar'; 'Apr' ;'May' ;'Jun'; 'Jul'; 'Aug'; 'Sep'; 'Oct' ;'Nov'; 'Dec'];
%draw%
for i=1:12
    surf(squeeze(mean(i,:,:)));
    axis off;
    caxis([-2.5,2.5]);
     colorbar;
    view([0,90]);
    grid off;
    title(months(i,:));
    saveas(gcf,['1948' ,'mean_',months(i,:), '.png']);
    
    
    surf(squeeze(variance(i,:,:)));
    axis off;
%    caxis([0,20]);
    colorbar;
    view([0,90]);
    grid off;
    title(months(i,:));
    saveas(gcf,['1948' ,'variance_',months(i,:), '.png']);
end




