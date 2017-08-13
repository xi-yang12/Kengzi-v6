function ModelAnalysis2
% �������ݷ���

% load('PRE-500.mat');
load('gisdata_processed_trained');
data_p1 = vertcat(gisData.buildings.data);
data_p2 = vertcat(gisData.buildings.data_ext);

dataInfoN = NaturalProperties(data_p1, gisData);
dataInfoE = ExtendedProperties(data_p2);


function dataInfoN = NaturalProperties(data_p1, gisData)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��Ȼ��������
figure(1)

%--1���߳�--%%%%%%%%%%%%%%%%%%
i = 1;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = gisData.txt{9+i-1}; % '�߳�';
dataInfoN(i).barNum = 12;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=3;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=6;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(2,4,i);
drawDataInfo(handle, dataInfoN(i));


%--2���¶�--%%%%%%%%%%%%%%%%%%
i = 2;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = gisData.txt{9+i-1}; % '�¶�';
dataInfoN(i).barNum = 12;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=2;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=9;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(2,4,i);
drawDataInfo(handle, dataInfoN(i));


%--3���¶ȱ仯��--%%%%%%%%%%%%%%%%%%
i = 3;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = gisData.txt{9+i-1}; % '�¶ȱ仯��';
dataInfoN(i).barNum = 13;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=3;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=8;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(2,4,i);
drawDataInfo(handle, dataInfoN(i));


%--4������--%%%%%%%%%%%%%%%%%%
i = 4;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = gisData.txt{9+i-1}; % '����';
dataInfoN(i).barNum = 12;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=3;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=8;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(2,4,i);
drawDataInfo(handle, dataInfoN(i));


%--5������仯��--%%%%%%%%%%%%%%%%%%
i = 5;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = gisData.txt{9+i-1}; % '����仯��';
dataInfoN(i).barNum = 16;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=3;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=4;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(2,4,i);
drawDataInfo(handle, dataInfoN(i));


%--6��ɽ���߼н�--%%%%%%%%%%%%%%%%%%
%i = 6;
%tmp_data = data_p1(:,9+i-1)';
%dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
%dataInfoN(i).name = gisData.txt{9+i-1}; % 'ɽ���߼н�';
%dataInfoN(i).barNum = 9;  % ��Ͱ����
% ģ�Ͳ�������
%dataInfoN(i).model.covType=2;  
%dataInfoN(i).model.gaussianNum=3;   % ��˹�����
%gmmTrainParam=gmmTrainParamSet;
%gmmTrainParam.dispOpt=1;
%gmmTrainParam.maxIteration=8;       % ��������
%dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
%dataInfoN(i) = modelTrain(dataInfoN(i));

%handle = subplot(3,4,i);
%drawDataInfo(handle, dataInfoN(i));

%-- 7������-�����ӵ�--%%%%%%%%%%%%%%%%%%
i = 7;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = gisData.txt{9+i-1}; % '����-�����ӵ�';
dataInfoN(i).barNum = 15;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=5;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=4;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(2,4,i-1);
drawDataInfo(handle, dataInfoN(i));

%-- 8����ɽˮ���߾���--%%%%%%%%%%%%%%%%%%
i = 8;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = gisData.txt{9+i-1}; % '��ɽˮ���߾���';
dataInfoN(i).barNum = 15;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=5;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=4;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(2,4,i-1);
drawDataInfo(handle, dataInfoN(i));


%-- 9������·����--%%%%%%%%%%%%%%%%%%
i = 9;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = gisData.txt{9+i-1}; % '����·����';
dataInfoN(i).barNum = 10;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=4;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=3;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(2,4,i-1);
drawDataInfo(handle, dataInfoN(i));


%==============================================================%
% ����������һЩ�������
dataInfoN = ShowResult(dataInfoN);


%% ��չ��������
function dataInfoE = ExtendedProperties(data_p2)
figure(2)

%-%- Ext_1���ܱ��˸�ũ�����--**************************************
i = 1;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '�ܱ��˸�ũ�����';
dataInfoE(i).barNum = 12;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=2;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=8;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
drawDataInfo(handle, dataInfoE(i));


%-%- Ext_2���ܱ����о�ס���--**************************************
i = 2;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '�ܱ����о�ס���';
dataInfoE(i).barNum = 12;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=3;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=6;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
drawDataInfo(handle, dataInfoE(i));


