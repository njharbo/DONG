%%%%%Load Danish stocks

clear aktier
aktier(:,1)=xlsread('aktier/aktier_data.xlsx','Sheet1','l2:l4000');
aktier(:,2)=xlsread('aktier/aktier_data.xlsx','Sheet2','l2:l4000');
aktier(:,3)=xlsread('aktier/aktier_data.xlsx','Sheet3','l2:l4000');
aktier(:,4)=xlsread('aktier/aktier_data.xlsx','Sheet4','l2:l4000');
aktier(:,5)=xlsread('aktier/aktier_data.xlsx','Sheet5','l2:l4000');
%aktier(:,6)=xlsread('aktier_data.xlsx','Sheet6','l2:l4000')
aktier(:,7)=xlsread('aktier/aktier_data.xlsx','Sheet7','l2:l4000');
aktier(:,8)=xlsread('aktier/aktier_data.xlsx','Sheet8','l2:l4000');
aktier(:,9)=xlsread('aktier/aktier_data.xlsx','Sheet9','l2:l4000');
aktier(:,10)=xlsread('aktier/aktier_data.xlsx','Sheet10','l2:l4000');
aktier(:,11)=xlsread('aktier/aktier_data.xlsx','Sheet11','l2:l4000');
aktier(:,12)=xlsread('aktier/aktier_data.xlsx','Sheet12','l2:l4000');
aktier(:,13)=xlsread('aktier/aktier_data.xlsx','Sheet13','l2:l4000');
aktier(:,14)=xlsread('aktier/aktier_data.xlsx','Sheet14','l2:l4000');
aktier(:,15)=xlsread('aktier/aktier_data.xlsx','Sheet15','l2:l4000');
aktier(:,16)=xlsread('aktier/aktier_data.xlsx','Sheet16','l2:l4000');
aktier(:,17)=xlsread('aktier/aktier_data.xlsx','Sheet17','l2:l4000');
aktier(:,18)=xlsread('aktier/aktier_data.xlsx','Sheet18','l2:l4000');

%insert NAN if number is 10000(used a indicator var)
aktier(aktier==10000)=NaN;

hist(aktier(~isnan(aktier)),100)

mean_stocks=mean(aktier(~isnan(aktier)))
std_stocks=(var(aktier(~isnan(aktier))))^(1/2)

[f_DK_stocks,x_DK_stocks] =ecdf(aktier(~isnan(aktier)));

%Make a draw from this dist
for i=1:1000
yy=randi(length(x_DK_stocks),1);
draw(i,1)=x_DK_stocks(yy);
end
plot(x_DK_stocks, f_DK_stocks)
mean(draw)

for i=1:1000
draw(i,2)=normrnd(mean_stocks,std_stocks);
end

%%%%%Download returns of 13 European energy stocks

%Load energy stocks
clear energy_returns
for i=1:13
    energy_returns(:,i)=xlsread('../data/energy_stocks/energy_stocks.xlsx', strcat('Sheet', num2str(i)), 'l2:l4000');
end

%insert NAN if number is 10000(used a indicator var)
energy_returns(energy_returns==10000)=NaN

%problems with raw data in collumn 9, remove extremes
problem=energy_returns(:,9);
problem(problem>5)=NaN;
problem(problem<-0.7)=NaN;
energy_returns(:,9)=problem;

%moment of distribtion
mean_energy_stocks=mean(energy_returns(~isnan(energy_returns)))
std_energy_stocks=(var(energy_returns(~isnan(energy_returns))))^(1/2)

%display dist
hist(energy_returns(~isnan(energy_returns)),1000)

%make empirical dist
[f_energy,x_energy] =ecdf(energy_returns(~isnan(energy_returns)));

%Make a draw from this dist
clear draw
for i=1:1000000
yy=randi(length(x_energy),1);
draw(i)=x_energy(yy);
end

mean(draw)

%Load MSCI energi europe
clear msci_energi
%for sheet={'BP', 'bunge', 'rds', 'repsol','seadrill', 'statoil', 'total'}
msci_energi(:,1)=xlsread('msci_energi_europe/data.xlsx', 'BP' , 'l2:l3537');
msci_energi(:,2)=xlsread('msci_energi_europe/data.xlsx', 'bunge' , 'l2:l3537');
msci_energi(:,3)=xlsread('msci_energi_europe/data.xlsx', 'rds' , 'l2:l3537');
msci_energi(:,4)=xlsread('msci_energi_europe/data.xlsx', 'repsol' , 'l2:l3537');
msci_energi(:,5)=xlsread('msci_energi_europe/data.xlsx', 'seadrill' , 'l2:l3537');
msci_energi(:,6)=xlsread('msci_energi_europe/data.xlsx', 'statoil' , 'l2:l3537');
msci_energi(:,7)=xlsread('msci_energi_europe/data.xlsx', 'total' , 'l2:l3537');
%end

%insert NAN if number is 10000(used a indicator var)
msci_energi(msci_energi==10000)=NaN

%remove extremes as emissions
msci_energi(msci_energi<-0.8)=NaN
msci_energi(msci_energi>0.8)=NaN

%moment of distribtion
mean_msci_stocks=mean(msci_energi(~isnan(msci_energi)))
std_msci_stocks=(var(msci_energi(~isnan(msci_energi))))^(1/2)

%display dist
hist(msci_energi(~isnan(msci_energi)),1000)

%make empirical dist
[f_msci,x_msci] =ecdf(msci_energi(~isnan(msci_energi)));

%Load DONGs ROE
clear dong_returns
dong_returns(:,1)=xlsread('DONG accounts/dong.xlsx', 'Sheet1', 'i2:i44');

%display dist
hist(dong_returns)

%make emp dist
[f_dong, x_dong]=ecdf(dong_returns)
