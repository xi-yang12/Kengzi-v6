% % %function CA4
% % %clf
%  clear
% 
% %gisData = GisDataRead();
% %load('gisdata_processed.mat');
% 
% % gisData = GisDataRead20();
% load('gisdata_processed10.mat');
% 
% % ��������
% gisData = GisSetup(gisData);
% 
% % ������չ����
% gisData = computeGisData_ext(gisData);
% 
% % ����ѧϰ
% gisData = ParamEvaluation_V6(gisData);
% 
% save('gisdata_processed_trained', 'gisData');
% % load('gisdata_processed_trained.mat');
% 
% %% =============================================
% %CA setup & initialization
% gisData = Initialize(gisData);

%% ���м�״̬����ִ��
load('map-300-P4-4');


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


%% Main event loop
stop= 0; %wait for a quit button push
run = 1; %wait for a draw 
freeze = 0; %wait for a freeze
stepnumber = 0;

while (stop==0) && stepnumber <=1000 
    gisData = CARuleBulider(gisData);
    gisData = RateAll(gisData);
    if gisData.crazy==0 && gisData.PRE.rateall(end) <= gisData.rateFB
        % fprintf('\t [��������뽨�������ֵ <= %f], stop naturally. \n', gisData.rateFB);
        fprintf('\t [��������뽨�������ֵ <= %f], crazy model. \n', gisData.rateFB);
        gisData.crazy = 1;
        % break
    end
    %draw the new image
    set(imh, 'cdata', cat(3, gisData.map.a, gisData.map.b, gisData.map.c) )
    %update the step number diaplay
    stepnumber = 1 + str2num(get(number,'string'));
    % set(number,'string',num2str(stepnumber));gisData.curTime
    set(number,'string',num2str(gisData.curTime));
    
    saveas(imh, [gisData.FileName '.pdf'])
    
    save([gisData.FileName '.mat'], 'gisData');
    drawnow  %need this in the loop for controls to work 
end
