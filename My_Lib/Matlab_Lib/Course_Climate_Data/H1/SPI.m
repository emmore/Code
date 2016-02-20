function [x,y,z]=SPI(Data,scale)
str='SPI';
for i=1:length(scale)
    
    %plot parametric result
    x=SPI_p_pan(Data,scale(i));
    plot(x,'DisplayName','Z','YDataSource','Z','linewidth',2);figure(gcf)
    ylim([-4 4])
    hline = refline([0 0]);
    set(hline,'Color','k')
    xlabel([int2str(scale(i)) ' Month'])
    ylabel(str);
    t=['mean=' num2str(mean(x)) '\nvariance=' num2str(var(x))];
    legend(sprintf(t), 'Orientation', 'horizontal');
    saveas(gcf,['v_' str '_p_s' int2str(scale(i)) '.eps'],'epsc');
    
    %plot non-parametric result
    y=SPI_np_pan(Data,scale(i));
    plot(y,'DisplayName','Z','YDataSource','Z','linewidth',2);figure(gcf)
    ylim([-4 4])
    hline = refline([0 0]);
    set(hline,'Color','k')
    xlabel([int2str(scale(i)) ' Month'])
    ylabel(str);
    t=['mean=' num2str(nanmean(y)) '\nvariance=' num2str(nanvar(y))];
    legend(sprintf(t), 'Orientation', 'horizontal');
    saveas(gcf,['v_' str '_np_s' int2str(scale(i)) '.eps'],'epsc');
    
    
    
    %plot difference
    y=y((length(y)-length(x)+1):length(y),:);
    z=y-x;
    plot(z,'b','LineWidth',2);figure(gcf)
    ylim([-4 4])
    hline = refline([0 0]);
    set(hline,'Color','k')
    xlabel([int2str(scale(i)) ' Month'])
    ylabel([str '_{np}' '-' str '_p']);
    t=['mean=' num2str(mean(z)) '\nvariance=' num2str(var(z))];
    legend(sprintf(t), 'Orientation', 'horizontal');
    saveas(gcf,['v_' 'dif_' str '_' int2str(scale(i)) '.eps'],'epsc');
end

