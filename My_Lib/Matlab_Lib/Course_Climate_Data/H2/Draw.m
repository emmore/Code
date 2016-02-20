function Draw(data,name)
    plot(data,'linewidth',2);
    hline = refline([0 mean(data)]);
    set(hline,'Color','k')
    xlabel('Year');
    ylabel(name);
    axis([0,109,min(data),max(data)]);
    set(gca,'XTickLabel',1901:20:2009);
    %t=['mean=' num2str(mean(P_Max)) '\nvariance=' num2str(var(P_Max)) '\nMK=' num2str(MK(P_Max,0.05))];
    %legend(sprintf(t), 'Orientation', 'horizontal');
    [z,t]=MK(data,0.05);
    if t<0
        str='Significant Decreasing Trend';
    elseif t==0
        str='No Significant Trend';
    else
        str='Significant Increasing Trend';
    end
    %{
    dim = [.3 .5 .6 .4];
    annotation('textbox',dim,'String',str,'FitBoxToText','on');
    %}
    saveas(gca,[name '.eps'],'epsc');
end