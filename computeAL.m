function [b_area, l_area] = computeAL(gisData, map_building, locs, R)
% map_building -- ��ǰ��ͼ�н������, n*1��0-1����
% locs -- ��Ҫ�����λ��, 0,1 ��ʾ, n*1��0-1����
% R -- �뾶
b_area = NaN(size(gisData.data,1),1);
l_area = NaN(size(gisData.data,1),1);
idx = [find(locs==1)]';
for i = idx
    % fprintf('computeAL: %d ... \n', i);
    point = gisData.data(i,2:3);
    [b_area(i), l_area(i)] = computeALPoint(gisData, map_building, point, R);
    if isnan(b_area(i))
        error('Are you busy')
    end
 
end