function drawLayer(gisData, vals, layer, tt)

cself = (gisData.data(:,7) > 0) & (gisData.data(:,8) <= gisData.Slice);
son = false(size(cself));
s_idx = find(gisData.topo(:,2) == gisData.chkBIdx);
dist=[];
[~, max_idx] = max(vals);
fprintf('¡î The value of block [%d] is maximal and thus is selected:\n', max_idx);
for i = s_idx'
    sb = (gisData.data(:,7) == gisData.topo(i,1));
    son = ( sb | son);
    d = gisData.buildings(i).center - gisData.data(max_idx, 2:3);
    d = d.^2; d = sqrt(d(1)+d(2));
    fprintf('   The distance to Build [%02d] is: %f \n', i, d);
    dist = [dist, d];
end
[min_d, min_idx] = min(dist);
fprintf('¡î The minimal distance to block [%d] is the Build [%02d]: %f\n', ...
         max_idx, s_idx(min_idx), min_d);

% cself(max_idx) = 1;
% layer(max_idx) = 1;
     
%cself(son) = 0.1;
gisData.map.a = data_deshape(cself, gisData.row, gisData.col);
gisData.map.c = data_deshape(layer, gisData.row, gisData.col);

%% =============================================
%build the GUI
%define the Quit button
%build an image and display it
figure

imh = image(cat(3, gisData.map.a, gisData.map.b * 0.7 + gisData.map.c*0.3, gisData.map.c));
set(imh, 'erasemode', 'none')
title(tt)
axis equal
axis tight

function [x, y] = getLocation(bz, gisData)
x = mod(bz, gisData.col) + 1;
y = gisData.row - floor(bz/gisData.col) - 1;