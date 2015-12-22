clear all;
%Set parameters
tm=4;
sigma=0.20;
r=0.01;
%salesprice=107.2486831;
%salesprice=11*0.6;
Vf=31.5;
K=11;
salesprice=11;

G=(1+0.0013+0.0225)*(1+0.0044+0.0225)*(1+0.0088+0.0225)*(1+0.0146+0.0225);

% Black/Scholes will give you the option price per share
% Suppose the total number of shares is 100
% Then the equation that describes these values is:
% 100*sales price/share = 100*market value/share - 60*option price/share

% Generelt kan man skrive vaerdien af investorernes kob s?ledes:
% K/(V_forhandlet+K)*(V_reel+K)+0.6*O=K
% Bemaerk at hvis V_forhandlet=V_reel s? forkorter dette til hvad vi har i vores papir. Hvis *ikke*, s? kan man antage at V_reel var lig med spot-prisen p? optionen. I s? fald, ved vi at 
% K/(V_forhandlet+K)*(V_reel+K)=K - 0.6*O
% Da O nu er en funktion af V_reel (igennem Black-Scholes) kan vi loese denne ligning numerisk i Matlab. Vi f?r dermed, 
% O=3.5737 mia.
% Hvormed
% 0.6*O=2.1442 mia.
% Dermed er
% K/(V_forhandlet+K)*(V_reel+K)= K - 2.1442 mia.
% Da vi kender K og V_forhandlet kan vi dermed faa
% V_reel=(V_forhandlet+K)/K*(K-0.6K)
% V_reel=23 mia.

%Initialise bisection method
pricelow=1;
pricehigh=15; %
i=1;
eval=10;

clear evalsave priceeval pricehighsave pricelowsave save

i=1;
%run bisection
%for nj=1:0.1:8
  while abs(eval)>0.001
    pricehighsave(i)=pricehigh;
    pricelowsave(i)=pricelow;
    priceeval(i)=(pricehigh+pricelow)*(1/2);
    s=K-0.6*priceeval(i);
    k=K*G;
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
 
  %Now back out the implicit market price for DONG
  (K-0.6*priceupdate)*(Vf+K)/K-K

