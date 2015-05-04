function re=goldman(K,r,G,n,s,ov)
if 0.6*G*K+0.4*(K-ov)*(1+r)^n>(K-ov)*(1+r)^n
    re=-0.6*K*G+0.6*(K)*(1+r)^n;
else
    re=0;
end