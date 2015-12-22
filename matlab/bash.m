function [v]=bash(spot,strike,sigma,r,tm)
    d1=1/(sigma*(tm)^(1/2))*(log(spot/strike)+(r+sigma^2/2)*tm);
    d2=d1-sigma*(tm)^(1/2);
    v=cdf('norm',-d2,0,1)*strike*exp(-r*(tm))-cdf('norm',-d1,0,1)*spot;
end