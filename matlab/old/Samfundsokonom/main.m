clear all
%% Set parameters and load data
cita=[0.0013, 0.0044, 0.0088, 0.0146];
riskpremium=0.0225;
forwardinf=0.005;
backwardinf=0.02;
G=prod(cita+1+riskpremium-forwardinf);
s=0.6;
ov=0;
n=4;
K=11;
r_gov=0.01-forwardinf; %Real statsl?nerente
sim=10000; %Number of simulations
simper=252*4; %Number of trading days simulated
exante=1*265; %For dist of stockprices to end in 2013 
infl=(1+backwardinf)^(1/252)-1; %
vol=0;
run stockdata_new.m;

%% Calcute and Illustrate private and public deal

clear data
i=1
for r=-1:0.001:1
data(i,1)=100*r;
data(i,2)=public(K,r,n, r_gov);
data(i,3)=private(K,r,G,n,s, ov, vol);
i=i+1;
end
data(:,4)=data(:,3)-data(:,2);

%Figure illustrating the private and public deal
nj=figure(1)
%subplot(2,1,1);
plot(data(:,1), data(:,3))
title('Statens afkast af privat og offentlig aftale')
ylabel('Mia. DKK')
xlabel('?rlig v?kst i v?rdien af DONGs egenkapital, %')
axis([-30 30 -20 20])
hold on
plot(data(:,1), data(:,2),'linestyle','--')
legend('Privat','Offentlig','Location','SouthEast')
% subplot(2,1,2);
% plot(data(:,1), data(:,2))
% title('Statens afkast af offentlig aftale')
% ylabel('Mia. DKK')
% xlabel('?rlig v?kst i v?rdien af DONGs egenkapital, %')
% axis([-30 30 -20 20])
saveas(nj, 'figs/private_public_deal.png')

close all;

%Figure illustrating the dif between private and public deal.
nj=figure(2)
plot(data(:,1), data(:,4))
refline(0,0)
title('Afkast af privat aftale minus offentlig aftale')
ylabel('Mia. DKK')
xlabel('Aarlig vaekst i vaerdien af DONGs egenkapital, %')
axis([-30 30 -20 20])
saveas(nj, 'figs/private_less_public_deal.png')

hold on;

close all;

%% Simulate and illustrate return of deal


clear return_elec_sim return_gasoil_sim a rsave r
for j=1:sim
    for i=(1:1:simper)
        if i==1
            a(i)=1+x_elec(randi(length(x_elec),1));
            b(i)=1+x_gasoil(randi(length(x_gasoil),1));
        else
            a(i)=a(i-1)*(1+x_elec(randi(length(x_elec),1)));
            b(i)=b(i-1)*(1+x_gasoil(randi(length(x_gasoil),1)));
        end 
    end
    
    if a(length(a))<0
        r(1)=-(abs(a(length(a)-1))^(1/n)-1);
    else
        r(1)=a(length(a))^(1/n)-1;
    end
    
    if b(length(b))<0
        r(2)=-(abs(b(length(b)-1))^(1/n)-1);
    else
        r(2)=b(length(b))^(1/n)-1;
    end
    
        %European Energy stocks
        return_elec_sim(j)=private(K,r(1),G,n,s, ov, vol)-public(K,r(1),n, r_gov);
        return_elec_sim_off(j)=public(K,r(1),n, r_gov);
        return_elec_sim_privat(j)=private(K,r(1),G,n,s, ov, vol);
        
        %MSCI Energy stocks
        return_gasoil_sim(j)=private(K,r(2),G,n,s, ov, vol)-public(K,r(2),n, r_gov);
        return_gasoil_sim_off(j)=public(K,r(2),n, r_gov);
        return_gasoil_sim_privat(j)=private(K,r(2),G,n,s, ov, vol);
        
        j
        rsave(:,j)=[r(1), r(2)];
end

%Absolut returns
display('Mean, std and prob for electricity stocks. Public deal.')
mean(return_elec_sim_off)

var(return_elec_sim_off)^(1/2)
var(return_elec_sim_off.*(return_elec_sim_privat>0))^(1/2)
var(return_elec_sim_off.*(return_elec_sim_privat<0))^(1/2)

