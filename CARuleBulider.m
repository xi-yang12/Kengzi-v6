function gisData = CARuleBulider4(gisData)
%% Step 1: �˿�����
currP = gisData.Population.Model(gisData.Population.beta, gisData.curTime);
nextP = gisData.Population.Model(gisData.Population.beta, gisData.curTime + gisData.Step);
rateP = nextP/currP;
for i=1:length(gisData.PRE.buildings)
    gisData.PRE.buildings(i).people = rateP * gisData.PRE.buildings(i).people % * gisData.Population.HakkaRate;
end
% ��ǰʱ������
gisData.curTime  = gisData.curTime + gisData.Step;
if gisData.v == 1,
    fprintf('The current time is [%d]. \n', gisData.curTime);
end


%% Step2: ��ס���������
is_update = 0;
b_Idxs = find([gisData.PRE.buildings.stopped]==0);
for i = b_Idxs
    % 2.1 ��������block����
    deltaP = gisData.PRE.buildings(i).people - (gisData.PRE.buildings(i).size * gisData.PvA);
    numB = fix(deltaP/gisData.PvA);
    % 2.2 �ж��Ƿ���Ҫ����
    if numB > 0
        gisData = ExpandBuilding(gisData, i, numB);
        is_update = 1;
    end
    % 2.3 �ж��Ƿ�ֹͣ����
    if isToExpand(gisData, i) ~= 1,
        gisData.PRE.buildings(i).stopped = 1;
    end
end
% ����
if is_update
    gisData = updatePRE(gisData);
end


%% Step3�� ����������
b_Idxs = find([gisData.PRE.buildings.stopped]==1);
for i = b_Idxs
    if isToSplit(gisData, i)==1,
        gisData = SplitBuilding(gisData, i);
        gisData = updatePRE(gisData);
    end
end
gisData.map.a = data_deshape(gisData.PRE.self_building, gisData.row, gisData.col);


function b_expand = isToExpand(gisData, b_Idx)
other_building = gisData.other_building; % ���վ�ס��
self_building = gisData.PRE.self_building;% ���վ�ס��

% b_feature = [gisData.PRE.buildings(b_Idx).size; 
% gisData.PRE.buildings(b_Idx).b_area; 
% gisData.PRE.buildings(b_Idx).l_area; 
% gisData.PRE.buildings(b_Idx).other_min_dist; 
% gisData.PRE.buildings(b_Idx).self_min_dist];
% if b_feature(1) < 3,
%     b_expand = 1;
%     return;
% else
%     prob = 1/(b_feature(1)-2);
%     if prob > rand*0.7,
%         b_expand = 1;
%         return;
%     end
% end

% �����Ƿ���չ���������ؾ���, һ���������С, ��һ���Ǹ����뾶�ڷ��رȣ�
prob = 1/gisData.PRE.buildings(b_Idx).size;
if prob > rand*0.5
    % �������: ��ˮ�����ø���/��ˮ���������.
%     ratio = gisData.PRE.buildings(b_Idx).fsq_land / gisData.PRE.buildings(b_Idx).fsq_b_area;
%     if gisData.crazy==1 || ratio > gisData.Expand.Ratio+10-20*rand, 
    % ��������������뾶��Χ�ڸ������/�����뾶�ڽ������
       [B, L] = computeALPoint(gisData, other_building|self_building, gisData.PRE.buildings(b_Idx).center, gisData.R);
       ratio = L/B;
       if ratio > gisData.Expand.Ratio+2-4*rand
           b_expand = 1;
           return;
       end  
end

b_expand = 0;

if gisData.v == 1,
    fprintf('Building (%d) stops expanding. \n', b_Idx);
end


function gisData = ExpandBuilding(gisData, b_Idx, e_num)
% ����b_Idx����ס������e_num���
% ���������Ҫ�����ĸ���, �������ü� gisData.Expand <- GisSetup
if gisData.v == 1,
    fprintf('Expanding Building (%d)... \n', b_Idx);
