function gisData = computeGisData_ext(gisData)
% Compute data_ext

if gisData.v == 1,
    fprintf('Computing the extented gisData ... \n');
end

%% ��ȡ������������
b_id_tmp = gisData.data(:,7);  % ��ý������������

tmp = b_id_tmp(find(b_id_tmp>0));   % ȥ���ǽ�������
build_ID = unique(tmp);
% �Խ������ݰ���ŷ���
for i=1:length(build_ID)
    gisData.buildings(i).ID = build_ID(i);
    gisData.buildings(i).data = gisData.data(find(b_id_tmp==build_ID(i)),:);
    gisData.buildings(i).size = size(gisData.buildings(i).data,1); % ������С, �����
    % ���㽨�������ĵ�
    gisData.buildings(i).center = mean(gisData.buildings(i).data(:,2:3),1);
    gisData.buildings(i).iter_ID = gisData.buildings(i).data(1,8);
    gisData.buildings(i).parent_ID = gisData.topo(i,2);
    gisData.buildings(i).fsq_ID = gisData.buildings(i).data(1,20);
    
    % ���ļ����Ƶ�����computeAreaOfBuildingAndLand
    %[gisData.buildings(i).fsq_b_area, gisData.buildings(i).fsq_land] = ...
    %    computeRegionALFsq(gisData, gisData.other_building|gisData.PRE.self_building, gisData.buildings(i).fsq_ID);
end
% Note: ����ʹ��vertcat(d.buildings.data);������ƴ��

%% ������չ����, ��ÿ��block�ܱߵĽ��������������, �Լ��뱾����������������С����
% ����Ľ��������gisData.data_ext��, 
gisData.data_ext = NaN(size(gisData.data,1), gisData.data_ext_num);
% Set all data not in ���� as NaN
% penqu = gisData.data(:,4);
% gisData.data_ext(find(isnan(penqu)),:) = NaN;

gisData = computeAreaOfBuildingAndLand(gisData);
gisData = computeTopoDist(gisData);  % ������չ����: �븸�ڵ�ľ����ϵ


for i=1:length(build_ID)
    gisData.buildings(i).data_ext = gisData.data_ext(find(b_id_tmp==build_ID(i)),:);
end

%% ��ȡ�ǽ�������, ���������Ϊ0������
% gisData.nonbuildings.data = gisData.data(find(b_id_tmp==0),:);