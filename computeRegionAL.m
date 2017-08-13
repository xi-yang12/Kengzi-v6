function [b_r_area, l_r_area] = computeRegionAL(gisData, map_building, locs)
% �����ˮ��
% map_building -- ��ǰ��ͼ�н������, n*1��0-1����
% locs -- ��Ҫ�����λ��, 0,1 ��ʾ, n*1��0-1����
b_r_area = NaN(size(gisData.data,1),1);
l_r_area = NaN(size(gisData.data,1),1);
p_idxs = [find(locs==1)]';
for i = p_idxs
    [b_r_area(i), l_r_area(i)] = computeRegionALPoint(gisData, map_building, i);
end


