%simulate 12*4 months
clear c
for j=1:1000
    b=1
    i=1
    for i=(2:1:49)
        a=normrnd(0.008,0.22);
        if i==1
            b=1
        else
            b=b*(1+a);
            i=i+1;
        end
    end
    c(j)=b;
end
ce=c.^(1/4)-1
hist(ce)

%Create probabilities
j=(-1.01:0.01:1)
clear prob
for k=2:length(j)
    prob(k-1)=sum((ce<j(k))-(ce<j(k-1)))/length(ce);
end

%laeg ind ssh
data(:,5)=prob;


%mean return
sum(data(:,5).*data(:,4))
hist(data(:,5).*data(:,4))