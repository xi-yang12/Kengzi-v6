[gisData.map.data, gisData.map.txt] = xlsread('map_rgb/历史模拟底图.xlsx');

rgb_1 = [156,156,156];
rgb_2 = [204,204,204];
rgb_3 = [255,255,255];
rgb_4 = [78,78,78];
rgb_5 = [229,232,255];

rgb_all = [rgb_1; rgb_2; rgb_3; rgb_4; rgb_5]/255;
rgb_idx = [1,     2,     3,     4,     5];
% 黄氏建筑 
rgb_huang = [255,0,162]/255;

rgb_nodata = [255,255,255]/255;

% 创建背景
bgdata = gisData.map.data(:,4); %获取背景数据
gisData.map.a = ones(size(bgdata)) * rgb_nodata(1);
gisData.map.b = ones(size(bgdata)) * rgb_nodata(2);
gisData.map.c = ones(size(bgdata)) * rgb_nodata(3);

% 绘制第3列数据
b1_idx = (gisData.map.data(:,3) == 1);
gisData.map.a(b1_idx) = rgb_all(1, 1);
gisData.map.b(b1_idx) = rgb_all(1, 2);
gisData.map.c(b1_idx) = rgb_all(1, 3);

for i = 2:length(rgb_idx)
    b_idx = (bgdata == rgb_idx(i));
    gisData.map.a(b_idx) = rgb_all(i, 1);
    gisData.map.b(b_idx) = rgb_all(i, 2);
    gisData.map.c(b_idx) = rgb_all(i, 3);
end

% 黄氏预测建筑颜色设定
predict_idx = gisData.PRE.b_s_ID >0 ;
gisData.map.a(predict_idx) = rgb_huang(1);
gisData.map.b(predict_idx) = rgb_huang(2);
gisData.map.c(predict_idx) = rgb_huang(3);


gisData.map.a = data_deshape(gisData.map.a, gisData.row, gisData.col);
gisData.map.b = data_deshape(gisData.map.b, gisData.row, gisData.col);
gisData.map.c = data_deshape(gisData.map.c, gisData.row, gisData.col);

image(cat(3, gisData.map.a, gisData.map.b, gisData.map.c));