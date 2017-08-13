function [lr_val, c_idx]= computeSplitLRValue(gisData, c_idx)
% 建筑选址前，需要计算每个候选者被选中的逻辑回归权值, c_idx表示需要计算的候选者，
% 其中需要过滤掉， 

%% Step 0 过滤掉其中的NaN索引
nan_idx = isnan(gisData.PRE.data_ext(:, gisData.ModelParam.distP));
nan_idx = nan_idx | isnan(gisData.PRE.data_ext(:, gisData.ModelParam.distPP));
c_idx = c_idx & not(nan_idx);

%% Step 1. Data preparing
% get all orignal Gis data
allOrgData = gisData.data(c_idx, gisData.ModelParam.LR_org);
allExtData = gisData.PRE.data_ext(c_idx, gisData.ModelParam.LR_ext);
X = [allOrgData, allExtData];

%% Step 2. Normalization
if gisData.LR.is_norm ==1
    X = gisData.LR.normFun(X, gisData.LR.V);
end

%% Step 3. Logistic Regression evaluating
lr_val = NaN(size(gisData.PRE.status_candidate));
lr_val(c_idx) = glmval(gisData.LR.b, X, gisData.LR.link);

