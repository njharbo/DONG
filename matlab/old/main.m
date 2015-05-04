%NB:To run this file the historical distributions of stock returns needs to be
%loaded by running mean_var file

%Calculate the guaranteed interest to GS
G=(1+0.0013+0.0225)*(1+0.0044+0.0225)*(1+0.0088+0.0225)*(1+0.0146+0.0225);

%Generate returns under GS and public deal under a range of growth rates in
% DONGs market value
clear data
i=1
for j=-1:0.001:1
data(i,1)=100*j;
data(i,2)=kapital(11,j,4, 0.01);
data(i,3)=goldman(11,j,G,4,0.6, 2.5);
i=i+1;
end
%return of goldman visavis capital (2014 prices)
data(:,4)=(data(:,3)-data(:,2))*(1/((1+0.02)^4));

%plot GS return
data(:,6)=(data(:,5)/8)*100;
plot(data(:,1), data(:,6))
axis([-30 50 -20 200])

%Figure illustrating the Goldman deal
nj=figure(1)
plot(data(:,1), data(:,3))
%refline(0,0)
title('Afkast af Goldman aftale for stat')
ylabel('Mia. DKK')
xlabel('Årlig forrentning i procent af DONGs egenkapital')
%axis([-30 30 -5 5])
saveas(nj, 'figs/GS_deal.png')

%Figure illustrating the public deal
nj=figure(1)
plot(data(71:131,1), data(71:131,2))
%refline(0,0)
title('Afkast af statslig egenkapital for stat')
ylabel('Mia. DKK')
xlabel('Årlig forrentning i procent af DONGs egenkapital')
%axis([-30 30 -5 5])
saveas(nj, 'figs/public_deal.png')

%Figure illustrating the dif between Goldman and public deal.
%plot(data(71:131,1), data(71:131,4))
nj=figure(1)
plot(data(701:1301,1), data(701:1301,4))
refline(0,0)
title('Afkast af Goldman aftale ift. statslig kapital indskud')
ylabel('Mia. DKK')
xlabel('Årlig forrentning i procent')
saveas(nj, 'figs/GS_v_public_deal.png')


%%%%SIMULATIONS %%%%


%stimulate 4*252 daily using energy returns
clear return_energy_sim a nj
for j=1:1000
    for i=(1:1:1008)
        if i==1
        %a(i)=1+normrnd(mean_energy,std_energy);
        a(i)=1+x_energy(randi(length(x_energy),1));
        else
            %a(i)=a(i-1)*(1+normrnd(mean_energy,std_energy));
            a(i)=a(i-1)*(1+x_energy(randi(length(x_energy),1)));
        end 
    end
    if a(length(a))<0
        nj=0;
    else
        nj=a(length(a))^(1/4)-1;
    end
        return_energy_sim(j)=goldman(11,nj,G,4,0.6,2.5)-kapital(11,nj,4, 0.01);
        %return_GS_energy_sim(j)=goldman_return(11,nj,G,4,0.6, 0.01);
        j
end

mean(return_energy_sim)
mean(return_GS_energy_sim)
sum(return_energy_sim>0)
mean((return_energy_sim>0).*return_energy_sim)*(1/(1+0.02)^4)
mean((return_energy_sim<0).*return_energy_sim)*(1/(1+0.02)^4)

%stimulate 4*252 daily using msci energy returns
clear return_msci_sim a nj
for j=1:10000
    for i=(1:1:1008)
        if i==1
        %a(i)=1+normrnd(mean_energy,std_energy);
        a(i)=1+x_msci(randi(length(x_msci),1));
        else
            %a(i)=a(i-1)*(1+normrnd(mean_energy,std_energy));
            a(i)=a(i-1)*(1+x_msci(randi(length(x_msci),1)));
        end 
    end
    if a(length(a))<0
        nj=0;
    else
        nj=a(length(a))^(1/4)-1;
    end
        return_msci_sim(j)=goldman(11,nj,G,4,0.6, 2.5)-kapital(11,nj,4, 0.01);
        j
end

mean(return_msci_sim)*(1/(1+0.02)^4)
sum(return_msci_sim>0)
mean((return_energy_sim>0).*return_energy_sim)*(1/(1+0.02)^4)
mean((return_energy_sim<0).*return_energy_sim)*(1/(1+0.02)^4)

%stimulate 4*12 quarterly returns using DONG returns
clear return_dong_sim a nj
for j=1:100000
    for i=(1:1:38)
        if i==1
        a(i)=1+x_dong(randi(length(x_dong),1));
        else
            a(i)=a(i-1)*(1+x_dong(randi(length(x_dong),1)));
        end 
    end
    if a(length(a))<0
        nj=0;
    else
        nj=a(length(a))^(1/4)-1;
    end
        return_dong_sim(j)=goldman(11,nj,G,4,0.6)-kapital(11,nj,4, 0.01);
        j
end

mean(return_dong_sim)
sum(return_dong_sim>0)
mean((return_dong_sim>0).*return_energy_sim)*(1/(1+0.02)^4)
mean((return_dong_sim<0).*return_energy_sim)*(1/(1+0.02)^4)

%subplot(2,1,1)
nj=figure(1)
hist(return_energy_sim,100)
title('10000 simuleringer af statens gevinst af aftalen med Goldman - European Energy stocks')
ylabel('Antal')
xlabel('Gevinst i mia DKK')
set(gca,'xlim',[-100 10])
saveas(nj, 'figs/sim_return_sim_Energy.png')

histfit(return_energy_sim)

[histdata(:,1),histdata(:,2)]=hist(return_energy_sim,100)


%Figures to article
nj=figure(1)
subplot(2,1,1)
plot(data(1:1301,1), data(1:1301,4))
refline(0,0)
title('Figur 1: Afkast af aftale ift. et statsligt kapital indskud', 'Fontsize', 12)
ylabel('Mia. DKK')
xlabel('Gennemsnitlig årlig vækst i markedsværdi af egenkapital (%)')
subplot(2,1,2)
hist(return_msci_sim,100)
title('Figur 2: Fordeling af 10 000 simuleringer af afkast på aftalen ift. et statsligt kapital indskud', 'Fontsize', 12)
ylabel('Antal')
xlabel('Gevinst i mia. kroner')
set(gca,'xlim',[-100 40])
saveas(nj, 'figs/avis.png')

