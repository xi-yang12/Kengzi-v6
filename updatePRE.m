function gisData = updatePRE(gisData)
% 1. 更新 gisData.PRE.data_ext
% 2. 更新 gisData.PRE.lp_attribute, lp_other_min_dist, lp_self_min_dist
% 3.1 更新 gisData.PRE.buildings.b_area
% 3.2 更新 gisData.PRE.buildings.l_area
% 3.3 更新 gisData.PRE.buildings.other_min_dist
% 3.4 更新 gisData.PRE.buildings.self_min_dist
% 3.5 更新 gisData.PRE.buildings.lp_value
%
% Note: 这里的更新只更新gisData.PRE.status_candidate为1的值

if gisData.v == 1,
    fprintf('Update gisData.PRE... \n');
end


% 更新前,先设置为默认值
gisData = clearPRE(gisData);

% 1. 更新 gisData.PRE.data_ext
locs = (gisData.PRE.status_candidate == 1);

[b_area, l_area] = computeAL(gisData, gisData.other_building|gisData.PRE.self_building, locs, gisData.R);
%gisData.PRE.data_ext(index,1) = b_area(index);
%gisData.PRE.data_ext(index,2) = l_area(index);
gisData.PRE.data_ext(locs, gisData.ModelParam.att_ext) = [b_area(locs),l_area(locs)];

%[b_r_area, l_r_area] = computeRegionAL(gisData, gisData.other_building|gisData.PRE.self_building, locs);
%[b_r_area, l_r_area] = computeRegionAL(gisData, gisData.PRE.self_building, locs);
%gisData.PRE.data_ext(index,5) = b_r_area(index);
%gisData.PRE.data_ext(index,6) = l_r_area(index);
%gisData.PRE.data_ext(locs, gisData.ModelParam.fsqArea) = [b_r_area(locs),l_r_area(locs)];

% Kengzi
other_min_dist = computeMinDist(gisData, gisData.other_building, locs, gisData.K);
self_min_dist = computeMinDist(gisData, gisData.PRE.self_building, locs, gisData.K);
gisData.PRE.data_ext(locs,gisData.ModelParam.dOther) = other_min_dist(locs);
gisData.PRE.data_ext(locs,gisData.ModelParam.dSelf) = self_min_dist(locs);

% % DYX 
% % other_min_dist = computeMinDist(gisData, gisData.other_building, locs, gisData.K);
% self_min_dist = computeMinDist(gisData, gisData.PRE.self_building, locs, gisData.K);
% gisData.PRE.data_ext(index,3) = 200; % other_min_dist(index);
% gisData.PRE.data_ext(index,4) = self_min_dist(index);

% 2. 更新 gisData.PRE.lp_attribute, lp_other_min_dist, lp_self_min_dist
index = [find(locs==1)]';
for i = index
    attributes = [gisData.data(i,gisData.ModelParam.att), gisData.PRE.data_ext(i, gisData.ModelParam.att_ext)]';
    gisData.PRE.lp_attribute(i) = gmmEval(attributes, gisData.model(1).GMM);
    if sum(gisData.PRE.lp_attribute>0)
        warning('Exception Value! -- lp_attribute\n');
    end
    
    gisData.PRE.lp_other_min_dist(i) = gmmEval(gisData.PRE.data_ext(i, gisData.ModelParam.dOther), gisData.model(2).GMM);
    if sum(gisData.PRE.lp_other_min_dist>0)
        warning('Exception Value! -- lp_other_min_dist\n');
    end
    
    gisData.PRE.lp_self_min_dist(i) = gmmEval(gisData.PRE.data_ext(i, gisData.ModelParam.dSelf), gisData.model(3).GMM);
    if sum(gisData.PRE.lp_self_min_dist>0)
        warning('Exception Value! -- lp_self_min_dist\n');
    end
    
%     gisData.PRE.lp_fsq_area(i) = gmmEval(gisData.PRE.data_ext(i, gisData.ModelParam.fsqArea)', gisData.model(6).GMM);
%     if sum(gisData.PRE.lp_fsq_area>0)
%         warning('Exception Value! -- lp_fsq_area\n');
%    end
end

% 3.1 更新 gisData.PRE.buildings.b_area
% 3.2 更新 gisData.PRE.buildings.l_area
% 3.3 更新 gisData.PRE.buildings.other_min_dist
% 3.4 更新 gisData.PRE.buildings.self_min_dist
% 3.5 更新 gisData.PRE.buildings.lp_value
% 3.6 更新 gisData.PRE.buildings.fsq_ID  % 用于判断建筑是否继续生长
%       gisData.PRE.buildings.fsq_land;   
%       gisData.PRE.buildings.fsq_b_area;
for b_Idx = 1:length(gisData.PRE.buildings)
    [gisData.PRE.buildings(b_Idx).b_area, gisData.PRE.buildings(b_Idx).l_area] = ...
        computeALPoint(gisData, gisData.other_building|gisData.PRE.self_building, gisData.PRE.buildings(b_Idx).center, gisData.R);
    % Kengzi
    gisData.PRE.buildings(b_Idx).other_min_dist = ...
       computeMinDistPoint(gisData, gisData.other_building, gisData.PRE.buildings(b_Idx).center, gisData.K);
    
%     % Dyx
%     gisData.PRE.buildings(b_Idx).other_min_dist = 200; %...
    
    % 在计算与本族建筑的最小距离时, 应该移除当前的建筑
    map_self_building = gisData.PRE.self_building & not(gisData.PRE.b_ID==b_Idx);
    
    gisData.PRE.buildings(b_Idx).self_min_dist = ...
        computeMinDistPoint(gisData, map_self_building, gisData.PRE.buildings(b_Idx).center, gisData.K);
    
    % 计算建筑所在分水区内的建筑面积, 和可用耕地面积
    % [gisData.PRE.buildings(b_Idx).fsq_b_area, gisData.PRE.buildings(b_Idx).fsq_land] = ...
        % computeRegionALFsq(gisData, gisData.other_building|gisData.PRE.self_building, gisData.PRE.buildings(b_Idx).fsq_ID);
end

if gisData.v == 1,
    fprintf('\tUpdate done successfully gisData.PRE... \n');
end


function gisData = clearPRE(gisData)
% 更新前,先设置为默认值
gisData.PRE.data_ext(:) = NaN;
gisData.PRE.lp_attribute(:) = NaN;          % 每个候选区块对应的值, 用于判断该区块是否可以用作居住区
gisData.PRE.lp_other_min_dist(:) = NaN;  
gisData.PRE.lp_self_min_dist(:) = NaN;
% gisData.PRE.lp_fsq_area(:) = NaN; 

for b_Idx = 1:length(gisData.PRE.buildings)
    gisData.PRE.buildings(b_Idx).b_area = NaN;
    gisData.PRE.buildings(b_Idx).l_area = NaN;
    gisData.PRE.buildings(b_Idx).other_min_dist = NaN;
    gisData.PRE.buildings(b_Idx).self_min_dist = NaN;
    gisData.PRE.buildings(b_Idx).lp_value = NaN;
%    gisData.PRE.buildings(b_Idx).fsq_ID = NaN;
%    gisData.PRE.buildings(b_Idx).fsq_land = NaN;
%    gisData.PRE.buildings(b_Idx).fsq_b_area = NaN;
end