function [X, V] = ZScore(X, V)

if nargin < 1
    selfdemo;
end

if (nargin < 2) | isnan(V)
    V = NaN(2, size(X,2));
    V(1, :) = mean(X);
    V(2, :) = std(X);
end
r = size(X, 1);

mm = repmat(V(1, :), r, 1);
ss = repmat(V(2, :), r, 1);
X = (X-mm)./ss;


function selfdemo
X = rand(3,5)
[Xhat, V] = ZScore(X, NaN)
