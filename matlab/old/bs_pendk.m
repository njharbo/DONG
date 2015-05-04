%Set parameters
tm=4;
sigma=0.25;
r=0.01;
salesprice=153;
%salesprice=11*0.6;

G=(1+0.0013+0.0225)*(1+0.0044+0.0225)*(1+0.0088+0.0225)*(1+0.0146+0.0225);
%G=(1+0.02)^5
%G=1.08

% Black/Scholes will give you the option price per share
% Suppose the total number of shares is 100
% Then the equation that describes these values is:
% 100*sales price/share = 100*market value/share - 60*option price/share

%Initialise bisection method
pricelow=1
pricehigh=200 %
i=1
eval=10
clear evalsave priceeval pricehighsave pricelowsave save

i=1
%run bisection
%for nj=1:0.1:8
  while abs(eval)>0.001
    pricehighsave(i)=pricehigh
    pricelowsave(i)=pricelow
    priceeval(i)=(pricehigh+pricelow)*(1/2)
    %priceeval(i)=nj
    s=salesprice-priceeval(i);
    k=salesprice*G;
    d1=1/(sigma*(tm)^(1/2))*(log(s/k)+(r+sigma^2/2)*tm);
    d2=d1-sigma*(tm)^(1/2);
    priceupdate=cdf('norm',-d2,0,1)*k*exp(-r*(tm))-cdf('norm',-d1,0,1)*s;
    eval=priceupdate-priceeval(i);
    save(i)=eval;
    if eval>0
        pricelow=priceeval(i);
    else
        pricehigh=priceeval(i);
    end
    i=i+1;
 end
 
   %k is strikeprice
   %s is spotprice
            
       
