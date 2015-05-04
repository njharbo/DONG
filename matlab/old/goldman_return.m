function re=goldman_return(K,r,G,n,s, r_alt)
if 0.6*G+0.4*(1+r)^n>(1+r)^n
    re=K*0.6*G+0.4*K*(1+r)^n-K*(1+r_alt)^n;
else
    re=K*(1+r)^n-K*(1+r_alt)^n;
end