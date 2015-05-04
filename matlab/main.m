clear all

sand=31.5;
indskud_gs=11;
initial_gs=31.5;
indskud_pd=8;
initial_pd=46;
n=4;
keep=0.51;
G=(1+0.0013+0.0225)*(1+0.0044+0.0225)*(1+0.0088+0.0225)*(1+0.0146+0.0225);
g=G^(1/4)-1;
rgov=0.01;
expinf=0.01;
inigovshare=0.81;

clear data
i=1
for r=-1:0.01:2
    data(i,1)=100*r;
    [data(i,2,1) data(i,2,2) data(i,2,3)]=pensdk(sand, indskud_pd, initial_pd, n, keep, g,r,inigovshare);
    [data(i,3,1) data(i,3,2) data(i,3,3)]=gs(sand, indskud_gs, initial_gs, n, keep, g,r,inigovshare);
    [data(i,4,1) data(i,4,2) data(i,4,3)]=public(sand, indskud_gs, initial_gs, n, keep, g,r,rgov,inigovshare);
    [data(i,5,1) data(i,5,2) data(i,5,3)]=statusquo(sand, initial_gs, n, keep, r,inigovshare);
    i=i+1;
end


%Figure illustrating the private and public deal
%Make figure under assumption of sand=31.5
nj=figure(1)
%subplot(2,1,1);
title('Statens absolutte afkast p? privat og offentlig aftale')
ylabel('Mia. DKK')
xlabel('?rlig vaekst i vaerdien af DONGs egenkapital, %')
axis([-30 30 -30 30])
hold on
plot(data(:,1), data(:,3,2)+data(:,3,1)-data(:,5,2)-data(:,5,1),'linestyle','--')
hold on
plot(data(:,1), data(:,4,2)+data(:,4,1)-data(:,5,2)-data(:,5,1),'linestyle','-')
legend('Privat','Offentlig','Location','SouthEast')
hold off
saveas(nj, 'figs/private_public_deal.pdf')

%Figure illustrating difference between the private and public deal
%Make figure under assumption of sand=31.5
nj=figure(1)
plot(data(:,1), data(:,3,1)+data(:,3,2)-data(:,4,1)-data(:,4,2))
hold on
title('Afkast paa statslig minus afkast paa privat aftale')
ylabel('Mia. DKK')
xlabel('?rlig vaekst i vaerdien af DONGs egenkapital, %')
refline(0,0)
axis([-30 30 -30 30])
saveas(nj, 'figs/private_less_public_deal.pdf')

%% Simulate and illustrate return of deal
sim=1000; %Number of simulations
simper=252*4; %Number of trading days simulated
exante=1*265; 
backwardinf=0.02;
infl=(1+backwardinf)^(1/252)-1; %
run stockdata.m;
vstart=24.5;
vspan=1;
vend=40.5;

clear return_elec_sim return_gasoil_sim a rsave r return_elec_pendk return_elec_gs return_elec_public penvgs_elec govvgs_elec penvgs_oil govvgs_oil

for j=1:sim
    
    for i=(1:1:simper)
        if i==1
            %a(i)=1+x_elec(randi(length(x_elec),1));
            a(i)=1+returns_elec(unidrnd(length(returns_elec)));
            b(i)=1+x_gasoil(randi(length(x_gasoil),1));
        else
            %a(i)=a(i-1)*(1+x_elec(randi(length(x_elec),1)));
            a(i)=a(i-1)*(1+returns_elec(unidrnd(length(returns_elec))));
            b(i)=b(i-1)*(1+x_gasoil(randi(length(x_gasoil),1)));
        end
        
        if a(i)<0
            a(i)=0;
        end
        
        if b(i)<0
            b(i)=0;
        end
        
    end
    
    r(1)=a(length(a))^(1/n)-1;
    r(2)=b(length(b))^(1/n)-1;
   
    k=1;
 for s=(vstart:vspan:vend)
        sand=s;  
        
        %European Energy stocks
        [return_elec_pendk(1,j,k) return_elec_pendk(2,j,k)]=pensdk(sand, indskud_pd, initial_pd, n, keep, g,r(1)+expinf,inigovshare);
        [return_elec_gs(1,j,k) return_elec_gs(2,j,k)]=gs(sand, indskud_gs, initial_gs, n, keep, g,r(1)+expinf,inigovshare);
        [return_elec_public(1,j,k) return_elec_public(2,j,k)]=public(sand, indskud_gs, initial_gs, n, keep, g,r(1)+expinf,rgov,inigovshare);
        [return_elec_statusquo(1,j,k) return_elec_statusquo(2,j,k)]=statusquo(sand, initial_gs, n, keep, r(1)+expinf,inigovshare);
        
        %Oil and gas
        [return_oil_pendk(1,j,k) return_oil_pendk(2,j,k)]=pensdk(sand, indskud_pd, initial_pd, n, keep, g,r(2)+expinf,inigovshare);
        [return_oil_gs(1,j,k) return_oil_gs(2,j,k)]=gs(sand, indskud_gs, initial_gs, n, keep, g,r(2),inigovshare);
        [return_oil_public(1,j,k) return_oil_public(2,j,k)]=public(sand, indskud_gs, initial_gs, n, keep, g,r(2)+expinf,rgov,inigovshare);
        [return_oil_statusquo(1,j,k) return_oil_statusquo(2,j,k)]=statusquo(sand, initial_gs, n, keep, r(2)+expinf,inigovshare);
        
        k=k+1;
 end

        j
        rsave(:,j)=[r(1), r(2)];
