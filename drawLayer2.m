function drawLayer2(gisData, vals, desp)
%% 绘图参数设置
% 划分为8层
% maxLayer = 8;  % 最多可以划分为10层
% weight = [0.01, 0.05, 0.12, 0.12, 0.135, 0.155, 0.175, 0.195];   % 每层所占比重
% best_num = 0;  % 绘制前n个最好的点, 若其为0, 则不绘制

% 划分为
maxLayer = 8;  % 最多可以划分为10层
weight = [0.005, 0.01, 0.02, 0.04, 0.08, 0.16, 0.32, 0.365];   % 每层所占比重
best_num = 6;  % 绘制前n个最好的点, 若其为0, 则不绘制

%% 颜色设置
% 每一层颜色设置
% == 方案一: 单独设置每个rgb ====================================
rgb_1 = [254, 244, 64];
rgb_2 = [231, 179, 84];
rgb_3 = [233, 148, 65];
rgb_4 = [216, 106, 53];
rgb_5 = [186, 92, 92];
rgb_6 = [177, 100, 112];
rgb_7 = [135, 109, 156];
rgb_8 = [114, 134, 198];
% rgb_9 = [98, 140, 199];
% rgb_10 = [78, 164, 225];
rgb_all = [rgb_1; rgb_2; rgb_3; rgb_4; rgb_5; rgb_6; rgb_7; rgb_8]/255;
% == 方案一结束 =================================================

% % == 方案二: 单独设置每个rgb ====================================
% rgb_begin = [220, 87, 18]/255;
% rgb_end = [20, 68, 106]/255;
% rgb_all(:,1) = linspace(rgb_begin(1), rgb_end(1), maxLayer);
% rgb_all(:,2) = linspace(rgb_begin(2), rgb_end(2), maxLayer);
% rgb_all(:,3) = linspace(rgb_begin(3), rgb_end(3), maxLayer);
% % == 方案二结束 =================================================

% 背景颜色
rgb_nodata = [0,0,0]/255;

% 外族颜色
rgb_other = [0,0,0]/255;

% 河流颜色
rgb_river = [0,0,80]/255;

% 宜耕地颜色
rgb_farm = [0,100,0]/255;

% 非宜耕地颜色
rgb_notfarm = [255,255,255]/255;

% 最好的前n个点颜色
rgb_bestN = [200, 200, 0]/255;
rgb_bestOne = [200, 200, 100]/255;


%% 数据处理
c_idx = not(isnan(vals));
river = (gisData.data(:,gisData.ModelParam.river)> 0);
other_building =(gisData.data(:,gisData.ModelParam.otHouse)>0);
farm = (gisData.data(:,gisData.ModelParam.farm)>0);
notfarm = (gisData.data(:,gisData.ModelParam.farm)<=0);
% 归一化处理
vals(c_idx) = (vals(c_idx)-min(vals(c_idx)))/(max(vals(c_idx))-min(vals(c_idx)));
[layer, bestN, bestOne] = divide(vals, maxLayer, weight, best_num);


%% 绘图主程序开始
% Step 1: 创建背景色
map.a = ones(size(vals)) * rgb_nodata(1);
map.b = ones(size(vals)) * rgb_nodata(2);
map.c = ones(size(vals)) * rgb_nodata(3);

map = setColor(map, river, rgb_river);
map = setColor(map, farm, rgb_farm);
map = setColor(map, notfarm, rgb_notfarm);
map = setColor(map, other_building, rgb_other);


% 设置每层的颜色
for i = 1:maxLayer
    idx = (layer == i);
    map = setColor(map, idx, rgb_all(i,:));
end

% 设置最好的颜色
map = setColor(map, bestN, rgb_bestN);
map = setColor(map, bestOne, rgb_bestOne);

% final draw
map.a = data_deshape(map.a, gisData.row, gisData.col);
map.b = data_deshape(map.b, gisData.row, gisData.col);
map.c = data_deshape(map.c, gisData.row, gisData.col);

image(cat(3, map.a, map.b, map.c));
title(desp);

% 图形分层模块
function [layer, bestN, bestOne] = divide(vals, maxLayer, weight, best_num)
% 计算有效点总个数
c_idx = not(isnan(vals));
tol = sum(c_idx(:));
layer = NaN(size(c_idx));
bestN = false(size(c_idx));

[~, Is] = sort(-vals);   % 按降序对各个数据排序

bestOne = Is(1);
if best_num ~= 0
    bestN(Is(1:best_num)) = true;
end

last = 1;
for i = 1 : maxLayer - 1
    next = ceil(tol * weight(i));
    layer(Is(last:next)) = i;
    last = next + 1;
end
layer(Is(last:tol)) = maxLayer;


function map = setColor(map, idx, rgb)
map.a(idx) = rgb(1);
map.b(idx) = rgb(2);
map.c(idx) = rgb(3);

