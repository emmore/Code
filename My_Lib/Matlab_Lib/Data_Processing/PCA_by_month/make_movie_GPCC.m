function make_movie_GPCC(result)

for i=560:580
    year=1901+floor((i-1)/12);
    month=rem(i,12);
    if month==0
        month=12;
    end
    h=surf(result(:,:,i));
    set(h,'edgecolor','none');
    axis off;
    caxis([0,300])
%    colorbar;
    view([90,90]);
    strmax = ['Time = ',i];
    str=sprintf('%d-%d',year, month);
    title(str);
    saveas(gcf,[str 'gpcc' '.png']);
    m(i)=getframe;
end
movie2avi(m,'ex_movie2avi','compression','none');
end