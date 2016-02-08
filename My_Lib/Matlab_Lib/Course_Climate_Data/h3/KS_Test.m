function [h,p]=KS_Test(varargin)
	if ischar(varargin{2})
		ft=fitdist(varargin{1},varargin{2});
		[h,p]=kstest(varargin{1},'CDF',ft,'Alpha',0.05);
	else
		[h,p]=kstest2(varargin{1},varargin{2});	 
	end
end

