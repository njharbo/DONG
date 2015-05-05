%% TABLES from simulations

%% Tables using electricity stocks

%Vector with mean returns on private deal
for h=1:length(vstart:vspan:vend)
    vector=return_elec_gs(1,:,h)+return_elec_gs(2,:,h)-return_elec_statusquo(1,:,h)-return_elec_statusquo(2,:,h);
    mean_private_elec(h)=mean(vector);
    std_private_elec(h)=var(vector)^(1/2);
    std_private_elec_pos(h)=var(vector.*(vector>0))^(1/2);
    std_private_elec_neg(h)=var(vector.*(vector<0))^(1/2);
    prob_private_elec(h)=sum(vector>0)/length(vector);
end

%Table on private deal
[vstart:vspan:vend; mean_private_elec; std_private_elec; std_private_elec_pos; std_private_elec_neg; prob_private_elec]'

%Vector with mean returns on public deal
for h=1:length(vstart:vspan:vend)
    vector=return_elec_public(1,:,h)+return_elec_public(2,:,h)-return_elec_statusquo(1,:,h)-return_elec_statusquo(2,:,h);
    mean_pub_elec(h)=mean(vector);
    std_pub_elec(h)=var(vector)^(1/2);
    std_pub_elec_pos(h)=var(vector.*(vector>0))^(1/2);
    std_pub_elec_neg(h)=var(vector.*(vector<0))^(1/2);
    prob_pub_elec(h)=sum(vector>0)/length(vector);
end

%Table on public deal
[vstart:vspan:vend; mean_pub_elec; std_pub_elec; std_pub_elec_pos; std_pub_elec_neg; prob_pub_elec]'

%Vector with mean relativ returns
for h=1:length(vstart:vspan:vend)
    vector=return_elec_gs(1,:,h)+return_elec_gs(2,:,h)-return_elec_public(1,:,h)-return_elec_public(2,:,h);
    mean_rel_elec(h)=mean(vector);
    std_rel_elec(h)=var(vector)^(1/2);
    std_rel_elec_pos(h)=var(vector.*(vector>0))^(1/2);
    std_rel_elec_neg(h)=var(vector.*(vector<0))^(1/2);
    prob_rel_elec(h)=sum(vector>0)/length(vector);
end

%Table on private relative to public
[vstart:vspan:vend; mean_rel_elec; std_rel_elec; prob_rel_elec]'

%% Tables using oilgas stocks

%Vector with mean returns on private deal
for h=1:length(vstart:vspan:vend)
    vector=return_oil_gs(1,:,h)+return_oil_gs(2,:,h)-return_oil_statusquo(1,:,h)-return_oil_statusquo(2,:,h);
    mean_private_oil(h)=mean(vector);
    std_private_oil(h)=var(vector)^(1/2);
    std_private_oil_pos(h)=var(vector.*(vector>0))^(1/2);
    std_private_oil_neg(h)=var(vector.*(vector<0))^(1/2);
    prob_private_oil(h)=sum(vector>0)/length(vector);
end

%Table on private deal
[vstart:vspan:vend; mean_private_oil; std_private_oil; std_private_oil_pos; std_private_oil_neg; prob_private_oil]'

%Vector with mean returns on public deal
for h=1:length(vstart:vspan:vend)
    vector=return_oil_public(1,:,h)+return_oil_public(2,:,h)-return_oil_statusquo(1,:,h)-return_oil_statusquo(2,:,h);
    mean_pub_oil(h)=mean(vector);
    std_pub_oil(h)=var(vector)^(1/2);
    std_pub_oil_pos(h)=var(vector.*(vector>0))^(1/2);
    std_pub_oil_neg(h)=var(vector.*(vector<0))^(1/2);
    prob_pub_oil(h)=sum(vector>0)/length(vector);
end

%Table on public deal
[vstart:vspan:vend; mean_pub_oil; std_pub_oil; std_pub_oil_pos; std_pub_oil_neg; prob_pub_oil]'

%Vector with mean relativ returns
for h=1:length(vstart:vspan:vend)
    vector=return_oil_gs(1,:,h)+return_oil_gs(2,:,h)-return_oil_public(1,:,h)-return_oil_public(2,:,h);
    mean_rel_oil(h)=mean(vector);
    std_rel_oil(h)=var(vector)^(1/2);
    std_rel_oil_pos(h)=var(vector.*(vector>0))^(1/2);
    std_rel_oil_neg(h)=var(vector.*(vector<0))^(1/2);
    prob_rel_oil(h)=sum(vector>0)/length(vector);
end

%Table on private relative to public
[vstart:vspan:vend; mean_rel_oil; std_rel_oil; prob_rel_oil]'