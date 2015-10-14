(* PARAMETER INITIALIZATION *)
	(* Rainfall Parameters *)
		T=0.2 (* T is the frequency of precipitation. e.g. T=0.2 means there is rainfall event every 5 days averagely *)
		alpha=0.2 (* alpha is the mean depth of precipitation (normalized to (0 1)). e.g. alpha=0.2 means the average rainfall depth is 0.2 *)

		N=100 (* total amount of rainfall events to be simulated *)

	(* Evapotranspiration Parameters *)
		k=0.1; (* k is the evapotranspiration rate. s(t+1)=s(t)*(1-k) when there being no rainfall *)

	(* Soil Moisture Parameters *)
		s0=0.3;


(* Rainfall Generation *)
	Rdepth=RandomVariate[ExponentialDistribution[1/alpha],N];
	Rinterval=RandomVariate[ExponentialDistribution[T],N];
	


(* Soil Moisture & Evapotranspiration Iterative Calculation *)


