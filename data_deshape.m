function d = data_deshape(d, row, col)
% ��gis���ݵ�matlab
d = reshape(d, col, row)';
d = d(row:-1:1,:);