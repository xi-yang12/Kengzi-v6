function [b_a, l_a] = computeALPoint(gisData, map_building, point, R)
% ��������㷶Χ�ڵľ�ס����͸������
% all_points = vertcat(gisData.data(:,2:3));
% tmp_loc = repmat(point, size(all_points,1), 1);
% idx = find(sqrt(sum((all_points-tmp_loc).^2,2))<=R); % ��Χ�ڵĵ�
% b_a = sum(map_building(idx));
% l_a = sum(gisData.data(idx,5)==1) - b_a;  % ȥ����������еĽ������

% ������block�洢����, ��������ÿ�ζ���ȡ
persistent l_points;
persistent l_idx;
if isempty(l_points) & isempty(l_idx)
    l_idx = (gisData.data(:,5)==1);
    l_points = gisData.data(l_idx,2:3);
end

%% ����Ĵ���Ч��̫��
b_idx = (map_building==1);
b_points = gisData.data(b_idx,2:3);  % ���н����ĵ�

t_b_idx = ((abs(b_points(:,1)-point(1))<=R) & (abs(b_points(:,2)-point(2))<=R));
b_and_l_00 = t_b_idx & l_idx(b_idx); % �����������ռ�ø������, Ҳ���ܲ�ռ��, �ڼ���ʱ��Ҫ��ȥ��һ����
if gisData.areaType == 0,  % ����
    b_a = sum(t_b_idx);  
    b_and_r = sum(b_and_l_00);
else   % Բ��
    % ��ΪԲ��, �����Ȳ��÷���ѡ�������ڵĵ�,���ҳ�Բ���еĵ�, ��ҪΪ�����Ч��
    t_b_points = b_points(t_b_idx, :);  
    tmp_loc1 = repmat(point, size(t_b_points,1), 1);
    rb_idx = (sum((t_b_points-tmp_loc1).^2,2)<= (R*R)); % Բ�η�Χ�ڵĽ�����
    b_a = sum(rb_idx);
    
    b_and_l_tt = b_and_l_00(t_b_idx);  % �����ڵĵ�
    b_and_l = sum(b_and_l_tt(rb_idx)); % Բ���ڵĵ�, ��ͳ�Ƹ���
end

%% ������ø������
t_l_idx = ((abs(l_points(:,1)-point(1))<=R) & (abs(l_points(:,2)-point(2))<=R));
if gisData.areaType == 0,  % ����
    l_a =sum(t_l_idx) - b_and_l;  
else
    t_l_points = l_points(t_l_idx, :);
    tmp_loc2 = repmat(point, size(t_l_points,1), 1);
    rl_idx = (sum((t_l_points-tmp_loc2).^2,2) <= (R*R)); % Բ�η�Χ�ڵĸ��ص�

    l_a =sum(rl_idx) - b_and_l;
end




