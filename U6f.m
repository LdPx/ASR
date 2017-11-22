f = 1/8
n = 0:23
s = sin(2*pi*n*f)
h = [1 -0.97]

ffa = 0:0.05:0.5
res = abs(1 - 0.97 * exp(-j*2*pi*ffa))


plot(ffa,res)
title(ax1,'text')
ylabel(ax1,'stuff')

