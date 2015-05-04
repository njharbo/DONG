%Main
clear all
sand=31.5;
Knyoffert_pendk=46+8;
Knyoffert_gs=31.5+11;
Knyactual_pendk=sand+8;
Knyactual_gs=sand+11;
sp_pendk=8/(46+8);
sg_pendk=0.8*46/(46+8);
sp_gs=11/(31.5+11);
sg_gs=0.8*31.5/(31.5+11);
g_pendk=0.025;
g_gs=0.0225;
n=4;
r=0.01;
sim=1000; %Number of simulations
simper=252*4; %Number of trading days simulated
exante=1*265; 
backwardinf=0.02;
infl=(1+backwardinf)^(1/252)-1; %
ss=0;
run ../samfundsokonom/stockdata_new.m;

clear data
i=1
for r=-1:0.001:1
    data(i,1)=100*r;
    data(i,2)=pendk(g_pendk, n, r, sp_pendk, sg_pendk, Knyoffert_pendk, Knyactual_pendk,ss);
    data(i,3)=goldman(Knyactual_gs,Knyoffert_gs,r,g_gs,n,sp_gs,sg_gs,ss);
    data(i,4)=pendk(g_pendk, n, r, sp_pendk, sg_pendk, Knyoffert_pendk, Knyactual_pendk,ss)-goldman(Knyactual_gs,Knyoffert_gs,r,g_gs,n,sp_gs,sg_gs,ss);
    i=i+1;
end

%Figure illustrating the private and public deal
nj=figure(1)
%subplot(2,1,1);
plot(data(:,1), data(:,2))
title('Vaerdi af statens stake i DONG')
ylabel('Mia. DKK')
xlabel('?rlig vaekst i vaerdien af DONGs egenkapital, %')
%axis([-30 30 -20 20])
hold on
plot(data(:,1), data(:,3),'linestyle','--')
legend('pendk','goldman','Location','SouthEast')
hold off
saveas(nj, 'figs/pendk_gs.pdf')

%Figure illustrating the private and public deal
nj=figure(1)
%subplot(2,1,1);
plot(data(:,1), data(:,4))
title('Pensionsdk - Goldman Sachs')
refline(0,0)
saveas(nj, 'figs/pendk_less_gs.pdf')

%% Simulate and illustrate return of deal
k=1;
for s=(26.5:5:61.5)
    
Knyoffert_pendk=45+6;
Knyoffert_gs=31.5+11;
Knyactual_pendk=s+8;
Knyactual_gs=s+11;
sp_pendk=8/(46+8);
sg_pendk=0.8*46/(46+8);
sp_gs=11/(31.5+11);
sg_gs=0.8*31.5/(31.5+11);
ss=0.0;

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
    
        %European Energy stocks
        
        return_elec_pendk(j,k)=pendk(g_pendk, n, r(1), sp_pendk, sg_pendk, Knyoffert_pendk, Knyactual_pendk,ss);
        return_elec_gs(j,k)=goldman(Knyactual_gs,Knyoffert_gs,r(1),g_gs,n,sp_gs,sg_gs,ss);
        return_elec_dif(j,k)=pendk(g_pendk, n, r(1), sp_pendk, sg_pendk, Knyoffert_pendk, Knyactual_pendk,ss)-goldman(Knyactual_gs,Knyoffert_gs,r(1),g_gs,n,sp_gs,sg_gs,ss);
        
        j;
        rsave(:,j)=[r(1)];
end
k=k+1;
end

%Absolut returns
%display('Mean, std and prob for electricity stocks. Public deal.')
for k=1:1:length(return_elec_dif(1,:))
mean(return_elec_dif(:,k))
end