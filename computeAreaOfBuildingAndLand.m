function gisData = computeAreaOfBuildingAndLand(gisData)
%% 统计每一阶段选址前和后居住点范围内的居住面积与耕地面积
% 前者用于居住点选址, 后者用于居住点生长到何时停止扩展
other_building = (gisData.data(:,gisData.ModelParam.otHouse)>0); % 外姓居住点
self_building = false(size(other_building));
%tmp_building = other_building;

gisData.other_building = other_building;

for i=1:gisData.N  % 表示gisData.N 个时间剖面(更改！！！！)
    locs = (gisData.data(:,gisData.ModelParam.era)==i);
    index = find(locs==1);
    % 选址前
    [b_area, l_area] = computeAL(gisData, other_building|self_building, locs, gisData.R);
    gisData.data_ext(index,gisData.ModelParam.att_ext) = [b_area(index),l_area(index)];
    
    % [b_r_area, l_r_area] = computeRegionAL(gisData, other_building|self_building, locs);
    % [b_r_area, l_r_area] = computeRegionAL(gisData, self_building, locs);
    % gisData.data_ext(index, gisData.ModelParam.fsqArea) = [b_r_area(index),l_r_area(index)];
        
    other_min_dist = computeMinDist(gisData, other_building, locs, gisData.K);
    self_min_dist = computeMinDist(gisData, self_building, locs, gisData.K);
    gisData.data_ext(index, gisData.ModelParam.dOther) = other_min_dist(index);
    gisData.data_ext(index, gisData.ModelParam.dSelf) = self_min_dist(index);
        
    self_building = self_building|locs; % 更新居民点
    
    % 选址后, 以居住区的中点为中心, 计算范围内的居住面积和耕地面积,与距离
    buildings_id = find([gisData.buildings.iter_ID]==i);
    for j = buildings_id
        [gisData.buildings(j).b_area, gisData.buildings(j).l_area] = ...
            computeALPoint(gisData, other_building|self_building, gisData.buildings(j).center, gisData.R);
        
        % 计算中心点与其他居住区的最小距离
        gisData.buildings(j).other_min_dist = ...
            computeMinDistPoint(gisData, other_building, gisData.buildings(j).center, gisData.K);
        
        % 计算居民区与本族居民区的最小距离, 这里需要移除自己的区域, 否决结果为0 
        self_tmp_b = (gisData.data(:,gisData.ModelParam.seHouse)==j);
        tmp_map_b = self_building & not(self_tmp_b);
        gisData.buildings(j).self_min_dist = ...
            computeMinDistPoint(gisData, tmp_map_b, gisData.buildings(j).center, gisData.K);
        
        % 计算每个建筑所在分水区内的耕地和建筑分布情况
        %[gisData.buildings(j).fsq_b_area, gisData.buildings(j).fsq_land] = ...
            %computeRegionALFsq(gisData, other_building|self_building, gisData.buildings(j).fsq_ID);
    end
end