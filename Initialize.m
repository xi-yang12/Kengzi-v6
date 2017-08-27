function gisData = Initialize(gisData)
if gisData.v == 1
    fprintf('Initializing ... \n');
end

row = gisData.row;
col = gisData.col;

gisData.map.a = zeros(row,col);
gisData.map.b = gisData.map.a;
gisData.map.c = gisData.map.a;

% ��ʼ��gisData.PRE, ��������Ԥ��
gisData = InitGisDataPRE(gisData);

% ��ʼ��һ�����������ѡַ����ʼ��
gisData = InitStartPoints(gisData);

% ����gisData.PRE
gisData = updatePRE(gisData);


% ���ɿ��ӻ�����
gisData.map.a = data_deshape(gisData.PRE.self_building, row, col);
%tmp_c = data_deshape(gisData.data(:,4), row, col);  % ����
f1 = (gisData.data(:,gisData.ModelParam.farm)==1);
f2 = (gisData.data(:,gisData.ModelParam.farmout)==1);
F = f1 | f2;
tmp_c = data_deshape(F, row, col)+1;  % ���˸���
gisData.map.c = 0.8*tmp_c/max(max(tmp_c));
%c(find(c<0)) = 1;
gisData.map.b = (data_deshape(gisData.data(:,6), row, col)>0);
%b = data_deshape(data(:,4), row, col);
%b = 1 - 0.4*b/max(max(b));


function gisData = InitStartPoints(gisData)
%     % ��ʼ��һ�����������ѡַ����ʼ��
% new_blocks  = false(size(gisData.PRE.self_building));
% % new_blocks(173289) = 1;  % for 10x10
% new_blocks(gisData.StartPoint) = 1;   % for 20x20
% 
% [gisData, b_Idx] = createNewBuilding(gisData, new_blocks, NaN);

for i = 1:length(gisData.StartPoint)
    % ��ʼ��һ�����������ѡַ����ʼ��
    new_blocks  = false(size(gisData.PRE.self_building));
    new_blocks(gisData.StartPoint(i)) = 1;   % for 20x20
    [gisData, b_Idx] = createNewBuilding(gisData, new_blocks, NaN);

    % ��parent_ID==NaNΪ��ʼ��
    gisData.PRE.buildings(b_Idx).people = gisData.StartPopulation;
end

% for i = gisData.train_bIdx
    % ��ʼ��һ�����������ѡַ����ʼ��
%     new_blocks = (gisData.data(:,7)==i);
% 
%     [gisData, b_Idx] = createStartingBuilding(gisData, new_blocks, gisData.topo(i,2));
%     gisData.PRE.buildings(b_Idx).stopped = 1;
% end



