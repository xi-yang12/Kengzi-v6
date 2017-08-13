function drawTopo(gisData)
figure
% gisData.map.a(isnan(gisData.map.a))=1;
% gisData.map.b(isnan(gisData.map.b))=1;
% gisData.map.c(isnan(gisData.map.c))=1;
imh = image(cat(3, gisData.map.a, gisData.map.b, gisData.map.c));
axis tight
locs = [];
for i = 1:29
    bz = getCenterId(i, gisData);
    [x, y] = getLocation(bz, gisData);
    text(x, y, num2str(i),'Color',[1 1 0],'FontSize',6);
    locs = [locs; [x, y]];
end
drawArrow = @(pp1,pp2,varargin) quiver(pp1(1), pp1(2), pp2(1)-pp1(1), pp2(2)-pp1(2), 0, varargin{:});
for i = 1:29
    if ~isnan(gisData.topo(i, 2))
        % arrow(locs(gisData.topo(i, 2),:), locs(i, :), 'Color',[1 1 0]);
        p1 = locs(gisData.topo(i, 2), :);
        p2 = locs(i, :);
        % dp = p1 - p2;
        hold on;
        % quiver(p1(1),p1(2),dp(1),dp(2),0);
        drawArrow(p1, p2, 'Color',[1 1 0]);
        % arrow(p1, p2);
    end
    pause;
end
% set(imh, 'erasemode', 'none')
axis equal

function [x, y] = getLocation(bz, gisData)
x = mod(bz, gisData.col) + 1;
y = gisData.row - floor(bz/gisData.col) - 1;

function bz = getCenterId(i, gisData)
bPoints = gisData.buildings(i).data(:, 2:3);
center =  gisData.buildings(i).center;
dist = (bPoints(:,1) - center(1)).^2 + (bPoints(:,2) - center(2)).^2;
[pVal, pIdx] = min(dist);
bz = gisData.buildings(i).data(pIdx, 1);
