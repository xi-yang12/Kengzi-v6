function d = data_enshape(d, row, col)
% ��matlab����ϵͳ��gis����ϵͳ
d = d(row:-1:1,:)';
d = d(:);
