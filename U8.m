t = 0:0.0001:0.016
st = cos(2*pi*125*t)-1/3*cos(2*pi*375*t)+1/5*cos(2*pi*625*t)-1/7*cos(2*pi*875*t)
plot(t,st)
stem(0:15,fft(st,16))
