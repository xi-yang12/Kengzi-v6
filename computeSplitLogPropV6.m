function [c_prob, c_idx] = computeSplitLogPropV6(gisData, c_idx)
% ����ѡַǰ����Ҫ����ÿ����ѡ�߱�ѡ�еĸ��ʣ� ��computeSplitLogProp��ͬ������V6
% ���Ƴ����������������Ӱ��
% ������Ȼ����
% gisData.PRE.lp_attribute + P(other_min_dist) + P(self_min_dist) �����ڽ���ѡַ
%% Step 1 Evalutation
c_prob = NaN(size(c_idx));

index = [find(c_idx==1)]';
for i = index
    attributes = [gisData.data(i,gisData.ModelParam.att), gisData.data_ext(i, gisData.ModelParam.att_ext)]';
    valAttri = gmmEval(attributes, gisData.model(1).GMM);
    if sum(valAttri>0)
        warning('Exception Value! -- attribute\n');
    end
    
    valDOther = gmmEval(gisData.data_ext(i, gisData.ModelParam.dOther), gisData.model(2).GMM);
    if sum(valDOther>0)
        warning('Exception Value! -- other_min_dist\n');
    end
    
    valDSelf = gmmEval(gisData.data_ext(i, gisData.ModelParam.dSelf), gisData.model(3).GMM);
    if sum(valDSelf>0)
        warning('Exception Value! -- self_min_dist\n');
    end
    
%     valFsq = gmmEval(gisData.PRE.data_ext(i, gisData.ModelParam.fsqArea)', gisData.model(6).GMM);
%     if sum(valFsq>0)
%         warning('Exception Value! -- fsq_area\n');
%     end
    
    valPDist = gmmEval(gisData.data_ext(i, gisData.ModelParam.distP), gisData.model(4).GMM);
    if sum(valPDist>0)
        warning('Exception Value! -- parent distance\n');
    end
    
    valDistPP = gmmEval(gisData.data_ext(i, gisData.ModelParam.distPP), gisData.model(5).GMM);
    if sum(valDistPP>0)
        warning('Exception Value! -- parent parent distance\n');
    end
    
    c_prob(i) = valAttri + valDOther + valDSelf + valPDist + valDistPP;
end
