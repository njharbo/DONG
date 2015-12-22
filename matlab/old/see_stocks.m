clear P temp mod;
i=1;
P=10^10*ones(10000,9);
for str = {'bg','BP', 'eni', 'Shell', 'statoil', 'tentaris','total', 'Transocean'}
    file=strcat('../data/Euro_gasoil/',str,'.csv');
    temp=(flipud(csvread(file{1},1+exante,6)));
    nj(1:length(temp),i)=temp;
    i=i+1;
end

plot(nj(:,1))