function gisData = GisSetup4_LGXX(gisData)
gisData.v = 1;

% areaType = 1; Բ������, ����������
gisData.areaType = 1;

gisData.R = 550;   % ��Χ�뾶, ��λm
gisData.K = 10;     % ȡǰK����С�����ƽ��ֵ��Ϊ�����������С����

gisData.FileName = sprintf('map-lgxx-%d-P4-7',gisData.R);
gisData.desp = '�汾7����㽨����������Ϊ3��. ����һЩ��������';

% ͬʱ��������ÿ����������Ľ��������������, ������С����, ������ÿ�����������Ϣ��(buildings)
gisData.data_ext_num = 8;

gisData.Expand = [2     3	4	5	6	7; ...
                  0.5   0.8 0.9 0.96 0.99 1];

              
gisData.curTime = 30; % ��ǰʱ�䣬 ��1��ʼ
gisData.Step = 1;    % ����ʱ�䲽��
gisData.PvA = 16;  % ƽ����/��

% ����ѡַ
 % ѡ��S��Χ�ڵĵ���Ϊѡַ��, ��S = inf,��ʾ��ѡ��Ϊ��ͼ�����е�
gisData.S = 4000;  % ѡַ�뾶, ��λm
 % ѡַ��׼�� 1. ֻ����Ȼ���ԣ�2��ֻ��������ԣ�3�����߶���
gisData.PropertyType = 3;


% �˿�����ģ��
gisData.Population.Model = @(b,x)(b(1)./(1+exp(-b(2)*x+b(3))));
% gisData.Population.RateModel = @(beta, tt)(beta(2)*exp(-beta(2)*tt+beta(3))./(1+exp(-beta(2)*tt+beta(3))));
gisData.Population.RateModel = @(beta, tt)(beta(2)*(1-1./(1+exp(-beta(2)*tt+beta(3)))));
gisData.Population.beta = PopulationSpeed(gisData.Population.Model);
gisData.Population.LoadRate = 1.75;  % �˿ڳ�����
gisData.Population.SplitRate = 0.4286; % ÿ�η���ʱ�������˿ڷ����ȥ
gisData.Population.HakkaRate = 1.006;

% % ���ڽ�������
% % ѧϰ���� 
% %gisData.Split.Model = @(b,x)(b(1)./x+b(3)*exp(-b(2)*x));
% gisData.Split.Model = @(b,x)(b(2)*exp(b(1)*x));
% %gisData.Split.Model = @(b,x)(b(2)+b(1)./x);
% gisData.SplitProb = 0.11;   % ���Ѹ���
% gisData.Split.beta = SpeedModeling(gisData.Split.Model);

% ���ڽ�����������
gisData.Expand.Model = @(b,x)(b(1)*(exp(-b(3)*x+b(2))));
gisData.Expand.beta = AreaSpeedModeling(gisData.Expand.Model);
gisData.Expand.Ratio = 35;  % ��ˮ�����ø���/��ˮ���������.
% ��ʼ��
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

