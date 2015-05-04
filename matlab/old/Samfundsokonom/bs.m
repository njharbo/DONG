clear all;
%Set parameters
tm=4;
sigma=0.15;
r=0.01;
salesprice=107.2486831;
opt_cover=0.6; %Share of emmision that put option covers
G=(1+0.0013+0.0225)*(1+0.0044+0.0225)*(1+0.0088+0.0225)*(1+0.0146+0.0225);
emmision=102565361; %Number of new shares
shares=396275261-emmision; %number of shares before emmision

% Black/Scholes will give you the option price per share
% Suppose the total number of shares is 100
% Then the equation that describes these values is:
% 100*sales price/share = 100*market value/share - 60*option price/share
%k is strikeprice
%s is spotprice


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
    s=salesprice-priceeval(i)*opt_cover;
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
 
  %Pris for option
  disp('Pris for en option i kroner')
  opt_cover*priceeval(length(priceeval))
  
  %pris for aktie
  disp('Pris for en aktie i kroner')
  s
  
  %Samlet pris for optioner
  disp('Sanlet pris for optioner')
  emmision*opt_cover*priceeval(length(priceeval))
  
 %Samlet v?rdians?ttelse af DONG f?r kapitaludvidelse
 disp('Pris for egenkapital f?r kapitaludvidelse')
 (shares)*s
             
   
   %% GRatis option
   
 
%Set parameters
tm=4;
sigma=0.15;
r=0.01;
s=107.2486831;
G=(1+0.0013+0.0225)*(1+0.0044+0.0225)*(1+0.0088+0.0225)*(1+0.0146+0.0225);
k=107.2486831*G;

 d1=1/(sigma*(tm)^(1/2))*(log(s/k)+(r+sigma^2/2)*tm);
 d2=d1-sigma*(tm)^(1/2);
 value=cdf('norm',-d2,0,1)*k*exp(-r*(tm))-cdf('norm',-d1,0,1)*s;
 
 value*0.6*(102565361)
