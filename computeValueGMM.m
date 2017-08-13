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

gisData = GisDataRead20();
load('gisdata_processed20.mat');

% ��������
gisData = GisSetup(gisData);

% ������չ����
gisData = computeGisData_ext(gisData);

% ����ѧϰ
gisData = ParamEvaluation_V6(gisData);

save('gisdata_processed_trained', 'gisData');
% load('gisdata_processed_trained.mat');

%% =============================================
%CA setup & initialization
gisData = Initialize(gisData);

%% ��ѡ�񸸽ڵ㽨���� ����������
[gisData, c_idx] = updatePRE_v6(gisData, gisData.chkBIdx, gisData.Slice);

%% �����˹���ģ��Ȩֵ
[gisData.pValue, c_idx] = computeSplitLogPropV6(gisData, c_idx);

%% ��ͼ
drawLayer2(gisData, gisData.pValue, 'GMM');



