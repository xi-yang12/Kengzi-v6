function m_d = computeMinDistPoint(gisData, map_building, point, K)
all_points = vertcat(gisData.data(:,2:3));
idx1 = (map_building==1);
active_points = all_points(idx1,:);

active_num =  size(active_points,1);
if active_num == 0, 
    m_d = NaN; 
    return;
elseif active_num < K    % ������������blockС��Kʱ, ʹK������Ч��������
    K = active_num;
end

tmp_point = repmat(point, active_num, 1);
tmp_dist = sum((active_points-tmp_point).^2,2);  % �����ƽ��, �ں���sqrt����

m_d = MinAvgKDist(tmp_dist, K);


function avg_d = MinAvgKDist(dist, K)
dist = sort(dist);
if (dist(1)<=0 || isnan(dist(1)))
    error('Are you OK!');
end

avg_d = mean(sqrt(dist(1:K)));