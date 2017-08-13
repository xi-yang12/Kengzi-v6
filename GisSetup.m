function gisData = GisSetup(gisData)
gisData.v = 1;

%% areaType = 1; 圆形区域, 否则方形区域
gisData.areaType = 1;

gisData.R = 500;   % 范围半径, 单位m
gisData.K = 10;     % 取前K个最小距离的平均值作为与居民区的最小距离

gisData.FileName = sprintf('map-%d-P4-4',gisData.R);

%% 同时还计算了每个建筑区域的建筑面积与耕地面积, 还有最小距离, 保存在每个建筑块的信息中(buildings)
gisData.data_ext_num = 8;
gisData.data_ext_name = [{'周边宜耕农田面积'}, {'周边已有居住面积'}, ...
                         {'与外族居住区最小距离'}, {'与本族居住区最小距离'}, ...
                         {'分水区内居住面积'}, {'分水区内耕地面积'}, ...
                         {'与父节点距离'}, {'与祖父节点距离'}
                         ];
%% For GMM
gisData.ModelParam.att = [9:10,12:13,15:17];
gisData.ModelParam.att_ext = [1:2];  % {'周边宜耕农田面积'}, {'周边已有居住面积'}
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
gisData.LR.is_norm = 1;     % 是否需要归一化处理
% gisData.LR.normFun = @(X, V)(MinMax(X, V));
gisData.LR.normFun = @(X, V)(ZScore(X, V));

%% For 


%% 进入疯狂增长的地房面积比
gisData.rateFB = 107.64;

%% 疯狂增长模式 = 1,时表示疯狂增长, 触发为1的条件是[耕地面积与建筑面积比值 < gisData.rateFB] 
gisData.crazy = 0;   

%%              
gisData.curTime = 290; % 当前时间， 从1开始
gisData.Step = 1;    % 仿真时间步长
gisData.PvA = 16;  % 平方米/人

%% 拓扑关系
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

%% 训练参数设置
gisData.train_bIdx = 1:29;

%% 断面建筑选择
gisData.chkBIdx = 18;
gisData.Slice = gisData.topo(gisData.chkBIdx, 3);

% check whether the setting is valid?
idxSlice = find(gisData.topo(:, 3) == gisData.Slice);
maxBuild =  gisData.topo(idxSlice(1), 4);
if gisData.chkBIdx > maxBuild
    error('The setting for gisData.chkBIdx and gisData.Slice is inconsistent\n');
end

%% 用于选址
 % 选择S范围内的点作为选址点, 当S = inf,表示候选点为地图的所有点
gisData.S = 4000;  % 选址半径, 单位m
 % 选址标准： 1. 只用自然属性，2，只用社会属性，3，两者都用
gisData.PropertyType = 3;


%% 人口增长模型
gisData.Population.Model = @(b,x)(b(1)./(1+exp(-b(2)*x+b(3))));
% gisData.Population.RateModel = @(beta, tt)(beta(2)*exp(-beta(2)*tt+beta(3))./(1+exp(-beta(2)*tt+beta(3))));
gisData.Population.RateModel = @(beta, tt)(beta(2)*(1-1./(1+exp(-beta(2)*tt+beta(3)))));
gisData.Population.beta = PopulationSpeed(gisData.Population.Model);
gisData.Population.LoadRate = 1.75;  % 人口承载率
gisData.Population.SplitRate = 0.4286; % 每次分裂时将多少人口分配出去
gisData.Population.HakkaRate = 1.006;

%% % 用于建筑分裂
% % 学习函数 
% %gisData.Split.Model = @(b,x)(b(1)./x+b(3)*exp(-b(2)*x));
% gisData.Split.Model = @(b,x)(b(2)*exp(b(1)*x));
% %gisData.Split.Model = @(b,x)(b(2)+b(1)./x);
% gisData.SplitProb = 0.11;   % 分裂概率
% gisData.Split.beta = SpeedModeling(gisData.Split.Model);

%% 用于建筑面子增长
gisData.Expand.Model = @(b,x)(b(1)*(exp(-b(3)*x+b(2))));
gisData.Expand.beta = AreaSpeedModeling(gisData.Expand.Model);
gisData.Expand.Ratio = 107;  % 分水区可用耕地/分水区建筑面积.
% 起始点
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

