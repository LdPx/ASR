n = 0:15;
sc = 2*cos(2*pi*n/4)
ns = -sin(2*pi*n*3/8)

ax1 = subplot(2,2,1);
stem(ax1,n,sc)
ax2 = subplot(2,2,2);
stem(ax2, n, ns)


sn = 2*cos(2*pi*n/4)-sin(2*pi*n*3/8);
t = 0:0.0001:0.015
st = 2*cos(2*pi*250*t)-sin(2*pi*375*t)

ax3 = subplot(2,2,3);
stem(ax3,n,sn)
ax4 = subplot(2,2,4);
stem(ax4, t, st)

