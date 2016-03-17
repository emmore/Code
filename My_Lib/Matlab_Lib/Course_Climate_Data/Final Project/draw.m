load('maxD_np');
load('maxI_np');
load('maxD_p');
load('maxI_p');
for i=1:4
surf(squeeze(maxD_p(i,:,:)),'EdgeColor','none');
caxis([0 20]);
view([90,-90]);
colorbar;
saveas(gcf,['maxD_p_' num2str(i)],'epsc');
surf(squeeze(maxI_p(i,:,:)),'EdgeColor','none');
caxis([0 20]);
view([90,-90]);
colorbar;
saveas(gcf,['maxI_p_' num2str(i)],'epsc');
surf(squeeze(maxD_np(i,:,:)),'EdgeColor','none');
caxis([0 20]);
view([90,-90]);
colorbar;
saveas(gcf,['maxD_np_' num2str(i)],'epsc');
surf(squeeze(maxI_np(i,:,:)),'EdgeColor','none');
caxis([0 20]);
view([90,-90]);
colorbar;
saveas(gcf,['maxI_np_' num2str(i)],'epsc');
end

%{
set(gca, 'XTick', []);
set(gca, 'YTick', []);
}%