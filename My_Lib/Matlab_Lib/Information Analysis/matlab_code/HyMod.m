function [Q_s,performace]=HyMod(x,Q_o,parameter)
m=size(x,1);
P=x(:,1);
EP=x(:,2);
Q_s=ones(m,1);
[cmax,bexp,fQuickFlow,Rq,Rs]=parameter;
x_loss = 0.0;
% Initialize slow tank state
x_slow = 2.3503/(Rs*convFactor);
% Initialize state(s) of quick tank(s)
tanks = 3;
x_quick(1:tanks,1) = 0;
t = 1;
while t < m+1   
   % Compute excess precipitation and evaporation
   [UT1,UT2,x_loss] = excess(x_loss,cmax,bexp,P(t),EP(t));
   
   % Partition UT1 and UT2 into quick and slow flow component
%    UQ = fQuickFlow*UT2 + UT1; 
   UQ = fQuickFlow*(UT2 + UT1);
   US = (1-fQuickFlow)*(UT2 + UT1);
   
   % Route slow flow component with single linear reservoir
   inflow = US; 
   [x_slow,outflow] = linres(x_slow,inflow,Rs); 
   slow_outflow = outflow;
   
   % Route quick flow component with linear reservoirs
   inflow = UQ; 
   k = 1; 
   while k <= tanks
      [x_quick(k),outflow] = linres(x_quick(k),inflow,Rq); 
      inflow = outflow; 
      k = k+1;
   end
   quick_outflow = outflow;
   
   % Compute total flow for timestep
   output(t-iStart+1+wu,1) = (slow_outflow + quick_outflow)*convFactor;   
   t = t+1;   
end
dad=corrcoef(Q_o,Q_s);
performace=dad(2,1);
end
    
