%function CA
%clf
clear

%gisData = GisDataRead();
% load('gisdata_processed.mat');

gisData = GisDataRead20();
load('gisdata_processed20.mat');

% 参数设置
gisData = GisSetup(gisData);

% 计算扩展数据
gisData = computeGisData_ext(gisData);

% 参数学习
gisData = ParamEvaluation_V6(gisData);

save('gisdata_processed_trained', 'gisData');
% load('gisdata_processed_trained.mat');

%% =============================================
%CA setup & initialization
gisData = Initialize(gisData);


% 从中间状态继续执行
load('PRE.mat');


%% =============================================
%build the GUI
%define the Quit button
%build an image and display it
figure
quitbutton=uicontrol('style','pushbutton',...
   'string','Quit', ...
   'fontsize',12, ...
   'position',[100,400,50,20], ...
   'callback','stop=1;close;');

number = uicontrol('style','text', ...
    'string','1', ...
   'fontsize',12, ...
   'position',[20,400,50,20]);

imh = image(cat(3, gisData.map.a, gisData.map.b, gisData.map.c));
set(imh, 'erasemode', 'none')
axis equal
axis tight


