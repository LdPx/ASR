f = 1/8
n = 0:23
s = sin(2*pi*n*f)
h = [1 -0.97]

ax1 = subplot(2,1,1); % top subplot
%x = linspace(0,3);
stem(ax1,n,s)
title(ax1,'Eingangssignal')
ylabel(ax1,'sin(5x)')

ax2 = subplot(2,1,2); % bottom subplot
stem(ax2, 0:24, conv(s, h))
title(ax2,'gefaltet')
ylabel(ax2,'sin(15x)')
