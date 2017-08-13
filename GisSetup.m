function gisData = GisSetup(gisData)
gisData.v = 1;

%% areaType = 1; Բ������, ����������
gisData.areaType = 1;

gisData.R = 500;   % ��Χ�뾶, ��λm
gisData.K = 10;     % ȡǰK����С�����ƽ��ֵ��Ϊ�����������С����

gisData.FileName = sprintf('map-%d-P4-4',gisData.R);

%% ͬʱ��������ÿ����������Ľ��������������, ������С����, ������ÿ�����������Ϣ��(buildings)
gisData.data_ext_num = 8;
gisData.data_ext_name = [{'�ܱ��˸�ũ�����'}, {'�ܱ����о�ס���'}, ...
                         {'�������ס����С����'}, {'�뱾���ס����С����'}, ...
                         {'��ˮ���ھ�ס���'}, {'��ˮ���ڸ������'}, ...
                         {'�븸�ڵ����'}, {'���游�ڵ����'}
                         ];
%% For GMM
gisData.ModelParam.att = [9:10,12:13,15:17];
gisData.ModelParam.att_ext = [1:2];  % {'�ܱ��˸�ũ�����'}, {'�ܱ����о�ס���'}
gisData.ModelParam.dOther = [3];
gisData.ModelParam.dSelf = [4];
gisData.ModelParam.distP = [7];
gisData.ModelParam.distPP = [8];
gisData.ModelParam.fsqArea = [5:6];

%% For Logistics Regression
gisData.ModelParam.LR_org = gisData.ModelParam.att;
gisData.ModelParam.LR_ext = [gisData.ModelParam.att_ext, gisData.ModelParam.dOther, ...
                             gisData.ModelParam.dSelf, gisData.ModelParam.fsqArea, ...                             
                             gisData.ModelParam.distP, gisData.ModelParam.distPP]; 

%% For logicstics regression modeling
gisData.LR.link = 'logit';  % see doc glmfit
gisData.LR.is_norm = 1;     % �Ƿ���Ҫ��һ������
% gisData.LR.normFun = @(X, V)(MinMax(X, V));
gisData.LR.normFun = @(X, V)(ZScore(X, V));

%% For 


%% �����������ĵط������
gisData.rateFB = 107.64;

%% �������ģʽ = 1,ʱ��ʾ�������, ����Ϊ1��������[��������뽨�������ֵ < gisData.rateFB] 
gisData.crazy = 0;   

%%              
gisData.curTime = 290; % ��ǰʱ�䣬 ��1��ʼ
gisData.Step = 1;    % ����ʱ�䲽��
gisData.PvA = 16;  % ƽ����/��

%% ���˹�ϵ
%                 ID, Parent, Slice, the max building in Slice
gisData.topo = [  1,  NaN,    1,     1;
                  2,  1,      2,     2;
                  3,  2,      3,     8;
                  4,  1,      3,     8;
                  5,  1,      3,     8;
                  6,  1,      3,     8;
                  7,  1,      3,     8;
                  8,  1,      3,     8;
                  9,  1,      4,     15;
                 10,  6,      4,     15;
                 11,  2,      4,     15;
                 12,  2,      4,     15;
                 13,  8,      4,     15;
                 14,  11,     4,     15;
                 15,  3,      4,     15;
                 16,  3,      5,     22;
                 17,  11,     5,     22;
                 18,  3,      5,     22;
                 19,  4,      5,     22;
                 20,  12,     5,     22;
                 21,  5,      5,     22;
                 22,  9,      5,     22;
                 23,  14,     6,     24;
                 24,  12,     6,     24;
                 25,  16,     7,     29;
                 26,  21,     7,     29;
                 27,  18,     7,     29;
                 28,  14,     7,     29;
                 29,  23,     7,     29];  

%% ѵ����������
gisData.train_bIdx = 1:29;

%% ���潨��ѡ��
gisData.chkBIdx = 18;
gisData.Slice = gisData.topo(gisData.chkBIdx, 3);

% check whether the setting is valid?
idxSlice = find(gisData.topo(:, 3) == gisData.Slice);
maxBuild =  gisData.topo(idxSlice(1), 4);
if gisData.chkBIdx > maxBuild
    error('The setting for gisData.chkBIdx and gisData.Slice is inconsistent\n');
end

%% ����ѡַ
 % ѡ��S��Χ�ڵĵ���Ϊѡַ��, ��S = inf,��ʾ��ѡ��Ϊ��ͼ�����е�
gisData.S = 4000;  % ѡַ�뾶, ��λm
 % ѡַ��׼�� 1. ֻ����Ȼ���ԣ�2��ֻ��������ԣ�3�����߶���
gisData.PropertyType = 3;


%% �˿�����ģ��
gisData.Population.Model = @(b,x)(b(1)./(1+exp(-b(2)*x+b(3))));
% gisData.Population.RateModel = @(beta, tt)(beta(2)*exp(-beta(2)*tt+beta(3))./(1+exp(-beta(2)*tt+beta(3))));
gisData.Population.RateModel = @(beta, tt)(beta(2)*(1-1./(1+exp(-beta(2)*tt+beta(3)))));
gisData.Population.beta = PopulationSpeed(gisData.Population.Model);
gisData.Population.LoadRate = 1.75;  % �˿ڳ�����
gisData.Population.SplitRate = 0.4286; % ÿ�η���ʱ�������˿ڷ����ȥ
gisData.Population.HakkaRate = 1.006;

%% % ���ڽ�������
% % ѧϰ���� 
% %gisData.Split.Model = @(b,x)(b(1)./x+b(3)*exp(-b(2)*x));
% gisData.Split.Model = @(b,x)(b(2)*exp(b(1)*x));
% %gisData.Split.Model = @(b,x)(b(2)+b(1)./x);
% gisData.SplitProb = 0.11;   % ���Ѹ���
% gisData.Split.beta = SpeedModeling(gisData.Split.Model);

%% ���ڽ�����������
gisData.Expand.Model = @(b,x)(b(1)*(exp(-b(3)*x+b(2))));
gisData.Expand.beta = AreaSpeedModeling(gisData.Expand.Model);
gisData.Expand.Ratio = 107;  % ��ˮ�����ø���/��ˮ���������.
% ��ʼ��
if strcmp(gisData.blocksize, '20x20')
    gisData.StartPoint = [43629,43630];
elseif strcmp(gisData.blocksize, '10x10')
    gisData.StartPoint = [173289];
end
% sum(gisData.data(:,7)==1) = 7; 7*16 = 112;
gisData.StartPopulation = 112;

if gisData.v == 1
    if strcmp(gisData.blocksize, '20x20')
        fprintf('GisData Reading (20x20) ... \n');
    elseif strcmp(gisData.blocksize, '10x10')
        fprintf('GisData Reading (10x10) ... \n');
    end
end

