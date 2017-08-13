function [lr_val, c_idx]= computeSplitLRValue(gisData, c_idx)
% ����ѡַǰ����Ҫ����ÿ����ѡ�߱�ѡ�е��߼��ع�Ȩֵ, c_idx��ʾ��Ҫ����ĺ�ѡ�ߣ�
% ������Ҫ���˵��� 

%% Step 0 ���˵����е�NaN����
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

