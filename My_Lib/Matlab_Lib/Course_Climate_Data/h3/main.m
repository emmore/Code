function [h1,h2,h3,h4,h5,p1,p2,p3,p4,p5]=main()
	[Pmax,Paver,Taver,Tmax,Tmin]=Data_Extraction();
	h1=5*ones(5,1);
	p1=5*ones(5,1);

	[h1(1),p1(1)]=KS_Test(Pmax,'Normal');
	[h1(2),p1(2)]=KS_Test(Paver,'Normal');
	[h1(3),p1(3)]=KS_Test(Taver,'Normal');
	[h1(4),p1(4)]=KS_Test(Tmax,'Normal');
	[h1(5),p1(5)]=KS_Test(Tmin,'Normal');
	[h2,p2]=KS_Test(Pmax,'Gamma');
	[h3,p3]=KS_Test(Paver,'Gamma');

	[h4,p4]=KS_Test(Tmin,Tmax);
	[h5,p5]=KS_Test(Tmax,Pmax);
