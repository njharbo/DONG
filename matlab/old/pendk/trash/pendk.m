%Calculates payoff for gov from the pendk injection
function re=pendk(g, n, r, sp, sg, Knyoffert, Knyactual,ss)
if (1+g)^n*sp*Knyoffert>(1+r)^n*sp*Knyactual
    re=-(1+g)^n*sp*Knyoffert+(1+r)^n*(sp+sg-ss)*Knyactual;
else
    re=(1+r)^n*(sg-ss)*Knyactual;
end