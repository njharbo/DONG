clear all

%% Set parameters
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
sim=1000; %Number of simulations
simper=252*4; %Number of trading days simulated
exante=1*265; 
backwardinf=0.02;
infl=(1+backwardinf)^(1/252)-1; %
vstart=24.5;
vspan=1;
vend=40.5;

run stockdata.m;

%% Structure of deals

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


%% Simulate return of deals

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


%% Make figures and tables

run figures.m;

run tables.m;