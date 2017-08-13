clear;

%gisData = GisDataRead();
% load('gisdata_processed.mat');

% gisData = GisDataRead20();
load('gisdata_processed20.mat');

% 参数设置
gisData = GisSetup(gisData);

% 计算扩展数据
gisData = computeGisData_ext(gisData);

% 高斯模型参数学习
gisData = ParamEvaluation_V6(gisData);

%% =============================================
% CA setup & initialization
gisData = Initialize(gisData);

%% 逻辑回归模型参数估计
% The parameter estimatation for Logistic Regression
bIdx = gisData.train_bIdx(end);
Slice = gisData.topo(bIdx, 3);
[gisData, c_idx] = updatePRE_v6(gisData, bIdx, Slice);
gisData = LogisticRegression(gisData, c_idx);

save('gisdata_processed_trained', 'gisData');
% load('gisdata_processed_trained.mat');

%% 新选择父节点建筑， 并更新数据
[gisData, c_idx] = updatePRE_v6(gisData, gisData.chkBIdx, gisData.Slice);

%% 计算逻辑回归权值
[gisData.lrValue, c_idx] = computeSplitLRValue(gisData, c_idx);

%% 绘图
drawLayer2(gisData, gisData.lrValue, 'Logistic Regression');
