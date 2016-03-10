function statistics()
load('Intensity_Duration_np.mat');
disp('np loaded');
load('Intensity_Duration_p.mat');
disp('p loaded');
for i=1:67420
for j=1:4
mD_np(i,j)=max(DI_np{i}{j}{1});
mI_np(i,j)=max(-DI_np{i}{j}{2});
mD_p(i,j)=max(DI_p{i}{j}{1});
mI_p(i,j)=max(-DI_p{i}{j}{2});
MKD_np(i,j)=MK(DI_np{i}{j}{1});
MKI_np(i,j)=MK(DI_np{i}{j}{2});
MKD_p(i,j)=MK(DI_p{i}{j}{1});
MKI_p(i,j)=MK(DI_p{i}{j}{2});
end
end

load('real.mat');
disp('real loaded');
save('mD_np.mat','mD_np','-v7.3');
save('mI_np.mat','mI_np','-v7.3');
save('mD_p.mat','mD_p','-v7.3');
save('mI_p.mat','mI_p','-v7.3');
save('MKD_np.mat','MKD_np','-v7.3');
save('MKI_np.mat','MKI_np','-v7.3');
save('MKD_p.mat','MKD_p','-v7.3');
save('MKI_p.mat','MKI_p','-v7.3');
end