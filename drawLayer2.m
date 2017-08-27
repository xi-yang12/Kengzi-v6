function drawLayer2(gisData, vals, desp)
%% ��ͼ��������
% ����Ϊ8��
% maxLayer = 8;  % �����Ի���Ϊ10��
% weight = [0.01, 0.05, 0.12, 0.12, 0.135, 0.155, 0.175, 0.195];   % ÿ����ռ����
% best_num = 0;  % ����ǰn����õĵ�, ����Ϊ0, �򲻻���

% ����Ϊ
maxLayer = 8;  % �����Ի���Ϊ10��
weight = [0.005, 0.01, 0.02, 0.04, 0.08, 0.16, 0.32, 0.365];   % ÿ����ռ����
best_num = 6;  % ����ǰn����õĵ�, ����Ϊ0, �򲻻���

%% ��ɫ����
% ÿһ����ɫ����
% == ����һ: ��������ÿ��rgb ====================================
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
% == ����һ���� =================================================

% % == ������: ��������ÿ��rgb ====================================
% rgb_begin = [220, 87, 18]/255;
% rgb_end = [20, 68, 106]/255;
% rgb_all(:,1) = linspace(rgb_begin(1), rgb_end(1), maxLayer);
% rgb_all(:,2) = linspace(rgb_begin(2), rgb_end(2), maxLayer);
% rgb_all(:,3) = linspace(rgb_begin(3), rgb_end(3), maxLayer);
% % == ���������� =================================================

% ������ɫ
rgb_nodata = [0,0,0]/255;

% ������ɫ
rgb_other = [0,0,0]/255;

% ������ɫ
rgb_river = [0,0,80]/255;

% �˸�����ɫ
rgb_farm = [0,100,0]/255;

% ���˸�����ɫ
rgb_notfarm = [255,255,255]/255;

% ��õ�ǰn������ɫ
rgb_bestN = [200, 200, 0]/255;
rgb_bestOne = [200, 200, 100]/255;


%% ���ݴ���
c_idx = not(isnan(vals));
river = (gisData.data(:,gisData.ModelParam.river)> 0);
other_building =(gisData.data(:,gisData.ModelParam.otHouse)>0);
farm = (gisData.data(:,gisData.ModelParam.farm)>0);
notfarm = (gisData.data(:,gisData.ModelParam.farm)<=0);
% ��һ������
vals(c_idx) = (vals(c_idx)-min(vals(c_idx)))/(max(vals(c_idx))-min(vals(c_idx)));
[layer, bestN, bestOne] = divide(vals, maxLayer, weight, best_num);


%% ��ͼ������ʼ
% Step 1: ��������ɫ
map.a = ones(size(vals)) * rgb_nodata(1);
map.b = ones(size(vals)) * rgb_nodata(2);
map.c = ones(size(vals)) * rgb_nodata(3);

map = setColor(map, river, rgb_river);
map = setColor(map, farm, rgb_farm);
map = setColor(map, notfarm, rgb_notfarm);
map = setColor(map, other_building, rgb_other);


% ����ÿ�����ɫ
for i = 1:maxLayer
    idx = (layer == i);
    map = setColor(map, idx, rgb_all(i,:));
end

% ������õ���ɫ
map = setColor(map, bestN, rgb_bestN);
map = setColor(map, bestOne, rgb_bestOne);

% final draw
map.a = data_deshape(map.a, gisData.row, gisData.col);
map.b = data_deshape(map.b, gisData.row, gisData.col);
map.c = data_deshape(map.c, gisData.row, gisData.col);

image(cat(3, map.a, map.b, map.c));
title(desp);

% ͼ�ηֲ�ģ��
function [layer, bestN, bestOne] = divide(vals, maxLayer, weight, best_num)
% ������Ч���ܸ���
c_idx = not(isnan(vals));
tol = sum(c_idx(:));
layer = NaN(size(c_idx));
bestN = false(size(c_idx));

[~, Is] = sort(-vals);   % ������Ը�����������

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

