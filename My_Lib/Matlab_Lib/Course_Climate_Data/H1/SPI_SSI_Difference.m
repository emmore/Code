function SPI_SSI_Difference(Precip,Moisture)
scale=[3 6 12];
for i=1:length(scale)
    for j=1:2
        if j==1
            x=SPI_p_pan(Precip,scale(i));
            y=SPI_p_pan(Moisture,scale(i));
        else
            x=SPI_np_pan(Precip,scale(i));
            y=SPI_np_pan(Moisture,scale(i));
        end
       %Difference
        y=y((length(y)-length(x)+1):length(y),:);
        z=y-x;
        plot(z,'b','LineWidth',2);figure(gcf)
        ylim([-4 4])
        hline = refline([0 0]);
        set(hline,'Color','k')
        t=['mean=' num2str(nanmean(z)) '\nvariance=' num2str(nanvar(z))];
        legend(sprintf(t), 'Orientation', 'horizontal');
        xlabel([int2str(scale(i)) ' Month'])
        if j==1
            ylabel('SPI_{p} - SSI_p');
            saveas(gcf,['dif_p_' int2str(scale(i)) '.eps'],'epsc');
        else
            ylabel('SPI_{np} - SSI_np');
            saveas(gcf,['dif_np_' int2str(scale(i)) '.eps'],'epsc');
        end
        %Plot Together
        figure,
        hold on;
        h=zeros(2,2);
        h(:,1)=plot(x,'b','LineWidth',2);
        h(:,2)=plot(y,'r','LineWidth',2);
        box on;
        hline = refline([0 0]);
        set(hline,'Color','k');
        set(h(:,1),'Color','b');
        set(h(:,2),'Color','r');    
        legend(h(1,:),{'SPI_p','SSI_p'});
        xlabel([int2str(scale(i)) ' Month']);
        if j==1
            ylabel('SPI_{p} & SSI_p');
            saveas(gcf,['p_spi_ssi' int2str(scale(i)) '.eps'],'epsc'); 
        else
            ylabel('SPI_{np} & SSI_np');
            saveas(gcf,['np_spi_ssi' int2str(scale(i)) '.eps'],'epsc'); 
        end
        hold off;
    end
end
    