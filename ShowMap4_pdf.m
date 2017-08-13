%function ShowMap_pdf_pase(gisData)
% ���ɶ���׶εĿ��ӻ�����
[gisData.map.data, gisData.map.txt] = xlsread('map_rgb/��ʷģ���ͼ.xlsx');

rgb_1 = [156,156,156];
rgb_2 = [204,204,204];
rgb_3 = [255,255,255];
rgb_4 = [78,78,78];
rgb_5 = [229,232,255];

rgb_all = [rgb_1; rgb_2; rgb_3; rgb_4; rgb_5]/255; % ������ɫ����
rgb_idx = [1,     2,     3,     4,     5];         % ÿ����ɫ��Ӧ��ֵ
% ���Ͻ��� 
rgb_huang = [255,0,162]/255;

rgb_nodata = [255,255,255]/255;

% ��������
bgdata = gisData.map.data(:,4); %��ȡ��������
gisData.map.a = ones(size(bgdata)) * rgb_nodata(1);
gisData.map.b = ones(size(bgdata)) * rgb_nodata(2);
gisData.map.c = ones(size(bgdata)) * rgb_nodata(3);

% ���Ƶ�3������
b1_idx = (gisData.map.data(:,3) == 1);
gisData.map.a(b1_idx) = rgb_all(1, 1);
gisData.map.b(b1_idx) = rgb_all(1, 2);
gisData.map.c(b1_idx) = rgb_all(1, 3);

for i = 2:length(rgb_idx)
    b_idx = (bgdata == rgb_idx(i));
    gisData.map.a(b_idx) = rgb_all(i, 1);
    gisData.map.b(b_idx) = rgb_all(i, 2);
    gisData.map.c(b_idx) = rgb_all(i, 3);
end

tmp_a = gisData.PRE.b_s_ID;

filename = 'res/iter-%03d.eps';  % ͼ���ŵ�λ��
phase = 50;  % ����ͼ�ε�����
tt = linspace(1, max(tmp_a), phase);  

for i=1:length(tt)
    hf = figure(1);
    
    predict_idx = gisData.PRE.b_s_ID <= tt(i);
    gisData.map.a(predict_idx) = rgb_huang(1);
    gisData.map.b(predict_idx) = rgb_huang(2);
    gisData.map.c(predict_idx) = rgb_huang(3);
    
    
    map.a = data_deshape(gisData.map.a, gisData.row, gisData.col);
    map.b = data_deshape(gisData.map.b, gisData.row, gisData.col);
    map.c = data_deshape(gisData.map.c, gisData.row, gisData.col);
    
    image(cat(3, map.a, map.b, map.c));
    title(sprintf('The %03dth year', fix(tt(i))));
    drawnow    

    %saveas(hf, sprintf(filename, i));
    print(hf, '-depsc2', sprintf(filename, i));
%     if i == 1;
%         % print res/iter.ps -dpdf
%        imwrite(imind,cm,filename,'pdf', 'Loopcount',inf);
%     else
%        imwrite(imind,cm,filename,'pdf','WriteMode','append');
%     end
end

%subplot(1,2,1)


