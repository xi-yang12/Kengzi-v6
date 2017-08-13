function [sum_c, ratio]= converRatio2(gisData)
% Tolerance radius
tolR = 120;
Year = 274;
pre_map = (gisData.PRE.b_s_ID <= Year);
sum_c = 0;
% 1. 计算被覆盖的建筑
for bIdx = 1:length(gisData.buildings)
    cntr = gisData.buildings(bIdx).center;
    sum_c = sum_c + comuteCircum(gisData, pre_map, cntr, tolR);
end

% 2. 计算所占比例
sum_s = sum( gisData.data(:,7)>=1 )
ratio = sum_c / sum_s;

fprintf([gisData.FileName '\n']);
fprintf('\tTolerance radius [R = %d], [Year = %d] \n', tolR, Year);
fprintf('\t原始建筑所占区块个数 [O_blocks = %d] \n', sum_s);
fprintf('\t仿真建筑所占区块个数 [P_blocks = %d] \n', sum(pre_map));
fprintf('\t容忍半径范围内仿真建筑所占区块总个数 : \n \t[P_blocks = %d]， 比例[%.2f] \n', sum_c, ratio*100);


org_res = gisData.data(:,7)>=1;
sim_res = pre_map;

union_res = (org_res | sim_res);

oYes_sYes = (org_res & sim_res);
oYes_sNo  = (org_res & ~sim_res);
oNo_sYes  = (~org_res & sim_res);

fprintf('\tOrg areas： %d \n', sum(org_res));
fprintf('\tSim areas： %d \n', sum(sim_res));
fprintf('\tUnion： %d \n', sum(oYes_sYes));

r_3v1 =  sum(oYes_sYes)/sum(org_res) * 100;
r_3v4 =  sum(oYes_sYes)/sum(sim_res)* 100;

r_oYes_sYes = sum(oYes_sYes)/sum(union_res)* 100;
r_oYes_sNo  = sum(oYes_sNo)/sum(union_res)* 100;
r_oNo_sYes  = sum(oNo_sYes)/sum(union_res)* 100;

fprintf('\tr_3v1： %.2f \n', r_3v1);
fprintf('\tr_3v4： %.2f \n', r_3v4);
fprintf('\tr_oYes_sYes： %.2f \n', r_oYes_sYes);
fprintf('\tr_oYes_sNo： %.2f \n', r_oYes_sNo);
fprintf('\tr_oNo_sYes： %.2f \n', r_oNo_sYes);



function num = comuteCircum(gisData, pre_map, cntr, tolR)
pre_points = NaN(size(pre_map,1),2);
pre_points(pre_map,:) = gisData.data(pre_map,2:3);

dist = sqrt((pre_points(:,1)-cntr(1)).^2 + (pre_points(:,2)-cntr(2)).^2);
dist = dist <= tolR;
num = sum(dist);