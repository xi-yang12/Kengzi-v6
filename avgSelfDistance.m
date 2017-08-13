function avgSelfDistance

load('gisdata_processed_trained');

all_c = {gisData.buildings.center};

min_dist = NaN(size(all_c, 2),1);

for i = 1:length(all_c)
    tmp_dist = inf;
    ci = all_c{i};
    for j = 1:length(all_c)
        if i ~= j
            cj = all_c{j};
            d = ci -cj;
            d = d.*d;
            d = sqrt(sum(d(:)));
            tmp_dist = min(tmp_dist, d);
        end
    end
    min_dist(i) = tmp_dist;
end

fprintf('☆ 平均最短距离为: %f \n', mean(min_dist));