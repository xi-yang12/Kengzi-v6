function ModelAnalysis
% �������ݷ���

load('PRE-500.mat');
data_p1 = vertcat(gisData.buildings.data);
data_p2 = vertcat(gisData.buildings.data_ext);

gisParam = dataInfoParamSet();

% dataInfoN = NaturalProperties(data_p1, gisParam);
dataInfoE = ExtendedProperties(data_p2, gisParam);



% ��������
function gisParam = dataInfoParamSet
gisParam.MaxArea = 3;
gisParam.T_sigma = 0.3;


function dataInfoN = NaturalProperties(data_p1, gisParam)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��Ȼ��������
figH = figure(1)

%--1���߳�--%%%%%%%%%%%%%%%%%%
i = 1;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = '�߳�';
dataInfoN(i).barNum = 6;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=2;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=80;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

% ��ʼ��dataInfoN�ṹ
dataInfoN(i).minData = [];
dataInfoN(i).maxData = [];
dataInfoN(i).Area = [];

handle = subplot(3,3,i);
dataInfoN(i) = showDataInfo(handle, dataInfoN(i), gisParam);


%--2���¶�--%%%%%%%%%%%%%%%%%%
i = 2;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = '�¶�';
dataInfoN(i).barNum = 8;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=2;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=80;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(3,3,i);
dataInfoN(i) = showDataInfo(handle, dataInfoN(i), gisParam);


%--3���¶ȱ仯��--%%%%%%%%%%%%%%%%%%
i = 3;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = '�¶ȱ仯��';
dataInfoN(i).barNum = 10;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=2;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=5;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(3,3,i);
dataInfoN(i) = showDataInfo(handle, dataInfoN(i), gisParam);


%--4������--%%%%%%%%%%%%%%%%%%
i = 4;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = '����';
dataInfoN(i).barNum = 5;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=2;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=70;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(3,3,i);
dataInfoN(i) = showDataInfo(handle, dataInfoN(i), gisParam);


%--5������仯��--%%%%%%%%%%%%%%%%%%
i = 5;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = '����仯��';
dataInfoN(i).barNum = 15;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=3;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=2;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(3,3,i);
dataInfoN(i) = showDataInfo(handle, dataInfoN(i), gisParam);


%--6��ɽ���߼н�--%%%%%%%%%%%%%%%%%%
i = 6;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = 'ɽ���߼н�';
dataInfoN(i).barNum = 6;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=2;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=200;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(3,3,i);
dataInfoN(i) = showDataInfo(handle, dataInfoN(i), gisParam);


%--7�������ӵ�����--%%%%%%%%%%%%%%%%%%
i = 7;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = '�����ӵ�����';
dataInfoN(i).barNum = 15;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoN(i).model.covType=2;  
dataInfoN(i).model.gaussianNum=3;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=60;       % ��������
dataInfoN(i).model.gmmTrainParam = gmmTrainParam;
dataInfoN(i) = modelTrain(dataInfoN(i));

handle = subplot(3,3,i);
dataInfoN(i) = showDataInfo(handle, dataInfoN(i), gisParam);



%--8����ɽˮ���߾���--%%%%%%%%%%%%%%%%%%
i = 8;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = '��ɽˮ���߾���';
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

handle = subplot(3,3,i);
dataInfoN(i) = showDataInfo(handle, dataInfoN(i), gisParam);


%--9������·����--%%%%%%%%%%%%%%%%%%
i = 9;
tmp_data = data_p1(:,9+i-1)';
dataInfoN(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoN(i).name = '����·����';
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

handle = subplot(3,3,i);
dataInfoN(i) = showDataInfo(handle, dataInfoN(i), gisParam);

saveas(figH, 'Natural.eps');


%% ��չ��������
function dataInfoE = ExtendedProperties(data_p2, gisParam)
figH = figure(2)

%-%- Ext_1���ܱ����о�ס���--**************************************
i = 1;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '�ܱ����о�ס���';
dataInfoE(i).barNum = 10;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=2;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=4;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));

% ��ʼ��dataInfoN�ṹ
dataInfoE(i).minData = [];
dataInfoE(i).maxData = [];
dataInfoE(i).Area = [];

% ��ͼ
handle = subplot(2,4,i);
dataInfoE(i) = showDataInfo(handle, dataInfoE(i), gisParam);


%-%- Ext_2���ܱ��˸�ũ�����--**************************************
i = 2;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '�ܱ߿ɸ�ũ�����';
dataInfoE(i).barNum = 15;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=3;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=4;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
dataInfoE(i) = showDataInfo(handle, dataInfoE(i), gisParam);


%-%- Ext_3���뱾���ס����С����--**************************************
i = 3;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '�뱾���ס����С����';
dataInfoE(i).barNum = 6;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=2;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=5;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
dataInfoE(i) = showDataInfo(handle, dataInfoE(i), gisParam);


%-%- Ext_4���������ס����С����--**************************************
i = 4;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '�������ס����С����';
dataInfoE(i).barNum = 6;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=2;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=7;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
dataInfoE(i) = showDataInfo(handle, dataInfoE(i), gisParam);


