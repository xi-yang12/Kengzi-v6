function gisData = GisDataRead20()

gisData.blocksize = '10x10';

% 读取地图数据, 并进行预处理
gisData.row = 298;
gisData.col = 332;
[gisData.data, gisData.txt] = xlsread('Qiaoxiang_data10_10_170823.xlsx');

%% Step 1: 过滤-9999,用NaN替换,使其不参与运算
gisData.data(find(gisData.data<-9000)) = NaN;

% Set all data not in 盆区 as NaN
% penqu = gisData.data(:,4);
% gisData.data(find(isnan(penqu)),4:end) = NaN;
% idx_invalid = find(gisData.data(:,4)>0 & isnan(gisData.data(:,20)));
% gisData.data(idx_invalid,4:end) = NaN;

% idx_invalid = find(gisData.data(:,4)>0 & isnan(gisData.data(:,14)));
% gisData.data(idx_invalid,4:end) = NaN;

%% Step 2: 重新生成坐标信息
xx = 5:10:3315;
yy = 5:10:2975;
xx = repmat(xx', gisData.row, 1);
yy = repmat(yy, gisData.col, 1);

gisData.data(:,2) = xx;
gisData.data(:,3) = yy(:);

%% Step 3: Normalization min-max norm
%nIdx = [7:15]; % Indicating which columns need to be normalized.
%dmin = repmat(min(num(:,nIdx)), size(num,1), 1);
%dmax = repmat(max(num(:,nIdx)), size(num,1), 1);
%num(:,11:end) = 2*(num(:,11:end)-dmin)./(dmax-dmin)-1;  % 归一化到[-1,1]
%num(:,nIdx) = (num(:,nIdx)-dmin)./(dmax-dmin);  % 归一化到[0,1]

% 将山脊走向角度大于180度的映射到0-180之间,进行等价转换
%b_idx = gisData.data(:,14)>180;
%gisData.data(b_idx,14) = gisData.data(b_idx,14) - 180;


save('gisdata_processed10', 'gisData');
