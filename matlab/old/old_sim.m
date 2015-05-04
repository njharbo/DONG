
%simulate return over 250*4 days using the distribution of daily returns
%on listed Danish stocks
clear return_DNK_sim a nj
for j=1:10000
    for i=(1:1:1008)
        if i==1
        %a(i)=1+normrnd(mean_stocks,std_stocks);
        %a(i)=1+normrnd(mean_stocks,std_stocks);
        a(i)=1+x_DK_stocks(randi(length(x_DK_stocks),1));
        else
            %a(i)=a(i-1)*(1+normrnd(mean_stocks,std_stocks));
            a(i)=a(i-1)*(1+x_DK_stocks(randi(length(x_DK_stocks),1)));
        end 
    end
    if a(length(a))<0
        nj=0;
    else
        nj=a(length(a))^(1/4)-1;
    end
        return_DNK_sim(j)=goldman(11,nj,G,4,0.6)-kapital(11,nj,4, 0.01);
        j
end

mean(return_DNK_sim)*(1/(1+0.02)^4)
sum(return_DNK_sim>0)
mean((return_DNK_sim>0).*return_DNK_sim)
mean((return_DNK_sim<0).*return_DNK_sim)
