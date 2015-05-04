%Calculates payoff for gov from the goldman injection
%K is injection in bn, r is yearly growth rate in DONGs value, n is #years
%G is the garanteed return on 60% of stocks, ov is option value
%s is share of stocks where gov has garanteed a minimum return
function [payment,stock,emmision, share]=statusquo(sand, initial, n, keep, r, inigovshare)
    payment=0;
    stock=(1+r)^n*(inigovshare*initial/(initial))*(sand);
    emmision=(1+r)^n*(sand)*((inigovshare*initial)/(initial)-keep);
    share=(inigovshare*initial)/(initial);
end