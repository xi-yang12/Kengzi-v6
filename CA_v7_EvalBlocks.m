%function CA
clear
% addpath('myAudioSignalProcessBox/asr/');
% addpath('myAudioSignalProcessBox/colea/');
% addpath('myAudioSignalProcessBox/dcpr/');
% addpath('myAudioSignalProcessBox/melodyRecognition/');
% addpath('myAudioSignalProcessBox/sap/');
% addpath('myAudioSignalProcessBox/utility/');

% gisData = GisDataRead();
% load('gisdata_processed.mat');

% gisData = GisDataRead20();
load('gisdata_processed10.mat');

% 参数设置
gisData = GisSetup(gisData);

% 计算扩展数据
gisData = computeGisData_ext(gisData);

% gisData.ModelParam.att_ext = [];
gisData.ModelParam.distP = [];
gisData.ModelParam.distPP = [];

% 参数学习
gisData = ParamEvaluation_V6(gisData);

save('gisdata_processed_trained', 'gisData');
% load('gisdata_processed_trained.mat');

%% =============================================
%CA setup & initialization
gisData = InitGisDataPRE(gisData);

%% 新选择父节点建筑， 并更新数据
[gisData, c_idx] = updatePRE_v7(gisData, gisData.Slice_v7);

%% 计算高斯混合模型权值
[gisData.pValue, c_idx] = computeSplitLogPropV7(gisData, c_idx);

%% 绘图
drawLayer2(gisData, gisData.pValue, 'GMM');



