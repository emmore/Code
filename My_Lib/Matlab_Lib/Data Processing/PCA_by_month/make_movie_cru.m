function make_movie_cru(result)

for i=560:580
    year=1901+floor((i-1)/12);
    month=rem(i,12);
    if month==0
        month=12;
    end
    surf(result(:,:,i)');
    axis off;
    caxis([0,33])
%    colorbar;
    view([0,90]);
    grid off;
    strmax = ['Time = ',i];
    str=sprintf('%d-%d',year, month);
    title(str);
    saveas(gcf,[str 'cru_t' '.png']);
    m(i)=getframe;
end
movie2avi(m,'ex_movie2avi','compression','none');
end