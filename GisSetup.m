function gisData = GisSetup(gisData)
gisData.v = 1;

%% areaType = 1; Բ������, ����������
gisData.areaType = 1;

gisData.R = 300;   % ��Χ�뾶, ��λm
gisData.K = 10;     % ȡǰK����С�����ƽ��ֵ��Ϊ�����������С����
gisData.N = 17;      % ��������ʱ���������

gisData.FileName = sprintf('map-%d-P4-4',gisData.R);

%% ͬʱ��������ÿ����������Ľ��������������, ������С����, ������ÿ�����������Ϣ��(buildings)
gisData.data_ext_num = 8;
gisData.data_ext_name = [{'�ܱ��˸�ũ�����'}, {'�ܱ����о�ס���'}, ...
                         {'�������ס����С����'}, {'�뱾���ס����С����'}, ...
                         {'��ˮ���ھ�ס���'}, {'��ˮ���ڸ������'}, ...
                         {'�븸�ڵ����'}, {'���游�ڵ����'}
                         ];
%% For GMM
gisData.ModelParam.att = [9:13,15,17];
gisData.ModelParam.farm = [5]; %�Ƿ��������˸���
gisData.ModelParam.otHouse = [6]; %���������ս�����
gisData.ModelParam.seHouse = [7]; %�����ڱ��ս�����
gisData.ModelParam.era = [8]; %������������
gisData.ModelParam.river = [18];%�Ƿ����
gisData.ModelParam.farmout = [23];%�Ƿ��������˸���
gisData.ModelParam.houseout = [24];%�����⽨��

%%%%%%%%%%%%
gisData.ModelParam.att_ext = [1:2];  % {'�ܱ��˸�ũ�����'}, {'�ܱ����о�ס���'}
gisData.ModelParam.dOther = [3];
gisData.ModelParam.dSelf = [4];
gisData.ModelParam.distP = [7];
gisData.ModelParam.distPP = [8];
gisData.ModelParam.fsqArea = [];


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
gisData.rateFB = 8.6;

%% �������ģʽ = 1,ʱ��ʾ�������, ����Ϊ1��������[��������뽨�������ֵ < gisData.rateFB] 
gisData.crazy = 0;   

%%              
gisData.curTime = 10; % ��ǰʱ�䣬 ��1��ʼ
gisData.Step = 1;    % ����ʱ�䲽��
gisData.PvA = 12;  % ƽ����/��

%% ���˹�ϵ
%                 ID, Parent, Slice, the max building in Slice
gisData.topo = [ 1, NaN, 1, 2;
                 2,	1,	1,	2;
                 3,	2,	2,	3;
                 4,	2,	2,	3;
                 5,	3,	3,	5;
                 6,	5,	4,	9;
                 7,	2,	4,	9;
                 8,	5,	4,	9;
                 9,	2,	4,	9;
                10,	2,	4,	9;
                11,	10,	4,	9;
                12,	2,	4,	9;
                13,	6,	5,	13;
                14,	6,	5,	13;
                15,	3,	5,	13;
                16,	6,	5,	13;
                17,	8,	5,	13;
                18,	8,	5,	13;
                19,	8,	5,	13;
                20,	8,	5,	13;
                21,	13,	6,	21;
                22,	18,	7,	22;
                23,	18,	8,	24;
                24,	9,	8,	24;
                25,	9,	9,	25;
                26,	9,	10,	27;
                27,	8,	10,	27;
                28,	25,	11,	34;
                29,	8,	11,	34;
                30,	12,	11,	34;
                31,	27,	11,	34;
                32,	25,	11,	34;
                33,	25,	11,	34;
                34,	28,	11,	34;
                35,	27,	11,	34;
                36,	25,	11,	34;
                37,	3,	11,	34;
                38,	28,	11,	34;
                39,	2,	11,	34;
                40,	7,	11,	34;
                41,	24,	11,	34;
                42,	24,	11,	34;
                43,	24,	11,	34;
                44,	24,	11,	34;
                45,	14,	12,	52;
                46,	31,	12,	52;
                47,	1,	12,	52;
                48,	14,	12,	52;
                49,	5,	12,	52;
                50,	25,	12,	52;
                51,	26,	12,	52;
                52,	24,	12,	52;
                53,	25,	12,	52;
                54,	26,	12,	52;
                55,	16,	12,	52;
                56,	24,	12,	52;
                57,	2,	12,	52;
                58,	6,	12,	52;
                59,	26,	12,	52;
                60,	15,	12,	52;
                61,	11,	12,	52;
                62,	24,	12,	52;
                63,	6,	12,	52;
                64,	26,	12,	52;
                65,	43,	12,	52;
                66,	29,	12,	52;
                67,	6,	12,	52;
                68,	39,	12,	52;
                69,	13,	13,	76;
                70,	13,	13,	76;
                71,	13,	13,	76;
                72,	40,	13,	76;
                73,	9,	13,	76;
                74,	72,	13,	76;
                75,	2,	13,	76;
                76,	11,	13,	76;
                77,	4,	13,	76;
                78,	65,	13,	76;
                79,	21,	13,	76;
                80,	40,	13,	76;
                81, 2,  14, 29;
                82, 2,  14, 29;
                83, 2,  14, 29;
                84, 8,  14, 29;
                85, 8,  14, 29;
                86, 8,  14, 29;
                87, 8,  14, 29;
                88, 9,  14, 29;
                89, 11, 14, 29;
                90, 13, 14, 29;
                91, 18, 14, 29;
                92, 19, 14, 29;
                93, 17, 14, 29;
                94, 25, 14, 29;
                95, 25, 14, 29;
                96, 33, 14, 29;
                97, 27, 14, 29;
                98, 27, 14, 29;
                99, 29, 14, 29;
                100,31, 14, 29;
                101,46, 14, 29;
                102,43, 14, 29;
                103,43, 14, 29;
                104,42, 14, 29;
                105,34, 14, 29;
                106,55, 14, 29;
                107,16, 14, 29;
                108,63, 14, 29;
                109,63, 14, 29;
                110,63, 14, 29;
                111,63, 14, 29;
                112,63, 14, 29;
                113,67, 14, 29;
                114,67, 14, 29;
                115,69, 14, 29;
                116,72, 14, 29;
                117,69, 14, 29;
                118,56, 14, 29;
                119,58, 14, 29;
                120,76, 14, 29;
                121,40, 14, 29;
                122,51, 14, 29;
                123,47, 14, 29;
                124,34, 14, 29;
                125,34, 14, 29;
                126,38, 14, 29;
                127,38, 14, 29;
                128,38, 14, 29;
                129,41, 14, 29;
                130,41, 14, 29];  