%-%- Ext_3���������ס����С����--**************************************
i = 3;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '�������ס����С����';
dataInfoE(i).barNum = 18;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=4;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=25;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
drawDataInfo(handle, dataInfoE(i));


%-%- Ext_4���뱾���ס����С����--**************************************
i = 4;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '�뱾���ס����С����';
dataInfoE(i).barNum = 15;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=4;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=5;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
drawDataInfo(handle, dataInfoE(i));


%-%- Ext_5����ˮ���ھ�ס���--**************************************
i = 5;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '��ˮ���ھ�ס���';
dataInfoE(i).barNum = 3;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=3;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=2;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
drawDataInfo(handle, dataInfoE(i));


%-%- Ext_6����ˮ���ڸ������--**************************************
i = 6;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '��ˮ���ڸ������';
dataInfoE(i).barNum = 12;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=3;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=3;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
drawDataInfo(handle, dataInfoE(i));


%-%- Ext_7���븸�ڵ����--**************************************
i = 7;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '�븸�ڵ����';
dataInfoE(i).barNum = 12;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=3;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=8;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
drawDataInfo(handle, dataInfoE(i));


%-%- Ext_8���븸�ڵ����--**************************************
i = 8;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '���游�ڵ����';
dataInfoE(i).barNum = 12;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=2;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=6;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
drawDataInfo(handle, dataInfoE(i));

%==============================================================%
% ����������һЩ�������
dataInfoE = ShowResult(dataInfoE);


%% ģ��ѵ��
function dataInfo_I = modelTrain(dataInfo_I)
% ģ��ѵ��
% dataInfo.model.covType
% dataInfo.model.gaussianNum
% 
% gisData.model.gmmTrainParam = gmmTrainParam;
% gmmTrainParam.useKmeans
% gmmTrainParam.dispOpt
% gmmTrainParam.maxIteration;
% 
% gisData.model.GMM
%
% ѵ�����˹ģ��
[dataInfo_I.model.GMM, logLike]=gmmTrain(dataInfo_I.data, [dataInfo_I.model.gaussianNum, dataInfo_I.model.covType], dataInfo_I.model.gmmTrainParam);

% ѵ������˹ģ��
model = dataInfo_I.model;
model.gaussianNum = 1;
model.gmmTrainParam.maxIteration = 1000;

[dataInfo_I.model.SG, logLike]=gmmTrain(dataInfo_I.data, [model.gaussianNum, model.covType], model.gmmTrainParam);



function drawDataInfo(handle, dataInfo)
% dataInfo.data ����
% dataInfo.model
% dataInfo.name
% dataInfo.barNum

subplot(handle);
cla(handle);
% Step1�� ���ɺ���������
minData = min(dataInfo.data);
maxData = max(dataInfo.data);

endLength = abs(maxData-minData)*0.1;

x = minData-endLength:0.1:maxData+endLength;

% Step2: ������״ͼ
[yf, xc] = hist(dataInfo.data,dataInfo.barNum);
% num = num/sum(num); 
yf = yf / trapz(xc, yf);
bar(xc, yf);
xscare = x(end) - x(1)
% axis([minData-endLength, maxData+endLength, 0, max(yf)*1.05])

% Step3: ���Ƹ�˹���ģ��
p_gmm = exp(gmmEval(x, dataInfo.model.GMM));
hold on;
% plot(x,p_gmm./max(p_gmm)*max(yf)*1.03, 'r');
plot(x,p_gmm, 'r');

% Step4�����Ƶ���˹ģ�� 
p_sg = exp(gmmEval(x, dataInfo.model.SG));
hold on;
% plot(x,p_sg./max(p_sg)*max(yf)*0.75, 'g');
plot(x,p_sg, 'g');
title(sprintf('%s[b:%d,g:%d,I:%d]',dataInfo.name, dataInfo.barNum, dataInfo.model.gaussianNum, dataInfo.model.gmmTrainParam.maxIteration));
axis square

function dataInfo = ShowResult(dataInfo)
for i=1:length(dataInfo)
    % ������Сֵ�����ֵ
    dataInfo(i).minValue = min(dataInfo(i).data);
    dataInfo(i).maxValue = max(dataInfo(i).data);
    
    % Result Show
    fprintf('%s\n', dataInfo(i).name);
    fprintf('\t ��С��%f, ���%f \n', dataInfo(i).minValue, dataInfo(i).maxValue);
end