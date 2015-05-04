%Calculates payoff from a public injection
%K is injection in bn, r is yearly growth rate in DONGs value, n is #years
%r_gov is the interest rate on government bonds
function re=kapital(K,r,n,r_gov)
re=(K)*(1+r)^n-K*(1+r_gov)^n;
end