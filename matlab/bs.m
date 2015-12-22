clear all;
%Set parameters
tm=4;
sigma=0.20;
r=0.01;
salesprice=107.2486831;
%salesprice=11*0.6;

G=(1+0.0013+0.0225)*(1+0.0044+0.0225)*(1+0.0088+0.0225)*(1+0.0146+0.0225);

% Black/Scholes will give you the option price per share
% Suppose the total number of shares is 100
% Then the equation that describes these values is:
% 100*sales price/share = 100*market value/share - 60*option price/share

%Initialise bisection method
pricelow=1
pricehigh=60 %
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
    s=salesprice-priceeval(i)*0.6;
    k=salesprice*G;
    d1=1/(sigma*(tm)^(1/2))*(log(s/k)+(r+sigma^2/2)*tm);
    d2=d1-sigma*(tm)^(1/2);
    priceupdate=cdf('norm',-d2,0,1)*k*exp(-r*(tm))-cdf('norm',-d1,0,1)*s;
    eval=priceupdate-priceeval(i);
    save(i)=eval
    if eval>0
        pricelow=priceeval(i);
    else
        pricehigh=priceeval(i);
    end
    i=i+1;
  end
 
 (396275261-102565361)*86
  
   %k is strikeprice
   %s is spotprice
            
   
   %% GRatis option
   
 
%Set parameters
tm=4;
sigma=0.20;
r=0.01;
s=107.2486831;
G=(1+0.0013+0.0225)*(1+0.0044+0.0225)*(1+0.0088+0.0225)*(1+0.0146+0.0225);
k=107.2486831*G;

 d1=1/(sigma*(tm)^(1/2))*(log(s/k)+(r+sigma^2/2)*tm);
 d2=d1-sigma*(tm)^(1/2);
 value=cdf('norm',-d2,0,1)*k*exp(-r*(tm))-cdf('norm',-d1,0,1)*s;
 
 22.3*0.6*(102565361)
