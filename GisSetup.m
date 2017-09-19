function gisData = GisSetup(gisData)
gisData.v = 1;

%% areaType = 1; Բ������, ����������
gisData.areaType = 1;

gisData.R = 140;   % ��Χ�뾶, ��λm
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
gisData.curTime = 30; % ��ǰʱ�䣬 ��1��ʼ
gisData.Step = 1;    % ����ʱ�䲽��
gisData.PvA = 6;  % ��/block

%% ���˹�ϵ
%                 ID, Parent, Slice, the max building in Slice
gisData.topo = [ 1, NaN, 1, 2;
                 2,	1,	1,	2;
                 3,	2,	3,	3;
                 4,	2,	3,	3;
                 5,	3,	5,	5;
                 6,	5,	5,	9;
                 7,	2,	5,	9;
                 8,	5,	5,	9;
                 9,	2,	5,	9;
                10,	2,	5,	9;
                11,	10,	5,	9;
                12,	2,	5,	9;
                13,	6,	6,	13;
                14,	6,	6,	13;
                15,	3,	6,	13;
                16,	6,	6,	13;
                17,	8,	6,	13;
                18,	8,	6,	13;
                19,	8,	6,	13;
                20,	8,	6,	13;
                21,	13,	7,	21;
                22,	18,	9,	22;
                23,	18,	10,	24;
                24,	9,	10,	24;
                25,	9,	11,	25;
                26,	9,	13,	27;
                27,	8,	13,	27;
                28,	25,	14,	34;
                29,	8,	14,	34;
                30,	12,	14,	34;
                31,	27,	14,	34;
                32,	25,	14,	34;
                33,	25,	14,	34;
                34,	28,	14,	34;
                35,	27,	14,	34;
                36,	25,	14,	34;
                37,	3,	14,	34;
                38,	28,	14,	34;
                39,	2,	14,	34;
                40,	7,	14,	34;
                41,	24,	14,	34;
                42,	24,	14,	34;
                43,	24,	14,	34;
                44,	24,	14,	34;
                45,	14,	15,	52;
                46,	31,	15,	52;
                47,	1,	15,	52;
                48,	14,	15,	52;
                49,	5,	15,	52;
                50,	25,	15,	52;
                51,	26,	15,	52;
                52,	24,	15,	52;
                53,	25,	15,	52;
                54,	26,	15,	52;
                55,	16,	15,	52;
                56,	24,	15,	52;
                57,	2,	15,	52;
                58,	6,	15,	52;
                59,	26,	15,	52;
                60,	15,	15,	52;
                61,	11,	15,	52;
                62,	24,	15,	52;
                63,	6,	15,	52;
                64,	26,	15,	52;
                65,	43,	15,	52;
                66,	29,	15,	52;
                67,	6,	15,	52;
                68,	39,	15,	52;
                69,	13,	16,	76;
                70,	13,	16,	76;
                71,	13,	16,	76;
                72,	40,	16,	76;
                73,	9,	16,	76;
                74,	72,	16,	76;
                75,	2,	16,	76;
                76,	11,	16,	76;
                77,	4,	16,	76;
                78,	65,	16,	76;
                79,	21,	16,	76;
                80,	40,	16,	76;
                81, 2,  17, 129;
                82, 2,  17, 129;
                83, 2,  17, 129;
                84, 8,  17, 129;
                85, 8,  17, 129;
                86, 8,  17, 129;
                87, 8,  17, 129;
                88, 9,  17, 129;
                89, 11, 17, 129;
                90, 13, 17, 129;
                91, 18, 17, 129;
                92, 19, 17, 129;
                93, 17, 17, 129;
                94, 25, 17, 129;
                95, 25, 17, 129;
                96, 33, 17, 129;
                97, 27, 17, 129;
                98, 27, 17, 129;
                99, 29, 17, 129;
                100,31, 17, 129;
                101,46, 17, 129;
                102,43, 17, 129;
                103,43, 17, 129;
                104,42, 17, 129;
                105,34, 17, 129;
                106,55, 17, 129;
                107,16, 17, 129;
                108,63, 17, 129;
                109,63, 17, 129;
                110,63, 17, 129;
                111,63, 17, 129;
                112,63, 17, 129;
                113,67, 17, 129;
                114,67, 17, 129;
                115,69, 17, 129;
                116,72, 17, 129;
                117,69, 17, 129;
                118,56, 17, 129;
                119,58, 17, 129;
                120,76, 17, 129;
                121,40, 17, 129;
                122,51, 17, 129;
                123,47, 17, 129;
                124,34, 17, 129;
                125,34, 17, 129;
                126,38, 17, 129;
                127,38, 17, 129;
                128,38, 17, 129;
                129,41, 17, 129;
                130,41, 17, 129];  

