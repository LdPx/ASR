


function [ ] = U11()
close all
[st, fs] = audioread('eins.wav');
%if (fs == 16000)
%    st = resample(st, 8, 16, 50);
%end
figure; plot(st)
[features, dftmatrix, melmatrix] = extract_features(st, fs);

figure;
imagesc(20*log10(dftmatrix'));
axis xy;
colormap('jet');

figure;
imagesc(melmatrix');
axis xy;
colormap('jet');

%features
figure; 
mesh(features);
figure; 
plot(features(:,2));
end


function [mel] = mel(f)
    mel = 2595*log10(1+f/700);
end

function [f] = mel_inv(mel)
    f = (10^(mel/2595)-1)*700;
end

function [dft_indices] = det_dft_indices(fmin, fmax, M, fa, N)
    melmin = mel(fmin);
    melmax = mel(fmax);
    dmel = (melmax-melmin)/M;
    for i = 0:1:M-1
       l = ceil(mel_inv(melmin+i*dmel)*N/fa);
       r = floor(mel_inv(melmin+(i+1)*dmel)*N/fa);
       dft_indices(i+1,:) = [l r];
    end
end



function [features, dftmatrix, melmatrix] = extract_features( st, fs )

step = 0.01; % 10 ms
step = round(step * fs);
width = 0.025;
width = round(width *fs);

b = [1 -0.95];

fmin = 200;
fmax = fs/2;
%fa = 8000;
fa = fs;
M = 24;

%figure; stem(abs(fft(st)));
st_filtered = filter(b, 1, st);
%figure; stem(abs(fft(st_filtered)));
%figure; stem(st_filtered)
hamm = hamming(width);
    
I = floor(M/2);
dctmat = zeros(M,I+1);
for m = 1:M
    for i = 0:I
        dctmat(m,i+1) = cos(pi*i*(m-0.5)/M);
    end
end

ind = 1;
for v = 0:step:length(st)-width
    window = st_filtered(v+1:v+width);
    windows(ind,:) = window;
    st_hamm = hamm .* window;
    energy = log10(sum(st_hamm.^2));
    sf = abs(fft(st_hamm));
    dft_indices = det_dft_indices(fmin, fmax, M, fa, width);
    dft_indices(M,2) = width/2; % billige Reperatur
    for row = 1:size(dft_indices,1)
        myrow = dft_indices(row,:);
        l = myrow(1);
        r = myrow(2);
        mel_spectral(row) = sum(sf(l:r));
    end
    %if ind == 1
    %    figure; stem(sf)
    %    figure; stem(mel_spectral)
    %end
    mel_spectral = log10(mel_spectral);
    mel_cepstral = mel_spectral * dctmat;
    %if ind == 1
    %    figure; stem(mel_spectral)
    %    figure; stem(mel_cepstral)
    %end
    %energy
    %mel_cepstral(2:I+1)
    features(ind,:) = [energy mel_cepstral(2:I+1)];
    
    % zur Überprüfung
    dftmatrix(ind,:) = sf(1:width/2+1);
    melmatrix(ind,:) = mel_spectral;
    
    
    ind = ind + 1;
end




end
