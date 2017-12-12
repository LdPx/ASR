function [ output_args ] = U11( input_args )

[st, fs] = audioread('eins.wav');

step = 80;
width = 200;


for v = 0:step:size(st)-width
    window = st(v+1:v+width);
    size(window)
end

size(st)

st;

end

