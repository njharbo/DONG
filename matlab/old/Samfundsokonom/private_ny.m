%Calculates payoff for gov from the private injection
%K is injection in bn, r is yearly growth rate in DONGs value, n is #years
%G is the garanteed return on 60% of stocks, ov is option value
%s is share of stocks where gov has garanteed a minimum return
function re=goldman(K,r,G,n,s,ov,var, V0, VH, s0, KM)
%if s*G*K+(1-s)*(K-ov)*(1+r)^n>(K-ov)*(1+r)^n
%nj=0.8*31/(31+11)*(V0+11)-0.8*V0;
nj=(s0*VH/(VH+K+KM)*(V0+K+KM)-s0*V0)*(1+r)^n;
if G*K>(V0+K+KM)*K/(VH+K+KM)*(1+r)^n+randn(1)*var
    re=-s*K*G+s*(V0+K+KM)*K/(VH+K+KM)*(1+r)^n+nj;
else
    re=nj;
end

