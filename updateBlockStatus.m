function gisData = updateBlockStatus(gisData, new_blocks, b_Idx)
gisData.PRE.self_building = gisData.PRE.self_building | new_blocks;   % ��ӵ�building��
gisData.PRE.status_candidate = gisData.PRE.status_candidate & not(new_blocks);  % ��candidate���Ƴ�

% �趨�������
block_idx = (new_blocks==1);
gisData.PRE.b_ID(block_idx) = b_Idx;

% �趨����˳����
% gisData.PRE.b_s_Num = gisData.PRE.b_s_Num + 1;
% �汾4��������滻���ֱ��
gisData.PRE.b_s_Num = gisData.curTime; 
gisData.PRE.b_s_ID(block_idx) = gisData.PRE.b_s_Num;         % block�ɽ��������˳����