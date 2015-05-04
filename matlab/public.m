%Calculates payoff for gov from the goldman injection
%K is injection in bn, r is yearly growth rate in DONGs value, n is #years
%G is the garanteed return on 60% of stocks, ov is option value
%s is share of stocks where gov has garanteed a minimum return
function [payment,stock,emmision, share]=gs(sand, indskud, initial, n, keep, g,r, rgov, inigovshare)
   payment=-indskud*(1+rgov)^n;
   stock=(1+r)^n*((indskud+inigovshare*initial)/(initial+indskud))*(sand+indskud);
   emmision=(1+r)^n*(sand+indskud)*((indskud+inigovshare*initial)/(initial+indskud)-keep);
   share=(indskud+inigovshare*initial)/(initial+indskud);
end