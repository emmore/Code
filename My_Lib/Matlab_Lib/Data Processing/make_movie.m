function make_movie(result)

for i=1:length(result)
    year=1948+floor((i-1)/12);
    month=rem(i,12);
    if month==0
        month=12;
    end
    surf(squeeze(result(i,:,:)));
    axis off;
    caxis([0,15])
%    colorbar;
    view([0,90]);
    grid off;
    strmax = ['Time = ',i];
    str=sprintf('%d-%d',year, month);
    title(str);
    saveas(gcf,[str '.png']);
    m(i)=getframe;
end
movie2avi(m,'ex_movie2avi','compression','none');
end