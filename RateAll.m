function gisData=RateAll(gisData)
farmall=gisData.data(:,5);
farmallyes=(farmall==1);
buildyes=gisData.PRE.b_s_ID>0;
overlay=(farmallyes & buildyes);
buildArea=sum(buildyes);
farmArea=sum(farmallyes)-sum(overlay);
rateall=farmArea/buildArea;

if gisData.v == 1,
    fprintf('\t 当前耕地面积与建筑面积比值为: [%.3f]. \n', rateall);
end

gisData.PRE.rateall=[gisData.PRE.rateall;rateall];
end
