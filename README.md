# Kengzi-v6
2015/10/25
增加了面积的回归

2016/04/04
Copy From m
新增数据集，diaoyuxu，用550的数据跑一次


2017/05/02
参数筛选，重新评估与计算

gisData.PRE.status_candidate, 表示可用于选址的点，该数据来自于第20列， 其中已经排除了本族建筑和外族建筑。

+ avgSelfDistance 
    在V6中创建，用于评估单步预测的实验结果

+ computeSplitLogPropV6(gisData, c_idx)
    建筑选址前，需要计算每个候选者被选中的似然概率， 与computeSplitLogProp不同的是在V6中移除了与自身建筑距离的影响