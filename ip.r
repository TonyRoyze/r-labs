# ip
leaverage <- hatvalues(SLR_incubation)
plot(ID,leaverage)
abline(h=2/15)

SLR_cooks = cooks.distance(SLR_incubation)
plot(ID,SLR_cooks)
abline(h=4/13)
