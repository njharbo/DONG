%s is share of stocks where gov has garanteed a minimum return
function [utility]=crra(c, theta)
    utility=1/(1-theta)*c.^(1-theta);
end