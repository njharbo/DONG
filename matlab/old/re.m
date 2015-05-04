function r= re(K,r,g,n,s)
if K*(1+r)^n-K>s*K*(1+g)^n+(1-s)*K*(1+r)^n
    r=0
else
    r=-s*K*(1+g)^n+s*K*(1+r)^n-K*((1+r)^n-1)
end
end
    
%f=@(K,r,g,n,s) -s*K*(1+g)^n+s*K*(1+r)^n-K*((1+r)^n-1)
%r=(1/(1-s)-(s/(1-s))*(1+g)^n)^(1/n)-1