n = 0:15;
sc = 2*cos(2*pi*n/4)
ns = -sin(2*pi*n*3/8)

ax1 = subplot(3,2,1);
stem(ax1,n,sc)
ax2 = subplot(3,2,2);
stem(ax2, n, ns)


sn = sc + ns
t = 0:0.0001:0.015
st = 2*cos(2*pi*250*t)-sin(2*pi*375*t)

ax3 = subplot(3,2,3);
stem(ax3,n,sn)
ax4 = subplot(3,2,4);
stem(ax4, t, st)


srk = ones(1,16);
sik = ones(1,16);
for k = 0:15
    srk(k+1) = sum(sn.* cos(2*pi*n*k/16))
    sik(k+1) = sum(sn.* (-j*sin(2*pi*n*k/16)))
end

ax5 = subplot(3,2,5);
stem(ax5, n, srk)
ax6 = subplot(3,2,6);
stem(ax6, n, imag(sik))


ener_zeit = sum(sn.^2)

ener_freq = (sum(srk.^2) + sum(abs(sik).^2))/16
