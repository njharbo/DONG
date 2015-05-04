%% Simulate and illustrate return of deal, nye files
V0=24;
VH=31.5;
VHpub=V0;
s0=0.81;
sim=10000;
KM=0;

%V0val=[31.5, 30, 28, 26, 24]

clear return_elec_sim return_new_elec_sim return_new_gasoil_sim a rsave r save


%for h=1:length(VHval)
%    V0=V0val(h);
    
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
        return_new_elec_sim(j)=private_ny(K,r(1),G,n,s, ov, vol, V0, VH, s0, KM)-public_ny(K,r(1),n, r_gov, V0, VHpub, s0, KM);
        %return_new_elec_sim_off(j)=public_ny(K,r(1),n, r_gov, V0, VHpub, s0);
        %return_new_elec_sim_privat(j)=private_ny(K,r(1),G,n,s, ov, vol, V0, VH, s0);
        
     
        %MSCI Energy stocks
        return_new_gasoil_sim(j)=private_ny(K,r(2),G,n,s, ov, vol, V0, VH, s0, KM)-public_ny(K,r(2),n, r_gov, V0, VHpub, s0, KM);        %return_gasoil_sim_off(j)=public(K,r(2),n, r_gov);
        
        j
        rsave(:,j)=[r(1), r(2)];
end

%save(h,:)=[VO mean(return_new_elec_sim) var(return_new_elec_sim)^(1/2) sum(return_new_elec_sim>0)/length(return_new_elec_sim) mean(return_new_gasoil_sim) var(return_new_gasoil_sim)^(1/2) sum(return_new_gasoil_sim>0)/length(return_new_gasoil_sim) ];
%end

%% Calcute and Illustrate private and public deal
V0=25
clear data
i=1
for r=-1:0.001:1
data(i,1)=100*r;
data(i,2)=public_ny(K,r,n, r_gov, V0, VH, s0);
data(i,3)=public(K,r,n, r_gov);
data(i,4)=private_ny(K,r,G,n,s, ov, vol, V0, VH, s0);
data(i,5)=private(K,r,G,n,s, ov, vol);
i=i+1;
end
data(:,6)=data(:,4)-data(:,2);
data(:,7)=data(:,5)-data(:,3);

%Figure illustrating the private and public deal
nj=figure(1)
%subplot(2,1,1);
plot(data(:,1), data(:,3))
title('Statens afkast af privat og offentlig aftale')
ylabel('Mia. DKK')
xlabel('Årlig vækst i værdien af DONGs egenkapital, %')
axis([-30 30 -20 20])
hold on
plot(data(:,1), data(:,2),'linestyle','--')
legend('Privat','Offentlig','Location','SouthEast')
% subplot(2,1,2);
% plot(data(:,1), data(:,2))
% title('Statens afkast af offentlig aftale')
% ylabel('Mia. DKK')
% xlabel('Årlig vækst i værdien af DONGs egenkapital, %')
% axis([-30 30 -20 20])
%saveas(nj, 'figs/private_public_deal.png')

close all;

%Figure illustrating the dif between private and public deal.
nj=figure(2)
plot(data(:,1), data(:,6))
hold on
plot(data(:,1), data(:,7), 'linestyle','--')
refline(0,0)
title('Afkast af privat aftale minus statslig aftale')
ylabel('Mia. DKK')
xlabel('Årlig vækst i værdien af DONGs egenkapital, %')
axis([-30 30 -20 20])
%saveas(nj, 'figs/private_less_public_deal.png')

hold on;

close all;