sum(return_elec_sim_off>0)/length(return_elec_sim_off)

display('Mean, std and prob for electricity stocks. Privat deal.')
mean(return_elec_sim_privat)

var(return_elec_sim_privat)^(1/2)
var(return_elec_sim_off.*(return_elec_sim_off>0))^(1/2)
var(return_elec_sim_off.*(return_elec_sim_off<0))^(1/2)

sum(return_elec_sim_privat>0)/length(return_elec_sim_privat)

display('Mean, std and prob for gasoil stocks. Public deal.')
mean(return_gasoil_sim_off)

var(return_gasoil_sim_off)^(1/2)
var(return_gasoil_sim_off.*(return_gasoil_sim_off>0))^(1/2)
var(return_gasoil_sim_off.*(return_gasoil_sim_off<0))^(1/2)

sum(return_gasoil_sim_off>0)/length(return_gasoil_sim_off)
display('Mean, std and prob for gasoil stocks. Private deal.')
mean(return_gasoil_sim_privat)

var(return_gasoil_sim_privat)^(1/2)
var(return_gasoil_sim_privat.*(return_gasoil_sim_privat>0))^(1/2)
var(return_gasoil_sim_privat.*(return_gasoil_sim_privat<0))^(1/2)

sum(return_gasoil_sim_privat>0)/length(return_gasoil_sim_privat)



%Relative returns
display('Mean, std and prob for electricity stocks. Relative')
mean(return_elec_sim)
var(return_elec_sim)^(1/2)
sum(return_elec_sim>0)/length(return_elec_sim)

display('Mean, std and prob for gasoil stocks. Relative.')
mean(return_gasoil_sim)
var(return_gasoil_sim)^(1/2)
sum(return_gasoil_sim>0)/length(return_gasoil_sim)

%Figure
nj=figure(3)
subplot(2,1,1);
plot(data(:,1), data(:,4))
refline(0,0)
title('Afkast af privat aftale minus offentlig aftale')
ylabel('Mia. DKK')
%xlabel('?rlig v?kst i v?rdien af DONGs egenkapital, %')
set(gca,'xlim',[-100 10])
axis([-60 60 -60 10])

subplot(2,1,2);
hist(100*rsave(1,:),100)
title('Fordeling af aarlig vaekst, baseret paa Europaeiske electricitets-selskaber ')
ylabel('Antal')
xlabel('Aarlig vaekst i vaerdien af DONGs egenkapital, %')
set(gca,'xlim',[-100 10])
axis([-60 60 0 50])
saveas(nj, 'figs/afkast_hist_combine_elec.png')

close all;

%Figure
nj=figure(4)
subplot(2,1,1);
plot(data(:,1), data(:,4))
refline(0,0)
title('Afkast af privat aftale minus offentlig aftale')
ylabel('Mia. DKK')
%xlabel('?rlig v?kst i v?rdien af DONGs egenkapital, %')
set(gca,'xlim',[-100 10])
axis([-60 60 -60 10])

subplot(2,1,2);
hist(100*rsave(2,:),100)
title('Fordeling af aarlig vaekst, baseret paa Europaeiske olie- og gas-selskaber ')
ylabel('Antal')
xlabel('Aarlig vaekst i vaerdien af DONGs egenkapital, %')
set(gca,'xlim',[-100 10])
axis([-60 60 0 50])
saveas(nj, 'figs/afkast_hist_combine_oilgas.png')





%% OLD
%Figure illustrating the dif between private and public deal.
%nj=figure(2)
[ax,p1,p2] =plotyy(data(700:1301,1), 1:(29/length(data(701:1301))):30, data(700:1301,1), data(700:1301,4))
set(p1, 'LineStyle', 'none')
%refline(0,0)
%title('Afkast af privat aftale minus statslig aftale')
%ylabel('Mia. DKK')
%xlabel('?rlig v?kst i v?rdien af DONGs egenkapital, %')
%set(gca,'xlim',[-100 10])
hold on
hist(100*rsave(1,:),100)
%title('A. Electricitetsselskaber')
%ylabel('Antal')
%xlabel('Gevinst i mia DKK')
%set(gca,'xlim',[-100 10])
%axis([-100 10 0 300])
