function [ output_args ] = U16( input_args )

format shortEng
format compact

x = [1.23 2.45; 1.37 2.34; 1.95 1.87; 2.72 0.87];
HMM1m = [1.5 2.5; 2.0 1.9; 2.7 0.9];
HMM1v = [0.32 0.57; 0.48 0.42; 0.62 0.37];
HMM2m = [2.1 1.1; 1.7 1.8; 1.2 2.0];
HMM2v = [0.51 0.37; 0.42 0.45; 0.35 0.52];

% p(x3|S3)
r = 3;
state = 2;
p = nv2d(x(r,:), HMM1m(state,:), HMM1v(state,:))
p = nv2d(x(r,:), HMM2m(state,:), HMM2v(state,:))


a1 = [0.75 0.25 0.0; 0.0 0.65 0.35; 0.0 0.0 0.57].';
a1e = [0.0 0.0 0.43];
a2 = [0.65 0.25 0.1; 0.0 0.55 0.35; 0.0 0.0 0.57].';
a2e = [0.0 0.1 0.43];
%a1 = [0.75 0.25 0.0 0.0; 0.0 0.65 0.35 0.0; 0.0 0.0 0.57 0.43];
%a2 = [0.65 0.25 0.1 0.0; 0.0 0.55 0.35 0.1; 0.0 0.0 0.57 0.43].';

p1 = viterbi(x, HMM1m, HMM1v, a1, a1e)
p2 = viterbi(x, HMM2m, HMM2v, a2, a2e)



end


function [res] = viterbi(x, HMMm, HMMv, a, ae)
    % Anzahl Merkmalsvektoren x Anzahl Zustände
    p = zeros(size(x,1),size(HMMm,1));
    p(1,1) = nv2d(x(1,:),HMMm(1,:),HMMv(1,:));
    decisions = zeros(size(x,1),size(HMMm,1));
    for t = 2:size(p,1)
        for i = 1:size(p,2)
            pval = nv2d(x(t,:),HMMm(i,:),HMMv(i,:));
            [maxval, maxind] = max(a(i,:).*p(t-1,:));
            p(t,i) = pval * maxval;
            decisions(t,i) = maxind;
        end
    end
    decisions
    [laststateval, laststateind] = max(ae.*p(size(p,1),:));
    laststateind
    res = log(laststateval);
end



function [res] = nv2d(x,m,v)
    res = 1/sqrt((2*pi)^2*prod(v))*exp(-0.5*sum((x-m).^2./v));
end