end


%% Figures from simulations

%Distribution of returns using electricity companies
%Make under assumption of sand=31.5
nj=figure(3)
subplot(2,1,1);
plot(data(:,1), data(:,3,1)+data(:,3,2)-data(:,4,1)-data(:,4,2))
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
axis([-60 60 0 500])
saveas(nj, 'figs/afkast_hist_combine_elec.pdf')

close all;

%Figure
%Distribution of returns using oilgas companies
%Make under assumption of sand=31.5
nj=figure(4)
subplot(2,1,1);
plot(data(:,1), data(:,3,1)+data(:,3,2)-data(:,4,1)-data(:,4,2))
refline(0,0)
title('Afkast af privat aftale minus offentlig aftale')
ylabel('Mia. DKK')
%xlabel('?rlig v?kst i v?rdien af DONGs egenkapital, %')
set(gca,'xlim',[-100 10])
axis([-60 60 -60 10])

%Figure
%Distribution of returns
%Make under assumption of sand=31.5
subplot(2,1,2);
hist(100*rsave(2,:),100)
title('Fordeling af aarlig vaekst, baseret paa Europaeiske olie- og gas-selskaber ')
ylabel('Antal')
xlabel('Aarlig vaekst i vaerdien af DONGs egenkapital, %')
set(gca,'xlim',[-100 10])
axis([-60 60 0 500])
saveas(nj, 'figs/afkast_hist_combine_oilgas.pdf')

nj=figure(5)
subplot(2,1,1);
hist(return_elec_gs(1,:,8)+return_elec_gs(2,:,8)-return_elec_public(1,:,8)-return_elec_public(2,:,8),100)
title('A. Elektricitetsselskaber')
axis([-100 10 0 2500])
subplot(2,1,2);hist(return_oil_gs(1,:,8)+return_oil_gs(2,:,8)-return_oil_public(1,:,8)-return_oil_public(2,:,8),100)
title('B. Olie- og gasselskaber')
axis([-100 10 0 2500])
saveas(nj, 'figs/sim_return.pdf')

%% TABLES from simulations

%Vector with mean returns on private deal
for h=1:length(vstart:vspan:vend)
    vector=return_elec_gs(1,:,h)+return_elec_gs(2,:,h)-return_elec_statusquo(1,:,h)-return_elec_statusquo(2,:,h);
    mean_private_elec(h)=mean(vector);
    std_private_elec(h)=var(vector)^(1/2);
    std_private_elec_pos(h)=var(vector.*(vector>0))^(1/2);
    std_private_elec_neg(h)=var(vector.*(vector<0))^(1/2);
    prob_private_elec(h)=sum(vector>0)/length(vector);
end
%Table on private deal
[vstart:vspan:vend; mean_private_elec; std_private_elec; std_private_elec_pos; std_private_elec_neg; prob_private_elec]'

%Vector with mean returns on public deal
for h=1:length(vstart:vspan:vend)
    vector=return_elec_public(1,:,h)+return_elec_public(2,:,h)-return_elec_statusquo(1,:,h)-return_elec_statusquo(2,:,h);
    mean_pub_elec(h)=mean(vector);
    std_pub_elec(h)=var(vector)^(1/2);
    std_pub_elec_pos(h)=var(vector.*(vector>0))^(1/2);
    std_pub_elec_neg(h)=var(vector.*(vector<0))^(1/2);
    prob_pub_elec(h)=sum(vector>0)/length(vector);
end
%Table on public deal
[vstart:vspan:vend; mean_pub_elec; std_pub_elec; std_pub_elec_pos; std_pub_elec_neg; prob_pub_elec]'

%Vector with mean relativ returns
for h=1:length(vstart:vspan:vend)
    vector=return_elec_gs(1,:,h)+return_elec_gs(2,:,h)-return_elec_public(1,:,h)-return_elec_public(2,:,h);
    mean_rel_elec(h)=mean(vector);
    std_rel_elec(h)=var(vector)^(1/2);
    std_rel_elec_pos(h)=var(vector.*(vector>0))^(1/2);
    std_rel_elec_neg(h)=var(vector.*(vector<0))^(1/2);
    prob_rel_elec(h)=sum(vector>0)/length(vector);
end
[vstart:vspan:vend; mean_rel_elec; std_rel_elec; prob_rel_elec]'


%http://se.mathworks.com/help/matlab/ref/table.html

[(vstart:vspan:vend)', (penvgs_elec)', (govvgs_elec)',(penvgs_oil)', (govvgs_oil)']