%-%- Ext_5����ˮ���ھ�ס���--**************************************
i = 5;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '��ˮ�������о�ס���';
dataInfoE(i).barNum = 10;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=3;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=1;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
dataInfoE(i) = showDataInfo(handle, dataInfoE(i), gisParam);


%-%- Ext_6����ˮ���ڸ������--**************************************
i = 6;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '��ˮ�����ø������';
dataInfoE(i).barNum = 7;  % ��Ͱ����
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
dataInfoE(i) = showDataInfo(handle, dataInfoE(i), gisParam);


%-%- Ext_7���븸�ڵ����--**************************************
i = 7;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '�븸�ڵ����';
dataInfoE(i).barNum = 5;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=2;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=5;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
dataInfoE(i) = showDataInfo(handle, dataInfoE(i), gisParam);


%-%- Ext_8�����游�ڵ����--**************************************
i = 8;
tmp_data = data_p2(:,i)';
dataInfoE(i).data = tmp_data(find(~isnan(tmp_data)));
% ������������
dataInfoE(i).name = '���游�ڵ����';
dataInfoE(i).barNum = 7;  % ��Ͱ����
% ģ�Ͳ�������
dataInfoE(i).model.covType=2;  
dataInfoE(i).model.gaussianNum=2;   % ��˹�����
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=5;       % ��������
dataInfoE(i).model.gmmTrainParam = gmmTrainParam;
dataInfoE(i) = modelTrain(dataInfoE(i));
% ��ͼ
handle = subplot(2,4,i);
dataInfoE(i) = showDataInfo(handle, dataInfoE(i), gisParam);

saveas(figH, 'Extended.eps')

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



function dataInfo = showDataInfo(handle, dataInfo, gisParam)
% dataInfo.data ����
% dataInfo.model
% dataInfo.name
% dataInfo.barNum

subplot(handle);
cla(handle);
%axes('LineWidth', 0.25);
set(gca, 'LineWidth',0.15) 

% Step1�� ���ɺ���������
dataInfo.minData = min(dataInfo.data);
dataInfo.maxData = max(dataInfo.data);

endLength = abs(dataInfo.maxData-dataInfo.minData)*0.05;

x = dataInfo.minData-endLength:0.1:dataInfo.maxData+endLength;

% Step2: ������״ͼ
[num, center] = hist(dataInfo.data,dataInfo.barNum);
num = num/sum(num);
hb=bar(center, num);
% ������״ͼ��ɫ
set(hb, 'facecolor',[239 239 235]/255, 'LineStyle', 'none')
axis([x(1), x(end), 0, max(num)+0.02])
axis square


% Step3: ���Ƹ�˹���ģ��
p_gmm = exp(gmmEval(x, dataInfo.model.GMM));
hold on;
plot(x,p_gmm./max(p_gmm)*max(num)*1.03, 'Color', [212 53 130]/255);

% Step4�����Ƶ���˹ģ�� 
p_sg = exp(gmmEval(x, dataInfo.model.SG));
hold on;
plot(x,p_sg./max(p_sg)*max(num)*0.75, 'Color',[185 185 186]/255);
%title(sprintf('%s[b:%d,g:%d,I:%d]',dataInfo.name, dataInfo.barNum, dataInfo.model.gaussianNum, dataInfo.model.gmmTrainParam.maxIteration));
title(dataInfo.name);

% Step5�� ����Ȩ�ؽϴ��ǰK������
MaxArea = min(length(dataInfo.model.GMM), gisParam.MaxArea);
w = [dataInfo.model.GMM.w];
for i=1:MaxArea
    [~,idx] = max(w);
    dataInfo.Area(i).CC = dataInfo.model.GMM(idx).mu;  % ��������
    dataInfo.Area(i).CC_L = dataInfo.model.GMM(idx).mu - gisParam.T_sigma * dataInfo.model.GMM(idx).sigma; %�½�
    dataInfo.Area(i).CC_U = dataInfo.model.GMM(idx).mu + gisParam.T_sigma * dataInfo.model.GMM(idx).sigma; %�Ͻ�
    
    xx = dataInfo.Area(i).CC_L:0.1:dataInfo.Area(i).CC_U;
    yy = exp(gmmEval(xx, dataInfo.model.GMM))./max(p_gmm)*max(num)*1.03;
    
    % hold on;
    % a_x = [xx, xx(end:-1:1)];
    % a_y = [yy, yy(end:-1:1)*0];
    % patch(a_x,a_y,'g','facealpha',0.5);
    
    hold on
    % stem(xx(1),yy(1),'r');
    % stem(xx(end),yy(end),'r');
    
    cy = exp(gmmEval(dataInfo.Area(i).CC, dataInfo.model.GMM))./max(p_gmm)*max(num)*1.03;
    stem(dataInfo.Area(i).CC,cy,'k', 'LineStyle', ':');
    
    w(idx) = -1;
end


% Step Last: Result Show
fprintf('%s\n', dataInfo.name);
fprintf('\t ��С��%f, ���%f \n', dataInfo.minData, dataInfo.maxData);



