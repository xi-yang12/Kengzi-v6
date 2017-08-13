function [gisData, c_idx] = updatePRE_v6(gisData, p_Idx, Slice)
% 更新 gisData.PRE.data_ext
% 计算所有block的ext参数，
%
if gisData.v == 1
    fprintf('updatePRE_v6 gisData.PRE.ext with Build ID [%d] ... \n', p_Idx);
end

% 更新前,先设置为默认值
gisData = clearPRE_ext(gisData);

%% Step 1. 选择候选计算点 (为原有的candidate和)
c_idx = ((gisData.PRE.status_candidate==1) | (gisData.data(:,8) > Slice));
% all_points = gisData.data(:,2:3);
% b_center = gisData.PRE.buildings(b_Idx).center;
% c_idx = c_idx & ((abs(all_points(:,1)-b_center(1))<=gisData.S) & (abs(all_points(:,2)-b_center(2))<=gisData.S));
% 计算其他block的选址记录需要计算与父节点的距离，选用b_Idx建筑为参考点
self_building = ((gisData.data(:,8) <= Slice) & (gisData.data(:,8) > 0));

% 1. 更新 gisData.PRE.data_ext
% index = [find(c_idx==1)]';
[b_area, l_area] = computeAL(gisData, gisData.other_building|self_building, c_idx, gisData.R);
% gisData.PRE.data_ext(index,1) = b_area(index);
% gisData.PRE.data_ext(index,2) = l_area(index);
gisData.PRE.data_ext(c_idx, gisData.ModelParam.att_ext) = [b_area(c_idx),l_area(c_idx)];

% [b_r_area, l_r_area] = computeRegionAL(gisData, gisData.other_building|self_building, locs);
[b_r_area, l_r_area] = computeRegionAL(gisData, self_building, c_idx);
gisData.PRE.data_ext(c_idx, gisData.ModelParam.fsqArea) = [b_r_area(c_idx),l_r_area(c_idx)];
% gisData.PRE.data_ext(index,5) = b_r_area(index);
% gisData.PRE.data_ext(index,6) = l_r_area(index);

other_min_dist = computeMinDist(gisData, gisData.other_building, c_idx, gisData.K);
self_min_dist = computeMinDist(gisData, self_building, c_idx, gisData.K);
gisData.PRE.data_ext(c_idx, gisData.ModelParam.dOther) = other_min_dist(c_idx);
gisData.PRE.data_ext(c_idx, gisData.ModelParam.dSelf) = self_min_dist(c_idx);

if nargin > 1
    p_building = (gisData.PRE.b_ID == p_Idx);
    p_dist = computeMinDist(gisData, p_building, c_idx, inf);
    gisData.PRE.data_ext(c_idx, gisData.ModelParam.distP) = p_dist(c_idx);
    if ~isnan(gisData.PRE.buildings(p_Idx).parent_ID)
        pp_id = gisData.PRE.buildings(p_Idx).parent_ID;
        pp_building = (gisData.PRE.b_ID == pp_id);
        pp_dist = computeMinDist(gisData, pp_building, c_idx, inf);
        gisData.PRE.data_ext(c_idx, gisData.ModelParam.distPP) = pp_dist(c_idx);
    end
end

if gisData.v == 1
    fprintf('\t UpdatePRE_v6 done successfully gisData.PRE... \n');
end


function gisData = clearPRE_ext(gisData)
% 更新前,先设置为默认值
gisData.PRE.data_ext = gisData.data_ext; 