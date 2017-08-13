function gisData = LogisticRegression(gisData, c_idx)
% 逻辑回归参数学习
if gisData.v == 1
    fprintf('The parameter evaluation for Logistic Regression ... \n');
end

%% Step 1. Data preparing
% get all orignal Gis data
% 这里的c_idx仅包含不是建筑的数据， 还需要考虑是建筑的数据
c_idx = c_idx | gisData.data(:, 7)>0;
allOrgData = gisData.data(c_idx, gisData.ModelParam.LR_org);
allExtData = gisData.PRE.data_ext(c_idx, gisData.ModelParam.LR_ext);
X = [allOrgData, allExtData];
y = zeros(size(X, 1), 1); % 输出是一个仅含0与1的列向量
b_id_tmp = gisData.data(c_idx, 7);  % 获得建筑编号列数据
y(b_id_tmp > 0) = 1;

%% Step 2. Filter NaN records
nan_idx = isnan(allExtData(:, gisData.ModelParam.distP));
nan_idx = nan_idx | isnan(allExtData(:, gisData.ModelParam.distPP));
X(nan_idx, :) = [];
y(nan_idx, :) = [];

%% Step 3. Normalization
% gisData.LR.V 用于存储归一化所产生的中间参数
if gisData.LR.is_norm ==1
    [X, gisData.LR.V] = gisData.LR.normFun(X, NaN);
end

%% Step 4. Logistic Regression training
[gisData.LR.b, gisData.LR.dev, gisData.LR.stat] = ... 
    glmfit(X, y, 'binomial', 'link', gisData.LR.link);

%% Step 5. Print model prameters
fprintf('gisData.LR.b: \n');
fprintf('[%02d]: %f,  %s \n', 1, gisData.LR.b(1), '常数项');
k = 2;
for c = gisData.ModelParam.att
    fprintf('[%02d]: %f,  %s \n', k, gisData.LR.b(k), gisData.txt{c});
    k = k + 1;
end
for c = gisData.ModelParam.LR_ext
    fprintf('[%02d]: %f,  %s \n', k, gisData.LR.b(k), gisData.data_ext_name{c});
    k = k + 1;
end
