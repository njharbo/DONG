%Calculates payoff for gov from the goldman injection
%K is injection in bn, r is yearly growth rate in DONGs value, n is #years
%G is the garanteed return on 60% of stocks, ov is option value
%s is share of stocks where gov has garanteed a minimum return
function re=goldman(Knyactual,Knyoffert,r,g,n,sp,sg,ss)
if (1+g)^n*0.6*sp*Knyoffert>0.6*sp*(Knyactual)*(1+r)^n
   re=-(1+g)^n*0.6*sp*Knyoffert-0.4*(1+r)^n*sp*Knyactual+(1+r)^n*(sp+sg-ss)*Knyactual; 
else
    re=(1+r)^n*(sg-ss)*Knyactual;
end