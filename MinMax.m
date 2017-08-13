function [X, V] = MinMax(X, V)
% b = 0ʱ��ʾ��һ����Ȼ���ڴ洢�����Сֵ
% b = 1ʱ���Ѿ��洢���ֵ���й�һ��

if (nargin < 2) | isnan(V)
    V = NaN(2, size(X,2));
    V(1,:) = max(X);
    V(2,:) = min(X);
end

r = size(X, 1);

ma = repmat(V(1,:), r, 1);
mi = repmat(V(2,:), r, 1);
X = (X-mi)./(ma - mi);