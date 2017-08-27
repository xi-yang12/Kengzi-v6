function gisData = InitGisDataPRE(gisData)
%% The data structrue of gisData.PRE
% gisData.PRE.self_building  %  �����б��彨��, 1 ��ʾ������Ϊ���彨����, ������
% gisData.PRE.status_candidate  % �����еķǽ�����, �������ܱ�ѡΪ
% gisData.PRE.lp_attribute         % ÿ����ѡ�����Ӧ��ֵ, �����жϸ������Ƿ����������ס��
% gisData.PRE.lp_other_min_dist         
% gisData.PRE.lp_self_min_dist         
%     gisData.PRE.lp_attribute = P(Attributes)
%     gisData.PRE.lp_attribute + P(other_min_dist) + P(self_min_dist) �����ڽ���ѡַ
%     gisData.PRE.lp_attribute + P(other_min_dist) + P(Neighbor)  �����ڽ�������
% gisData.PRE.data_ext       % ÿ����ѡ�����״ֵ̬, ���ͼ�ı仯������
% gisData.PRE.b_ID          % ��Ӧ����Ľ������, ��1��ʼ, ����
% gisData.PRE.b_Num         % �����������, ����, ����length(gisData.PRE.buildings)
% gisData.PRE.buildings     % Ԥ�⵽�Ľ�������Ϣ
% gisData.PRE.buildings.ID  % �������
% gisData.PRE.buildings.data  % ������������ݵ�
% gisData.PRE.buildings.time  % �������򽨳����
% gisData.PRE.buildings.size  % �������Ĵ�С
% gisData.PRE.buildings.people  % ��������ס�˿�����
% gisData.PRE.buildings.center  % ������������
% gisData.PRE.buildings.b_area  % ������R��Χ���ܽ������
% gisData.PRE.buildings.l_area  % ������R��Χ�ڵĿ��ø������
% gisData.PRE.buildings.other_min_dist  % ����������������������С����
% gisData.PRE.buildings.self_min_dist   % �������뱾�����������С����
% gisData.PRE.buildings.lp_value
% gisData.PRE.buildings.stopped         % �����Ƿ�ֹͣ����, ֻ��ֹͣ�����ľ����Ż����
% gisData.PRE.buildings.parent_ID
% gisData.PRE.buildings.fsq_ID
% gisData.PRE.buildings.fsq_land;   % �����жϽ����Ƿ��������
% gisData.PRE.buildings.fsq_b_area;
% gisData.other_building  % ��������

if gisData.v == 1,
    fprintf('InitGisDataPRE... \n');
end
gisData.PRE.status_candidate = true(size(gisData.data,1),1);
% gisData.PRE.status_candidate = (gisData.data(:,20)>0);  %���������е㶼�п��ܳ�Ϊ������ѡ��
% �Ƴ����ӵ����仺������������ס�㣩��ɽˮ��ˮ�߼��仺������������ס�㣩,�Լ�����������
gisData.PRE.status_candidate = gisData.PRE.status_candidate & ...
                               not(gisData.data(:,18)==1) & ...
                               not(gisData.data(:,19)==1) & not(gisData.other_building);
                           
gisData.PRE.self_building = false(size(gisData.PRE.status_candidate));

gisData.PRE.lp_attribute = NaN(size(gisData.PRE.status_candidate));          % ÿ����ѡ�����Ӧ��ֵ, �����жϸ������Ƿ����������ס��
gisData.PRE.lp_other_min_dist = NaN(size(gisData.PRE.status_candidate));         
gisData.PRE.lp_self_min_dist = NaN(size(gisData.PRE.status_candidate));         
gisData.PRE.lp_fsq_area = NaN(size(gisData.PRE.status_candidate));         
gisData.PRE.data_ext = NaN(size(gisData.PRE.status_candidate,1), gisData.data_ext_num);      % ÿ����ѡ�����״ֵ̬, ���ͼ�ı仯������
gisData.PRE.b_ID = zeros(size(gisData.PRE.status_candidate));         % ��Ӧ����Ľ������, ��1��ʼ
gisData.PRE.b_Num = 0;
gisData.PRE.b_s_ID = NaN(size(gisData.PRE.status_candidate));         % block���Ľ��������˳����
gisData.PRE.b_s_Num = 0;      % ��¼��ǰ���µı��
gisData.PRE.rateall = [];