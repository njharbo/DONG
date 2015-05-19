%% Variance p? end price 

clear return_elec_sim return_gasoil_sim a rsave r return_elec_pendk return_elec_gs return_elec_public penvgs_elec govvgs_elec penvgs_oil govvgs_oil

sim=10000;
vcounter=1;
sand=31.5;

for v=0:2:20

for j=1:sim
    
    %Note: This method is an order of magnitude faster than last (loop) method
    a=prod(1+returns_elec(unidrnd(length(returns_elec),simper,1)));
    b=prod(1+returns_gasoil(unidrnd(length(returns_gasoil),simper,1)));
    
    r(1)=a(length(a))^(1/n)-1;
    r(2)=b(length(b))^(1/n)-1;
   


        
        %European Energy stocks
        [return_elec_pendk(1,j,vcounter) return_elec_pendk(2,j,vcounter)]=pensdk(sand, indskud_pd, initial_pd, n, keep, g,r(1)+expinf,inigovshare);
        [return_elec_gs(1,j,vcounter) return_elec_gs(2,j,vcounter)]=gs(sand, indskud_gs, initial_gs, n, keep, g,r(1)+expinf,inigovshare,v);
        [return_elec_public(1,j,vcounter) return_elec_public(2,j,vcounter)]=public(sand, indskud_gs, initial_gs, n, keep, g,r(1)+expinf,rgov,inigovshare);
        [return_elec_statusquo(1,j,vcounter) return_elec_statusquo(2,j,vcounter)]=statusquo(sand, initial_gs, n, keep, r(1)+expinf,inigovshare);
       
        

        j
        rsave(:,j)=[r(1), r(2)];
end

mean_w_noice(vcounter)=mean(return_elec_gs(1,:,vcounter)+return_elec_gs(2,:,vcounter)-return_elec_public(1,:,vcounter)-return_elec_public(2,:,vcounter));
vcounter=vcounter+1;

end

%Figure 
nj=figure(2)
plot(0:2:20, mean_w_noice(:))
title('Gennemsnitligt afkast som funktion af varians paa observeret pris')
ylabel('Mia. DKK')
xlabel('\sigma^2')
%axis([-30 30 -20 20])
saveas(nj, 'figs/return_variance.pdf')

% Allow for later execution

TBD