end
if e_num < 1
    fprintf('No block is added to Building (%d)..., [e_mun = %d] \n', b_Idx, e_num);
    return;
end


%index definition for cell update
x = 2:gisData.row-1;
y = 2:gisData.col-1;

% ��ñ��Ϊb_Idx�Ľ���block
bb_idx = (gisData.PRE.b_ID == b_Idx);

% nearest neighbor sum ����9����
map_sum = zeros(gisData.row, gisData.col);
map_matrix = data_deshape(bb_idx, gisData.row, gisData.col);
map_sum(x,y) = map_matrix(x, y-1) + map_matrix(x, y+1) + ...
           map_matrix(x-1, y) + map_matrix(x+1, y) + ...
           map_matrix(x-1, y-1) + map_matrix(x-1, y+1) + ... 
           map_matrix(x+1, y-1) + map_matrix(x+1, y+1);

map_vector = data_enshape(map_sum, gisData.row, gisData.col);

newblocks = false(size(map_vector));
% ��ȡ��Ԫ���Զ�������չ��block
tmp_idx = find(((map_vector>0) & not(bb_idx)));

if e_num > sum(tmp_idx),  % ��ѡ�������������������������, ����ֻ��������������block
    newblocks(tmp_idx) = 1;
else  % ����ѡ��ǰe_num��
    % ������Щ���������Ȼ����
    % gisData.PRE.lp_attribute + P(other_min_dist) + P(Neighbor)
    b_blocks_prob = NaN(size(map_vector));
    b_blocks_prob(tmp_idx) = gisData.PRE.lp_attribute(tmp_idx) + ...
                             gisData.PRE.lp_other_min_dist(tmp_idx) + ...
                             log(map_vector(tmp_idx)/8); %+ gisData.PRE.lp_fsq_area(tmp_idx);
    for i=1:e_num
        [max_v, max_idx] = max(b_blocks_prob);
        
        % �ž����ֵΪNaN�����, ��������ֹ�ý�������չ
        if isnan(max_v)
            break;
        end
        
        newblocks(max_idx) = 1;
        b_blocks_prob(max_idx) = NaN;
        fprintf('\t\tBlock(%d) with value (%f) are added to building [%d].\n', max_idx, max_v, b_Idx);
    end
end

gisData = addBlocksToBuilding(gisData, b_Idx, newblocks);
if gisData.v == 1,
    fprintf('\t [%d] blocks are added to Building (%d). \n', e_num, b_Idx);
end


function b_split = isToSplit(gisData, b_Idx)
% ���㽨�����˿ڳ��ر���
ratePvA = gisData.PRE.buildings(b_Idx).people / (gisData.PRE.buildings(b_Idx).size * gisData.PvA);
if ratePvA > gisData.Population.LoadRate
    b_split = 1;
else
    b_split = 0;
end


function gisData = SplitBuilding(gisData, b_Idx)
if gisData.v == 1,
    fprintf('Spliting Building (%d)... \n', b_Idx);
end

% Step 1: ѡַ
% ��ΧS�ڵ�����block����Ϊ��ѡ��
c_idx = (gisData.PRE.status_candidate==1);
all_points = gisData.data(:,2:3);
b_center = gisData.PRE.buildings(b_Idx).center;
t_idx = c_idx & ((abs(all_points(:,1)-b_center(1))<=gisData.S) & (abs(all_points(:,2)-b_center(2))<=gisData.S)); 

% ������Ȼ����
c_prob = computeSplitLogProp(gisData, t_idx, b_Idx); %���ݣ���ѡ�㣬�������
            
[m_value, block_idx] = max(c_prob);

if gisData.v == 1,
    fprintf('\tBlock %d (value=%f) is selected as a starting point...\n', block_idx, m_value);
end

new_blocks = false(size(gisData.PRE.status_candidate));

new_blocks(block_idx) = 1;
[gisData, new_b_Idx] = createNewBuilding(gisData, new_blocks, b_Idx);

