function min_dist = computeMinDist(gisData, map_building, locs, K)
% map_building -- ��ǰ��ͼ�н������, n*1��0-1����
% locs -- ��Ҫ�����λ��, 0,1 ��ʾ, n*1��0-1����
% K ȡǰk��������ƽ����С����
min_dist = NaN(size(gisData.data,1),1);
idx = [find(locs==1)]';
for i = idx
    point = gisData.data(i,2:3);
    min_dist(i) = computeMinDistPoint(gisData, map_building, point, K);
end