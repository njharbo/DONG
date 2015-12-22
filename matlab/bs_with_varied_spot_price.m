clear all;
K=11;
tm=4;
sigma=0.15;
r=0.01;
G=(1+0.0013+0.0225)*(1+0.0044+0.0225)*(1+0.0088+0.0225)*(1+0.0146+0.0225);
strike=G*K;
V_forhandlet=31.5;
counter=1;
stocks_emmission=102565361;
stocks_postmoney=396275261;
stocks_premoney=stocks_postmoney-stocks_emmission;

a_trade=107.5;

for i=20:1:40
    Value(counter)=i*10^9;
    spot(counter)=Value(counter)/stocks_premoney;
    ov(counter)=bash(spot(counter),a_trade*G,sigma,r,tm);
    aktie_handlet(counter)=a_trade-0.6*ov(counter);
    Dong_handlet(counter)=aktie_handlet(counter)*stocks_premoney;
    counter=counter+1;
end

[Value/10^9; spot; ov; aktie_handlet; Dong_handlet/10^9]'

[Value/10^9; spot*stocks_emmission/10^9; ov*0.6*stocks_emmission/10^9; spot*stocks_emmission/10^9+ov*0.6*stocks_emmission/10^9;; Dong_handlet/10^9]'

%Hvad investorerne kobte for 11 mia var 102565361 aktier og optioner paa 60% af disse aktier
%Saa for at finde prisen investorerne betalte for de 102565361 aktier
%behoever vi udregne og fratraekke prisen paa optionerne. For at udregne
%prisen paa optionerne behover vi dog kende spotprisen paa aktierne. Det goer
%vi ikke. Men hvis vi antager et span kan vi udregne vaerdien af optionerne
%for dette span. Goer vi dette kan vi finde den pris investorerne betale
%for aktierne ved at fraetrakke fra de 11 mia. 