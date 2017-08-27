function gisData = ParamEvaluation_V6(gisData)
% GMM����ѧϰ
if gisData.v == 1,
    fprintf('Parameter Evaluation... \n');
end

% ��ý�������GMMģ��, ���ھ�ס��ѡַ,��������(�����߳�,�¶�,��, ����data_ext�������ڵĽ������)
data_p1 = vertcat(gisData.buildings(gisData.train_bIdx).data);
data_p2 = vertcat(gisData.buildings(gisData.train_bIdx).data_ext);

%trainingData = [data_p1(:,9:17),data_p2(:,1:2)];
trainingData = [data_p1(:,gisData.ModelParam.att),data_p2(:,gisData.ModelParam.att_ext)];
trainingData = trainingData';
gisData.model(1).name = 'block_gmm';
gisData.model(1).covType=2;
gisData.model(1).gaussianNum=20; % ��˹�������
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=3; % ��������
[gisData.model(1).GMM, logLike]=gmmTrain(trainingData, [gisData.model(1).gaussianNum, gisData.model(1).covType], gmmTrainParam);
gisData.model(1).gmmTrainParam = gmmTrainParam;


%% ��ý�������GMMģ��, ���ھ�ס��ѡַ,�ⲿ����(��������ס��ľ���)
trainingData = data_p2(:,gisData.ModelParam.dOther)';
gisData.model(2).name = 'dist_other';
gisData.model(2).covType=2;
gisData.model(2).gaussianNum=4;  % barNum = 15
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=10;
[gisData.model(2).GMM, logLike]=gmmTrain(trainingData, [gisData.model(2).gaussianNum, gisData.model(2).covType], gmmTrainParam);
gisData.model(2).gmmTrainParam = gmmTrainParam;


%% ��ý�������GMMģ��, ���ھ�ס��ѡַ,�ⲿ����(��������ס��ľ���)
trainingData = data_p2(:,gisData.ModelParam.dSelf)';
idx = find(isnan(trainingData) | trainingData==inf);
trainingData(idx) = [];  % �Ƴ�����inf����, infֵ��Ҫ�����ڵ�һ���������ͱ��彨�����ľ���, ��Ϊ�տ�ʼû�б��彨����, ����Ϊ�����
gisData.model(3).name = 'dist_self';
gisData.model(3).covType=2;
gisData.model(3).gaussianNum=10;   %  barNum = 15,17
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=20;
[gisData.model(3).GMM, logLike]=gmmTrain(trainingData, [gisData.model(3).gaussianNum, gisData.model(3).covType], gmmTrainParam);
gisData.model(3).gmmTrainParam = gmmTrainParam;


trainingData = data_p2(:,gisData.ModelParam.distP)';
idx = find(isnan(trainingData) | trainingData==inf);
trainingData(idx) = [];  % �Ƴ�����inf����, infֵ��Ҫ�����ڵ�һ���������ͱ��彨�����ľ���, ��Ϊ�տ�ʼû�б��彨����, ����Ϊ�����
gisData.model(4).name = 'p_dist';
gisData.model(4).covType=1;
gisData.model(4).gaussianNum=5;   % barNum = 12, 15
gmmTrainParam=gmmTrainParamSet;
gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=16;
[gisData.model(4).GMM, logLike]=gmmTrain(trainingData, [gisData.model(4).gaussianNum, gisData.model(4).covType], gmmTrainParam);
gisData.model(4).gmmTrainParam = gmmTrainParam;


trainingData = data_p2(:,gisData.ModelParam.distPP)';
idx = find(isnan(trainingData) | trainingData==inf);
trainingData(idx) = [];  % �Ƴ�����inf����, infֵ��Ҫ�����ڵ�һ���������ͱ��彨�����ľ���, ��Ϊ�տ�ʼû�б��彨����, ����Ϊ�����
gisData.model(5).name = 'pp_dist';
gisData.model(5).covType=2;
gisData.model(5).gaussianNum=42;  % barNum = 7, 10
gmmTrainParam=gmmTrainParamSet;
%gmmTrainParam.useKmeans=1;
gmmTrainParam.dispOpt=1;
gmmTrainParam.maxIteration=17;
[gisData.model(5).GMM, logLike]=gmmTrain(trainingData, [gisData.model(5).gaussianNum, gisData.model(5).covType], gmmTrainParam);
gisData.model(5).gmmTrainParam = gmmTrainParam;

% idx_6: gNum = 5, mIter =4, barNum = 6;
% idx_5: gNum = 5, mIter =5, barNum = 6;
% trainingData = data_p2(:,gisData.ModelParam.fsqArea)';
% idx = find(isnan(trainingData) | trainingData==inf);
% trainingData(idx) = [];  % �Ƴ�����inf����, infֵ��Ҫ�����ڵ�һ���������ͱ��彨�����ľ���, ��Ϊ�տ�ʼû�б��彨����, ����Ϊ�����
% gisData.model(6).name = 'fsq_area';
% gisData.model(6).covType=2;
% gisData.model(6).gaussianNum=10;
% gmmTrainParam=gmmTrainParamSet;
% gmmTrainParam.useKmeans=1;
% gmmTrainParam.dispOpt=1;
% gmmTrainParam.maxIteration=2;
% [gisData.model(6).GMM, logLike]=gmmTrain(trainingData, [gisData.model(6).gaussianNum, gisData.model(6).covType], gmmTrainParam);
% gisData.model(6).gmmTrainParam = gmmTrainParam;

% %% ѵ�����������С��GMMģ��
% trainingData = [gisData.buildings.size; gisData.buildings.b_area; gisData.buildings.l_area; gisData.buildings.other_min_dist; gisData.buildings.self_min_dist];
% trainingData = trainingData(:,2:end); % ��1�а���inf, �Ƴ�֮
% gisData.model(4).name = 'building_size';
% gisData.model(4).covType=2;
% gisData.model(4).gaussianNum=5;
% gmmTrainParam2=gmmTrainParamSet;
% gmmTrainParam2.useKmeans=0;
% gmmTrainParam2.dispOpt=1;
% gmmTrainParam2.maxIteration=500;
% [gisData.model(4).GMM, logLike]=gmmTrain(trainingData, [gisData.model(4).gaussianNum, gisData.model(4).covType], gmmTrainParam2);
% gisData.model(4).gmmTrainParam = gmmTrainParam2;