%% ѵ����������
gisData.train_bIdx = 1:27;

%% ���潨��ѡ��
% gisData.chkBIdx = 47;
% gisData.Slice = gisData.topo(gisData.chkBIdx, 3);
% 
% % check whether the setting is valid?
% idxSlice = find(gisData.topo(:, 3) == gisData.Slice);
% maxBuild =  gisData.topo(idxSlice(1), 4);
% if gisData.chkBIdx > maxBuild
%     error('The setting for gisData.chkBIdx and gisData.Slice is inconsistent\n');
% end

%% ����ѡַ
 % ѡ��S��Χ�ڵĵ���Ϊѡַ��, ��S = inf,��ʾ��ѡ��Ϊ��ͼ�����е�
gisData.S = 2700;  % ѡַ�뾶, ��λm
 % ѡַ��׼�� 1. ֻ����Ȼ���ԣ�2��ֻ��������ԣ�3�����߶���
gisData.PropertyType = 3;


%% �˿�����ģ��
gisData.Population.Model = @(b,x)(b(1)./(1+exp(-b(3)*x+b(2))) + b(4)./(1+exp(-b(6)*x+b(5)))+b(7)); %@(b,x)(b(1)./(1+exp(-b(2)*x+b(3))));
% gisData.Population.beta = PopulationSpeed(gisData.Population.Model);
gisData.Population.beta = [0.241487476655377, 7.365943709314174, 0.053007017209444, 0.773927028978269, 14.564728415501547, 0.032506691025711, 0.046911822524706, 0.056582861892988];
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

%% ���ڽ����������
% gisData.Expand.Model = @(b,x)(b(1)*(exp(-b(3)*x+b(2))));
% gisData.Expand.beta = AreaSpeedModeling(gisData.Expand.Model);
gisData.Expand.Ratio = 9;  % �����뾶�ڿ��ø���/�����뾶�ڽ������.
% ��ʼ��
if strcmp(gisData.blocksize, '10x10')
    gisData.StartPoint = [40022,40023,40024,40025,40026,34718,34719,34720,34721,34722,34723,34724,34725,35050,35051,35052,35053,35054,35055,35056,35057,35058,35381,35382,35383,35384,35385,35386,35387,35388,35389,35390,35391,35707,35708,35710,35711,35712,35713,35714,35715,35716,35717,35718,35719,35720,35721,35722,36037,36038,36039,36040,36041,36042,36043,36044,36045,36046,36047,36048,36049,36050];
%elseif strcmp(gisData.blocksize, '10x10')
    %gisData.StartPoint = [39692];
end
% sum(gisData.data(:,7)==1) = 7; 7*16 = 112;
gisData.StartPopulation = 42;

if gisData.v == 1
    if strcmp(gisData.blocksize, '20x20')
        fprintf('GisData Reading (20x20) ... \n');
    elseif strcmp(gisData.blocksize, '10x10')
        fprintf('GisData Reading (10x10) ... \n');
    end
end

