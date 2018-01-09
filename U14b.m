function [ ] = U14b( )

V1 = [0.74 3.45; 0.98 3.03; 2.14 2.23; 1.53 2.49; 1.49 2.54; 1.45 2.59; 1.34 2.78; 2.36 1.78];
V2 = [0.85 1.98; 1.23 2.39; 2.02 1.74; 1.82 3.56; 1.55 3.34; 1.50 2.58; 1.45 2.52];
V3 = [0.68 3.02; 1.76 1.88; 1.52 2.48; 1.48 2.52; 1.44 2.67; 1.13 2.97];

VX = cat(1, V1, V2, V3);

M = mean(VX, 1);    %1.4505    2.5971

Cov = cov(VX);

Cov

C2 = zeros(2,2);
for i = 1:size(VX,1)
    C2 = C2 + (VX(i,:)-M).'*(VX(i,:)-M);
end

Cx = C2 / (size(VX,1)-1)    % / N-1

Cy = C2 / (size(VX,1))    % / N



% U14 c)

V1 = [0.98 3.03; 2.14 2.23; 1.53 2.49; 1.49 2.54; 1.45 2.59; 1.34 2.78];
V2 = [1.23 2.39; 2.02 1.74; 1.82 3.56; 1.55 3.34; 1.50 2.58; 1.45 2.52];
V3 = [1.76 1.88; 1.52 2.48; 1.48 2.52; 1.44 2.67; 1.13 2.97];

VX = cat(1, V1, V2, V3);

M = mean(VX, 1);    %1.5194    2.6065

[x1,x2] = meshgrid(0:0.1:4,0:0.1:4);
x = [x1(:) x2(:)];


x = [0.74 3.45];
r = p(x,M,Cov)

end


function[res] = p(x,m,cov)
    M = size(x,2);
    res = 1/sqrt((2*pi)^M*det(cov))*exp(-0.5*(x-m)*inv(cov)*(x-m).');
end

