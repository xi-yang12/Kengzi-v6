function gisData = GisSetup4_LGXX(gisData)
gisData.v = 1;

% areaType = 1; 圆形区域, 否则方形区域
gisData.areaType = 1;

gisData.R = 550;   % 范围半径, 单位m
gisData.K = 10;     % 取前K个最小距离的平均值作为与居民区的最小距离

gisData.FileName = sprintf('map-lgxx-%d-P4-7',gisData.R);
gisData.desp = '版本7：起点建筑个数设置为3个. 新增一些河流数据';

% 同时还计算了每个建筑区域的建筑面积与耕地面积, 还有最小距离, 保存在每个建筑块的信息中(buildings)
gisData.data_ext_num = 8;

gisData.Expand = [2     3	4	5	6	7; ...
                  0.5   0.8 0.9 0.96 0.99 1];

              
gisData.curTime = 30; % 当前时间， 从1开始
gisData.Step = 1;    % 仿真时间步长
gisData.PvA = 16;  % 平方米/人

% 用于选址
 % 选择S范围内的点作为选址点, 当S = inf,表示候选点为地图的所有点
gisData.S = 4000;  % 选址半径, 单位m
 % 选址标准： 1. 只用自然属性，2，只用社会属性，3，两者都用
gisData.PropertyType = 3;


% 人口增长模型
gisData.Population.Model = @(b,x)(b(1)./(1+exp(-b(2)*x+b(3))));
% gisData.Population.RateModel = @(beta, tt)(beta(2)*exp(-beta(2)*tt+beta(3))./(1+exp(-beta(2)*tt+beta(3))));
gisData.Population.RateModel = @(beta, tt)(beta(2)*(1-1./(1+exp(-beta(2)*tt+beta(3)))));
gisData.Population.beta = PopulationSpeed(gisData.Population.Model);
gisData.Population.LoadRate = 1.75;  % 人口承载率
gisData.Population.SplitRate = 0.4286; % 每次分裂时将多少人口分配出去
gisData.Population.HakkaRate = 1.006;

% % 用于建筑分裂
% % 学习函数 
% %gisData.Split.Model = @(b,x)(b(1)./x+b(3)*exp(-b(2)*x));
% gisData.Split.Model = @(b,x)(b(2)*exp(b(1)*x));
% %gisData.Split.Model = @(b,x)(b(2)+b(1)./x);
% gisData.SplitProb = 0.11;   % 分裂概率
% gisData.Split.beta = SpeedModeling(gisData.Split.Model);

% 用于建筑面子增长
gisData.Expand.Model = @(b,x)(b(1)*(exp(-b(3)*x+b(2))));
gisData.Expand.beta = AreaSpeedModeling(gisData.Expand.Model);
gisData.Expand.Ratio = 35;  % 分水区可用耕地/分水区建筑面积.
% 起始点
if strcmp(gisData.blocksize, '20x20'),
    gisData.StartPoint(1).pointID = [23533];
    gisData.StartPoint(1).people = 64;
    gisData.StartPoint(2).pointID = [41593];
    gisData.StartPoint(2).people = 48;
    gisData.StartPoint(3).pointID = [27355];
    gisData.StartPoint(3).people = 32;
elseif strcmp(gisData.blocksize, '10x10'),
    error('Not given');
end
% sum(gisData.data(:,7)==1) = 7; 7*16 = 112;
% gisData.StartPopulation = 144;

if gisData.v == 1,
    if strcmp(gisData.blocksize, '20x20'),
        fprintf('GisData Reading (20x20) ... \n');
    elseif strcmp(gisData.blocksize, '10x10'),
        fprintf('GisData Reading (10x10) ... \n');
    end
end

