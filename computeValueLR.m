clear;

%gisData = GisDataRead();
% load('gisdata_processed.mat');

% gisData = GisDataRead20();
load('gisdata_processed20.mat');

% ��������
gisData = GisSetup(gisData);

% ������չ����
gisData = computeGisData_ext(gisData);

% ��˹ģ�Ͳ���ѧϰ
gisData = ParamEvaluation_V6(gisData);

%% =============================================
% CA setup & initialization
gisData = Initialize(gisData);

%% �߼��ع�ģ�Ͳ�������
% The parameter estimatation for Logistic Regression
bIdx = gisData.train_bIdx(end);
Slice = gisData.topo(bIdx, 3);
[gisData, c_idx] = updatePRE_v6(gisData, bIdx, Slice);
gisData = LogisticRegression(gisData, c_idx);

save('gisdata_processed_trained', 'gisData');
% load('gisdata_processed_trained.mat');

%% ��ѡ�񸸽ڵ㽨���� ����������
[gisData, c_idx] = updatePRE_v6(gisData, gisData.chkBIdx, gisData.Slice);

%% �����߼��ع�Ȩֵ
[gisData.lrValue, c_idx] = computeSplitLRValue(gisData, c_idx);

%% ��ͼ
drawLayer2(gisData, gisData.lrValue, 'Logistic Regression');
