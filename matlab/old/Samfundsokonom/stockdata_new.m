
%% Load electricity companies
clear P temp mod;
i=1;
P=10^10*ones(10000,9);
for str = {'cez','drax', 'edf', 'eon', 'fortum', 'gdf', 'verbund', 'iberdrole', 'rwe' }
    file=strcat('../../data/Euro_electricity/',str,'.csv');
    temp=diff(log(flipud(csvread(file{1},1+exante,6))))-infl;
    P(1:length(temp),i)=temp;
    i=i+1;
end

%insert NAN if number is 10^10(used a indicator var)
P(P==10^10)=NaN;
%P(P==0)=NaN;

%Remove extreme outliers
P(abs(P)>0.5)=NaN;

%moment of distribtion
mean_elec_stocks=mean(P(~isnan(P)))
std_elec_stocks=(var(P(~isnan(P))))^(1/2)

%display dist
%hist(P(~isnan(P)),1000)

%make empirical dist
[f_elec,x_elec] =ecdf(P(~isnan(P)));
i=1
for x=0.001:0.001:1
ur(i)=x;
mod(i)=interp1(f_elec,x_elec,ur(i),'linear');
i=i+1;
end
clear x_elec f_elec
x_elec=mod;
f_elec=0.001:0.001:1;

for i=1:1000
x(i)=x_elec(randi(length(x_elec),1));
end

Pelec=P;

%make empirical dist worng
[f_elec_wrong,x_elec_wrong] =ecdf(P(~isnan(P)));

%% Load gas and oil companies
clear P temp mod;
i=1;
P=10^10*ones(10000,9);
for str = {'bg','BP', 'eni', 'Shell', 'statoil', 'tentaris','total', 'Transocean'}
    file=strcat('../../data/Euro_gasoil/',str,'.csv');
    temp=diff(log(flipud(csvread(file{1},1+exante,6))))-infl;
    P(1:length(temp),i)=temp;
    i=i+1;
end

%insert NAN if number is 10^10(used a indicator var)
P(P==10^10)=NaN;
%P(P==0)=NaN;

%Remove extreme outliers
P(abs(P)>0.5)=NaN;

%moment of distribtion
mean_gasoil_stocks=mean(P(~isnan(P)))
std_gasoil_stocks=(var(P(~isnan(P))))^(1/2)

%display dist
%hist(P(~isnan(P)),1000)

%make empirical dist
[f_gasoil,x_gasoil] =ecdf(P(~isnan(P)));
i=1
for x=0.001:0.001:1
ur(i)=x;
mod(i)=interp1(f_gasoil,x_gasoil,ur(i),'linear');
i=i+1;
end
clear x_gasoil f_gasoil
x_gasoil=mod;
f_gasoil=0.001:0.001:1;

P1=P;

%Figure
nj=figure(3)
subplot(2,1,1);
hist(P1(~isnan(P1)),100)
title('A. Electricitetsselskaber')
ylabel('Antal')
xlabel('Daglig værditilvækst')
set(gca,'xlim',[-0.5 0.5])
%axis([-0.5 0.5 0 2500])
subplot(2,1,2);
hist(P(~isnan(P)),100)
title('B. Olie og gasselskaber')
ylabel('Antal')
xlabel('Daglig værditilvækst')
set(gca,'xlim',[-0.5 0.5])
%axis([-0.5 0.5 0 2500])
saveas(nj, 'figs/data_hist.png')

close all;