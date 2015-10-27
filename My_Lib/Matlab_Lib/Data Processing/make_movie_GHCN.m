function make_movie_GHCN(result)

for i=1:12
    year=1948+floor((i-1)/12);
    month=rem(i,12);
    if month==0
        month=12;
    end
    h=surf(result(:,:,i));
    set(h,'edgecolor','none');
    axis off;
    caxis([270,300])
%    colorbar;
    view([90,90]);
    strmax = ['Time = ',i];
    str=sprintf('%d-%d',year, month);
    title(str);
    saveas(gcf,[str 'ghcn' '.png']);
    m(i)=getframe;
end
movie2avi(m,'ex_movie2avi','compression','none');
end