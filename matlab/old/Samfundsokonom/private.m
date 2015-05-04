%Calculates payoff for gov from the private injection
%K is injection in bn, r is yearly growth rate in DONGs value, n is #years
%G is the garanteed return on 60% of stocks, ov is option value
%s is share of stocks where gov has garanteed a minimum return
function re=goldman(K,r,G,n,s,ov,var)
%if s*G*K+(1-s)*(K-ov)*(1+r)^n>(K-ov)*(1+r)^n
if G*K>(K-ov)*(1+r)^n+randn(1)*var
    re=-s*K*G+s*(K-ov)*(1+r)^n;
else
    re=0;
end