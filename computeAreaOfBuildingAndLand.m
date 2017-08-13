function gisData = computeAreaOfBuildingAndLand(gisData)
%% ͳ��ÿһ�׶�ѡַǰ�ͺ��ס�㷶Χ�ڵľ�ס�����������
% ǰ�����ھ�ס��ѡַ, �������ھ�ס����������ʱֹͣ��չ
other_building = (gisData.data(:,6)==1); % ���վ�ס��
self_building = false(size(other_building));
%tmp_building = other_building;

gisData.other_building = other_building;

for i=1:7  % ��ʾ7��ʱ������
    locs = (gisData.data(:,8)==i);
    index = find(locs==1);
    % ѡַǰ
    [b_area, l_area] = computeAL(gisData, other_building|self_building, locs, gisData.R);
    gisData.data_ext(index,gisData.ModelParam.att_ext) = [b_area(index),l_area(index)];
    
    % [b_r_area, l_r_area] = computeRegionAL(gisData, other_building|self_building, locs);
    [b_r_area, l_r_area] = computeRegionAL(gisData, self_building, locs);
    % gisData.data_ext(index,5) = b_r_area(index);
    % gisData.data_ext(index,6) = l_r_area(index);
    gisData.data_ext(index, gisData.ModelParam.fsqArea) = [b_r_area(index),l_r_area(index)];
        
    other_min_dist = computeMinDist(gisData, other_building, locs, gisData.K);
    self_min_dist = computeMinDist(gisData, self_building, locs, gisData.K);
    gisData.data_ext(index, gisData.ModelParam.dOther) = other_min_dist(index);
    gisData.data_ext(index, gisData.ModelParam.dSelf) = self_min_dist(index);
        
    self_building = self_building|locs; % ���¾����
    
    % ѡַ��, �Ծ�ס�����е�Ϊ����, ���㷶Χ�ڵľ�ס����͸������,�����
    buildings_id = find([gisData.buildings.iter_ID]==i);
    for j = buildings_id
        [gisData.buildings(j).b_area, gisData.buildings(j).l_area] = ...
            computeALPoint(gisData, other_building|self_building, gisData.buildings(j).center, gisData.R);
        
        % �������ĵ���������ס������С����
        gisData.buildings(j).other_min_dist = ...
            computeMinDistPoint(gisData, other_building, gisData.buildings(j).center, gisData.K);
        
        % ����������뱾�����������С����, ������Ҫ�Ƴ��Լ�������, ������Ϊ0 
        self_tmp_b = (gisData.data(:,7)==j);
        tmp_map_b = self_building & not(self_tmp_b);
        gisData.buildings(j).self_min_dist = ...
            computeMinDistPoint(gisData, tmp_map_b, gisData.buildings(j).center, gisData.K);
        
        % ����ÿ���������ڷ�ˮ���ڵĸ��غͽ����ֲ����
        [gisData.buildings(j).fsq_b_area, gisData.buildings(j).fsq_land] = ...
            computeRegionALFsq(gisData, other_building|self_building, gisData.buildings(j).fsq_ID);
    end
end