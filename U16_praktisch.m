function [] = U16b()
    %W = [-1 -1; 2 -3; -2 -3];
    X = [1 2; 2 -2; -6 0];
    %o = nn_layer(x,W,@sigm)
    W = cell(1,2);
    W{1} = [-1 -1; 2 -3; -2 -3];
    W{2} = [0.6; 0.6; -1];
    res = neural_net(X, W, @thr)
end

function [o] = sigm(net)
    o = 1./(1.+exp(-net));
end

function [o] = thr(net)
    o = net >= 0;
end

function [o] = relu(net)
    o = max(0, net);
end

function [o] = nn_layer(X, W, act_fun)
    X
    W
    o = act_fun(X*W);
end

function [o] = neural_net(X, W, act_fun)
    o = X;
    for k=1:length(W)
        o = [o ones(size(o,1),1)]   % bias anhängen
        o = nn_layer(o, W{k}, act_fun)
    end
end