function gisData = GisDataRead20()

gisData.blocksize = '20x20';

% ��ȡ��ͼ����, ������Ԥ����
gisData.row = 375;
gisData.col = 403;
[gisData.data, gisData.txt] = xlsread('20150626-20_20-kengzi-data.xlsx');

%% Step 1: ����-9999,��NaN�滻,ʹ�䲻��������
gisData.data(find(gisData.data<-9000)) = NaN;

% Set all data not in ���� as NaN
penqu = gisData.data(:,4);
gisData.data(find(isnan(penqu)),4:end) = NaN;
idx_invalid = find(gisData.data(:,4)>0 & isnan(gisData.data(:,20)));
gisData.data(idx_invalid,4:end) = NaN;

idx_invalid = find(gisData.data(:,4)>0 & isnan(gisData.data(:,14)));
gisData.data(idx_invalid,4:end) = NaN;

%% Step 2: ��������������Ϣ
xx = 232:20:8272;
yy = 10:20:7490;
xx = repmat(xx', gisData.row, 1);
yy = repmat(yy, gisData.col, 1);

gisData.data(:,2) = xx;
gisData.data(:,3) = yy(:);

%% Step 3: Normalization min-max norm
%nIdx = [7:15]; % Indicating which columns need to be normalized.
%dmin = repmat(min(num(:,nIdx)), size(num,1), 1);
%dmax = repmat(max(num(:,nIdx)), size(num,1), 1);
%num(:,11:end) = 2*(num(:,11:end)-dmin)./(dmax-dmin)-1;  % ��һ����[-1,1]
%num(:,nIdx) = (num(:,nIdx)-dmin)./(dmax-dmin);  % ��һ����[0,1]

% ��ɽ������Ƕȴ���180�ȵ�ӳ�䵽0-180֮��,���еȼ�ת��
b_idx = gisData.data(:,14)>180;
gisData.data(b_idx,14) = gisData.data(b_idx,14) - 180;

% Move to GisSetup
% gisData.topo = [  1, NaN;
%                   2, 1;
%                   3, 1;
%                   4, NaN;
%                   5, 1;
%                   6, 1;
%                   7, 1;
%                   8, 2;
%                   9, NaN;
%                  10, 6;
%                  11, 2;
%                  12, 2;
%                  13, 3;
%                  14, 11;
%                  15, 8;
%                  16, 8;
%                  17, 11;
%                  18, 8;
%                  19, NaN;
%                  20, 12;
%                  21, 5;
%                  22, NaN;
%                  23, 11;
%                  24, 12;
%                  25, NaN;
%                  26, 13;
%                  27, NaN;
%                  28, 11;
%                  29, 23];  

save('gisdata_processed20', 'gisData');
