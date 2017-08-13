function [X, V] = MinMax(X, V)
% b = 0时表示归一化后然后在存储最大最小值
% b = 1时用已经存储后的值进行归一化

if (nargin < 2) | isnan(V)
    V = NaN(2, size(X,2));
    V(1,:) = max(X);
    V(2,:) = min(X);
end

r = size(X, 1);

ma = repmat(V(1,:), r, 1);
mi = repmat(V(2,:), r, 1);
X = (X-mi)./(ma - mi);