%% ѵ����������
gisData.train_bIdx = 1:32;

% % ���潨��ѡ��
% gisData.chkBIdx = 80;
% gisData.Slice = gisData.topo(gisData.chkBIdx, 3);
% % check whether the setting is valid?
% idxSlice = find(gisData.topo(:, 3) == gisData.Slice);
% maxBuild =  gisData.topo(idxSlice(1), 4);
% if gisData.chkBIdx > maxBuild
%     error('The setting for gisData.chkBIdx and gisData.Slice is inconsistent\n');
% end

gisData.Slice_v7 = 130; % for CA_v7_EvalBlocks.m

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
gisData.Expand.Ratio = 5.84;  % �����뾶�ڿ��ø���/�����뾶�ڽ������.
% ��ʼ��
if strcmp(gisData.blocksize, '10x10')
    gisData.StartPoint = [40022,40023,40024,40025,40026,34718,34719,34720,34721,34722,34723,34724,34725,35050,35051,35052,35053,35054,35055,35056,35057,35058,35381,35382,35383,35384,35385,35386,35387,35388,35389,35390,35391,35707,35708,35710,35711,35712,35713,35714,35715,35716,35717,35718,35719,35720,35721,35722,36037,36038,36039,36040,36041,36042,36043,36044,36045,36046,36047,36048,36049,36050];
    gisData.startBuilding(1).blocks = [40022,40023,40024,40025,40026];
    gisData.startBuilding(1).parent = NaN;
    gisData.startBuilding(1).StartPopulation = length(gisData. startBuilding(1).blocks)* gisData.PvA;
    gisData.startBuilding(2).blocks = [34718,34719,34720,34721,34722,34723,34724,34725,35050,35051,35052,35053,35054,35055,35056,35057,35058,35381,35382,35383,35384,35385,35386,35387,35388,35389,35390,35391,35707,35708,35710,35711,35712,35713,35714,35715,35716,35717,35718,35719];
    gisData.startBuilding(2).parent = 1;
    gisData.startBuilding(2).StartPopulation = length(gisData.startBuilding(2).blocks)* gisData.PvA;
    gisData.startBuilding(3).blocks = [71135,71465,71466,71467,71796,71797,71798,71799,72129,72130,72131];
    gisData.startBuilding(3).parent = 2;
    gisData.startBuilding(3).StartPopulation = length(gisData. startBuilding(3).blocks)* gisData.PvA;  
    gisData.startBuilding(4).blocks = [38366,38698,38699,38700,38701,39030,39031,39362];
    gisData.startBuilding(4).parent = 2;
    gisData.startBuilding(4).StartPopulation = length(gisData. startBuilding(4).blocks)* gisData.PvA; 
    gisData.startBuilding(5).blocks = [63830,63831,64161,64162,64163,64164,64492,64493,64494,64495,64496,64824,64825,64826,64827,65156,65157,65158,65159,65488,65489,65490,65491,65821,65822,65823,65824,66154,66155];
    gisData.startBuilding(5).parent = 3;
    gisData.startBuilding(5).StartPopulation = length(gisData. startBuilding(5).blocks)* gisData.PvA;     
    gisData.startBuilding(6).blocks = [73476,73477,73808,73809,73810,73811,73812,73813,73814,73815,74143,74144];
    gisData.startBuilding(6).parent = 5;
    gisData.startBuilding(6).StartPopulation = length(gisData. startBuilding(6).blocks)* gisData.PvA;     
    
%elseif strcmp(gisData.blocksize, '10x10')
    %gisData.StartPoint = [39692];
end
% sum(gisData.data(:,7)==1) = 7; 7*16 = 112;

if gisData.v == 1
    if strcmp(gisData.blocksize, '20x20')
        fprintf('GisData Reading (20x20) ... \n');
    elseif strcmp(gisData.blocksize, '10x10')
        fprintf('GisData Reading (10x10) ... \n');
    end
end

