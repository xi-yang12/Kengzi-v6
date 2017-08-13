function [b_r, l_r] = computeRegionALPoint(gisData, map_building, p_idx)
% ����ĳһ����p_idx������ˮ�����ڵĿ��ø�������;�ס���

region = gisData.data(:, 20);  % ��ˮ������
l_idx = (gisData.data(:,5)==1);  % ����

p_r_id = region(p_idx);   % ��õ�ķ������

if isnan(p_r_id)
    error('Are you OK???!!!');
end

p_region = (region==p_r_id);   % ��λp_idx�ķ���
b_blocks = p_region & map_building;  % �����ڽ���

b_r = sum(b_blocks); % �����ڽ���

% �����ڿ��ø������ = ���������и��� - ������ռ�õĸ���
l_r = sum(p_region & l_idx) - sum(b_blocks & l_idx);