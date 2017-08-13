function [b_r, l_r] = computeRegionALFsq(gisData, map_building, p_r_id)
% ����ĳ��ˮ����p_r_id�ڵĿ��ø�������;�ס���

region = gisData.data(:, 20);  % ��ˮ������
l_idx = (gisData.data(:,5)==1);  % ����

if isnan(p_r_id)
    error('Are you OK???!!!');
end

p_region = (region==p_r_id);   % ��λp_idx�ķ���
b_blocks = p_region & map_building;  % �����ڽ���

b_r = sum(b_blocks); % �����ڽ���

% �����ڿ��ø������ = ���������и��� - ������ռ�õĸ���
l_r = sum(p_region & l_idx) - sum(b_blocks & l_idx);