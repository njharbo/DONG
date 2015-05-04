%% Test for robustness wrt. noise in price
clear mean_with_noise a b r return_elec_sim return_gasoil_sim;
l=1;
sim=20000;
for v=0:5:20
    vol=v
    
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
            r(1)=-(abs(a(length(a)-1))^(1/4)-1);
        else
            r(1)=a(length(a))^(1/4)-1;
        end
        
        if b(length(b))<0
            r(2)=-(abs(b(length(b)-1))^(1/4)-1);
        else
            r(2)=b(length(b))^(1/4)-1;
        end
        
        %European Energy stocks
        return_elec_sim(j)=private(K,r(1),G,n,s, ov, vol)-public(K,r(1),n, r_gov);
        
        %MSCI Energy stocks
        return_gasoil_sim(j)=private(K,r(2),G,n,s, ov, vol)-public(K,r(2),n, r_gov);
        j;
        rsave(:,j)=[r(1), r(2)];
    end

    mean_with_noise(:,l)=[mean(return_elec_sim),  mean(return_gasoil_sim)];
    l=l+1;
end


%Figure 
nj=figure(2)
plot(0:5:20, mean_with_noise(1,:))
title('Gennemsnitligt afkast som funktion af varians p? observeret pris, 20.000 simulationer')
ylabel('Mia. DKK')
xlabel('\sigma^2')
%axis([-30 30 -20 20])
saveas(nj, 'figs/return_variance.png')


%How big uncertainty does sigma=20 -> ?
var=20;
sim=1000;
clear rsave Kreal Kobserve
 for j=1:sim
     
        for i=(1:1:simper)
            if i==1
                a(i)=1+x_elec(randi(length(x_elec),1));
            else
                a(i)=a(i-1)*(1+x_elec(randi(length(x_elec),1)));
            end
        end
        
        if a(length(a))<0
            r(1)=-(abs(a(length(a)-1))-1);
        else
            r(1)=a(length(a))-1;
        end
        
        rsave(j)=r(1);
        
        Kreal(j)=K*(1+r(1));
        Kobserve(j)=max(K*(1+r(1))+randn(1)*var,0);
        %Kreal(j)+randn(1)*var;
        j
 end

scatter(Kreal/0.2, Kobserve/0.2)
title('Observeret og faktisk v?rdi af DONG for \sigma=20')
ylabel('Observeret v?rdi')
xlabel('Faktisk v?rdi')
saveas(nj, 'figs/observed_actual_value.png')

%% Robustness wrt price
clear mean_with_noise a b r return_elec_sim return_gasoil_sim;
sim=1000;
    for j=1:sim
        for i=(1:1:simper)
            if i==1
                a(i)=1-0.1+x_elec(randi(length(x_elec),1));
                b(i)=1-0.1+x_gasoil(randi(length(x_gasoil),1));
            else
                a(i)=a(i-1)*(1+x_elec(randi(length(x_elec),1)));
                b(i)=b(i-1)*(1+x_gasoil(randi(length(x_gasoil),1)));
            end
        end
        
        if a(length(a))<0
            r(1)=-(abs(a(length(a)-1))^(1/4)-1);
        else
            r(1)=a(length(a))^(1/4)-1;
        end
        
        if b(length(b))<0
            r(2)=-(abs(b(length(b)-1))^(1/4)-1);
        else
            r(2)=b(length(b))^(1/4)-1;
        end
        
        %European Energy stocks
        return_elec_sim(j)=private(K,r(1),G,n,s, ov, vol)-public(K,r(1),n, r_gov);
        
        %MSCI Energy stocks
        return_gasoil_sim(j)=private(K,r(2),G,n,s, ov, vol)-public(K,r(2),n, r_gov);
        j
        rsave(:,j)=[r(1), r(2)];
    end

    display('Mean, std and prob for electricity stocks')
mean(return_elec_sim)
var(return_elec_sim)^(1/2)
sum(return_elec_sim>0)/length(return_elec_sim)

display('Mean, std and prob for gasoil stocks')
mean(return_gasoil_sim)
var(return_gasoil_sim)^(1/2)
sum(return_gasoil_sim>0)/length(return_gasoil_sim)


%% Tillad for eksekvering senere end primo 2018
cita=[0.0013, 0.0044, 0.0088, 0.0146, 0.01977, 0.023761, 0.027166];
riskpremium=0.0225;
G=prod(cita+1+riskpremium-forwardinf);
n=5;
simper=252*5;
sim=10000;

for g=4:7

G=prod(cita(1:g)+1+riskpremium-forwardinf);
n=g;

clear return_elec_sim return_gasoil_sim a r rsave
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
        
        %MSCI Energy stocks
        return_gasoil_sim(j)=private(K,r(2),G,n,s, ov, vol)-public(K,r(2),n, r_gov);
        j
        rsave(:,j)=[r(1), r(2)];
end


resultsavetime(g-3,:)= [mean(return_elec_sim), mean(return_gasoil_sim)]

end



