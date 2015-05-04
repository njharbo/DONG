%Calculates payoff from a public injection
%K is injection in bn, r is yearly growth rate in DONGs value, n is #years
%r_gov is the interest rate on government bonds
function re=kapital(K,r,n,r_gov, V0, VH, s0, KM)
%re=((K+0.8*31)/(31+11)-0.8)*V0*(1+r)^n-K*(1+r_gov)^n;
re=(V0+K+KM)*(s0*VH+K)/(VH+K+KM)*(1+r)^n-s0*V0*(1+r)^n-K*(1+r_gov)^n;
end