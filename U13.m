function [  ] = U13(  )

ref1 = [1.2 0.2; 1.9 0.8; 3.6 1.7; 2.8 1.2; 1.4 0.4; 2.2 2.4; 0.5 0.8];
ref2 = [0.7 2.2; 3.2 1.8; 4.8 0.9; 2.8 2.2; 0.6 2.7];
ref3 = [2.2 1.3; 4.7 4.8; 5.6 3.5; 3.8 2.2; 1.6 1.1; 2.4 0.7];
u    = [0.8 0.4; 2.4 1.2; 4.5 2.3; 3.2 1.5; 1.5 0.7; 0.7 1.8; 1.8 2.8; 0.6 0.7];

d1 = dtw(u, ref1);
d2 = dtw(u, ref2);
d3 = dtw(u, ref3);
d1
d2
d3

end


function [dist] = dtw(u, ref)
    v = zeros(size(ref,1), size(u,1));
    
    for i = 1:size(ref,1)
        for j = 1:size(u,1)
            v(i,j) = norm(u(j,:)-ref(i,:));
        end
    end
    
    % init
    for i = 2:1:size(u,1)
        v(1,i) = v(1,i) + v(1,i-1);
    end
    
    for i = 2:1:size(ref,1)
        v(i,1) = v(i,1) + v(i-1,1);
    end
    
    % real stuff
    for i = 2:size(ref,1)
        for j = 2:size(u,1)
            v(i,j) = v(i,j) + min([v(i-1,j-1) v(i-1,j) v(i,j-1)]);
        end
    end
    
    v
    dist = v(size(ref,1), size(u,1));
end

