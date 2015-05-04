%Calculates payoff for gov from the pendk injection
function [payment,stock,emmision, share]=pensdk(sand, indskud, initial, n, keep, g,r, inigovshare)
if (1+g)^n*indskud>(1+r)^n*(indskud/(initial+indskud))*(sand+indskud)
    payment=-(1+g)^n*indskud;
    stock=(1+r)^n*(sand+indskud)*((initial*inigovshare+indskud)/(initial+indskud));
    emmision=(1+r)^n*(sand+indskud)*((initial*inigovshare+indskud)/(initial+indskud)-keep);
    share=(initial*inigovshare+indskud)/(initial+indskud);
else
    payment=0;
    stock=(1+r)^n*(initial*inigovshare/(initial+indskud))*(sand+indskud);
    emmision=(1+r)^n*(sand+indskud)*(initial*inigovshare/(initial+indskud)-keep);
    share=(initial*inigovshare)/(initial+indskud);
end
