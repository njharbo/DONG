%Calculates payoff for gov from the pendk injection
function re=pendk_n(sand, indskud, initial, n, keep, g,r)
if (1+g)^n*indskud>(1+r)^n*(indskud/(initial+indskud))*(sand+indskud)
    re=-(1+g)^n*indskud+(1+r)^n*((initial*0.8+indskud)/(initial+indskud)-ss)*(sand+indskud);
else
    re=(1+r)^n*(initial*0.8/(initial+indskud)-ss)*(sand+indskud);
end