%% Download returns of 13 European energy stocks
clear energy_returns
for i=1:13
    energy_returns(:,i)=xlsread('../../data/energy_stocks/energy_stocks.xlsx', strcat('Sheet', num2str(i)), 'l2:l4000');
end

%insert NAN if number is 10000(used a indicator var)
energy_returns(energy_returns==10000)=NaN;

%problems with raw data in collumn 9, remove extremes
problem=energy_returns(:,9);
problem(problem>5)=NaN;
problem(problem<-0.7)=NaN;
energy_returns(:,9)=problem;

%moment of distribtion
%mean_energy_stocks=mean(energy_returns(~isnan(energy_returns)))
%std_energy_stocks=(var(energy_returns(~isnan(energy_returns))))^(1/2)

%display dist
%hist(energy_returns(~isnan(energy_returns)),1000)

%make empirical dist
[f_energy,x_energy] =ecdf(energy_returns(~isnan(energy_returns)));


%% Load MSCI energi europe
clear msci_energi
%for sheet={'BP', 'bunge', 'rds', 'repsol','seadrill', 'statoil', 'total'}
msci_energi(:,1)=xlsread('../../data/msci_energi_europe/data.xlsx', 'BP' , 'l2:l3537');
msci_energi(:,2)=xlsread('../../data/msci_energi_europe/data.xlsx', 'bunge' , 'l2:l3537');
msci_energi(:,3)=xlsread('../../data/msci_energi_europe/data.xlsx', 'rds' , 'l2:l3537');
msci_energi(:,4)=xlsread('../../data/msci_energi_europe/data.xlsx', 'repsol' , 'l2:l3537');
msci_energi(:,5)=xlsread('../../data/msci_energi_europe/data.xlsx', 'seadrill' , 'l2:l3537');
msci_energi(:,6)=xlsread('../../data/msci_energi_europe/data.xlsx', 'statoil' , 'l2:l3537');
msci_energi(:,7)=xlsread('../../data/msci_energi_europe/data.xlsx', 'total' , 'l2:l3537');
%end

%insert NAN if number is 10000(used a indicator var)
msci_energi(msci_energi==10000)=NaN;

%remove extremes as emissions
msci_energi(msci_energi<-0.8)=NaN;
msci_energi(msci_energi>0.8)=NaN;

%moment of distribtion
%mean_msci_stocks=mean(msci_energi(~isnan(msci_energi)))
%std_msci_stocks=(var(msci_energi(~isnan(msci_energi))))^(1/2)
%display dist
%hist(msci_energi(~isnan(msci_energi)),1000)

%make empirical dist
[f_msci,x_msci] =ecdf(msci_energi(~isnan(msci_energi)));
