%Calculates payoff for gov from the goldman injection
%K is injection in bn, r is yearly growth rate in DONGs value, n is #years
%G is the garanteed return on 60% of stocks, ov is option value
%s is share of stocks where gov has garanteed a minimum return
function [payment,stock,emmision, share]=gs(sand, indskud, initial, n, keep, g,r, inigovshare, var)
if (1+g)^n*0.6*indskud>0.6*indskud/(indskud+initial)*(sand+indskud)*(1+r)^n+randn(1)*var
   payment=-(1+g)^n*0.6*indskud-0.4*(1+r)^n*indskud;
   stock=(1+r)^n*((indskud+inigovshare*initial)/(initial+indskud))*(sand+indskud);
   emmision=(1+r)^n*(sand+indskud)*((indskud+0.8*initial)/(initial+indskud)-keep);
   share=(indskud+0.81*initial)/(initial+indskud);
else
    payment=0;
    stock=(1+r)^n*(inigovshare*initial/(initial+indskud))*(sand+indskud);
    emmision=(1+r)^n*(sand+indskud)*((inigovshare*initial)/(initial+indskud)-keep);
    share=(inigovshare*initial)/(initial+indskud);
end