function [gisData, b_Idx] = createNewBuilding(gisData, new_blocks, parent_ID)
% ��new_blocks (n*1)�����½���, ����ʼ��. ��new_blocksΪ��,�򴴽�һ���ս���
b_Idx = gisData.PRE.b_Num + 1;

if gisData.v == 1,
    fprintf('Create new building (%d)... \n', b_Idx);
end

gisData.PRE.b_Num = b_Idx;
gisData.PRE.buildings(b_Idx).ID = b_Idx;
gisData.PRE.buildings(b_Idx).stopped = 0;
gisData.PRE.buildings(b_Idx).parent_ID = parent_ID;

% ��new_blocks����������ʱ
if nargin<2 || sum(new_blocks) <= 0,
    gisData.PRE.buildings(b_Idx).size = 0;
    gisData.PRE.buildings(b_Idx).data = [];
    gisData.PRE.buildings(b_Idx).center = [];
   % gisData.PRE.buildings(b_Idx).fsq_ID = NaN;
    warinig('\tBuinding (%d) is empty! \n', b_Idx);
else   
    gisData.PRE.buildings(b_Idx).size = sum(new_blocks);
    
    block_idx = (new_blocks==1);
    
    gisData.PRE.buildings(b_Idx).data = gisData.data(block_idx,:);
    gisData.PRE.buildings(b_Idx).center = mean(gisData.PRE.buildings(b_Idx).data(:,2:3), 1); 
    % ��һ��block�ķ�ˮ����Ϊ�ý����ķ�ˮ����
    % gisData.PRE.buildings(b_Idx).fsq_ID = gisData.PRE.buildings(b_Idx).data(1,20); 
    % [b_r, l_r] = computeRegionALPoint(gisData, map_building, p_idx)
end
gisData.PRE.buildings(b_Idx).time = gisData.curTime;

% �½���ס���˿ڷ���, �Ӹ��ڵ㻮���˿�
if ~isnan(parent_ID)
    gisData.PRE.buildings(b_Idx).people = gisData.PRE.buildings(parent_ID).people * gisData.Population.SplitRate;
    gisData.PRE.buildings(parent_ID).people = gisData.PRE.buildings(parent_ID).people - gisData.PRE.buildings(b_Idx).people;
end

% ��Щ����ͨ��update����
gisData.PRE.buildings(b_Idx).b_area = NaN;
gisData.PRE.buildings(b_Idx).l_area = NaN;
gisData.PRE.buildings(b_Idx).other_min_dist = NaN;
gisData.PRE.buildings(b_Idx).self_min_dist = NaN;
% gisData.PRE.buildings(b_Idx).fsq_land = NaN;
% gisData.PRE.buildings(b_Idx).fsq_b_area = NaN;

% ����״̬����
gisData = updateBlockStatus(gisData, new_blocks, b_Idx);
