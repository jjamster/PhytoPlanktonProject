%%
clear;
%% For the csv file

filename = 'spots.csv';
SPOTS = readtable(filename);
%% This is variables from the csv file SPOTS
latitude = SPOTS.LATITUDE;
longitude = SPOTS.LONGITUDE;

nitrate = SPOTS.NITRAT;
DIC = SPOTS.TCARBN;
time = SPOTS.TIME;

depth = SPOTS.CTDPRS;

% for North Pacific
indexK2 = find(SPOTS.TimeSeriesSite == "K2");
indexKNOT = find(SPOTS.TimeSeriesSite == "KNOT");
indexALOHA = find(SPOTS.TimeSeriesSite == "ALOHA");

% for MidAtlantic
indexCARIACO = find(SPOTS.TimeSeriesSite == "CARIACO");
indexCVOO = find(SPOTS.TimeSeriesSite == "CVOO");
indexRADCOR4 = find(SPOTS.TimeSeriesSite == "RADCOR_4");
indexRADCOR2 = find(SPOTS.TimeSeriesSite == "RADCOR_2");
indexIcelandSea = find(SPOTS.TimeSeriesSite == "Munida");

%% Now finding corrected times and latitude and longtiudes
% for each station
% This is for ALOHA

for i = indexALOHA
    lonALOHA = longitude(i);
    latALOHA = latitude(i);
    dateALOHA = SPOTS.DATE(i);
    DIC_ALOHA = DIC(i);
    nitrate_ALOHA = nitrate(i);
    time_ALOHA = time(i);
    pressureALOHA = depth(i);
end

meanLonALOHA = mean(lonALOHA);
meanLatALOHA = mean(latALOHA);
findALOHAPeriod = find(dateALOHA >= 20100000 & dateALOHA <= 20191231);
timeALOHA = time_ALOHA(findALOHAPeriod);
tempALOHA = dateALOHA(findALOHAPeriod);

nALOHA = nitrate_ALOHA(findALOHAPeriod);

surfaceALOHA = pressureALOHA(findALOHAPeriod);

for i = 1:28351
    if surfaceALOHA(i) > 30
        surfaceALOHA(i) = NaN;
    end
end


for i = 1:28351
    if isnan(surfaceALOHA(i))
        DIC_ALOHA(i) = NaN;
    end
end

for i = 1:28351
    if isnan(surfaceALOHA(i))
        nALOHA(i) = NaN;
    end
end

%Datestring = datetime(timeALOHA,'InputFormat','yyyyMMdd');;
hourALOHA = floor(timeALOHA/100);
minutesALOHA = floor(timeALOHA - hourALOHA*100);
yearALOHA = floor(dateALOHA(findALOHAPeriod)/10000);
monthALOHA = floor((dateALOHA(findALOHAPeriod) - yearALOHA*10000)/100); 
dayALOHA = dateALOHA(findALOHAPeriod)-yearALOHA*10000 - monthALOHA*100;

%% Clean Up DIC_ALOHA and nALOHA
actualTimeALOHA = 736024;
refTimeALOHA = (yearALOHA + "-" + monthALOHA + "-" + dayALOHA);

reformatALOHA = datetime(refTimeALOHA, 'InputFormat', 'yyyy-M-dd');

[reformatALOHA, idx] = sort(reformatALOHA);
DIC_ALOHA = DIC_ALOHA(idx);
nALOHA = nALOHA(idx);

for i = 1:28351
    if DIC_ALOHA(i) == -999
        DIC_ALOHA(i) = NaN;
    end

end

for i = 1:28351
    if nALOHA(i) == -999
        nALOHA(i) = NaN;
    end

end

timetableALOHA = timetable(reformatALOHA, DIC_ALOHA);
monthALOHA = retime(timetableALOHA, 'monthly', 'mean');
%%
timetableNALOHA = timetable(reformatALOHA, nALOHA);
monthNALOHA = retime(timetableNALOHA, 'monthly', 'mean');

%%

% This is for CVOO - doesn't up to 2020, only 2019
for i = indexCVOO
    lonCVOO = longitude(i);
    latCVOO = latitude(i);
    dateCVOO = SPOTS.DATE(i);
    DIC_CVOO = DIC(i);
    nitrate_CVOO = nitrate(i);
    hours_CVOO = hours(i);
end

meanLonCVOO = mean(lonCVOO);
meanLatCVOO = mean(latCVOO);
findCVOOPeriod = find(dateCVOO >= 20100000 & dateCVOO <= 20191231);
time_CVOO = hours_CVOO(findCVOOPeriod);
yearCVOO = floor(dateCVOO(findCVOOPeriod)/10000);
monthCVOO = floor((dateCVOO(findCVOOPeriod) - yearCVOO*10000)/100); 
dayCVOO = dateCVOO(findCVOOPeriod)-yearCVOO*10000 - monthCVOO*100;

 nCVOO = nitrate_CVOO(findCVOOPeriod);
actualTimeCVOO = 736024;
refTimeCVOO = (yearCVOO + "-" + monthCVOO + "-" + dayCVOO);

reformatCVOO = datetime(refTimeCVOO, 'InputFormat', 'yyyy-M-dd');
%% Clean up DIC and Nitrate
[reformatCVOO, idxC] = sort(reformatCVOO);
DIC_CVOO = DIC_CVOO(idxC);
nCVOO = nCVOO(idxC);

for i = 1:1074
    if DIC_CVOO(i) == -999
       DIC_CVOO(i) = NaN;
    end

end

for i = 1:1074
    if nCVOO(i) == -999
       nCVOO(i) = NaN;
    end

end

timetableCVOO = timetable(reformatCVOO, DIC_CVOO);
monthCVOO = retime(timetableCVOO, 'monthly', 'mean');

timetableNCVOO = timetable(reformatCVOO, nCVOO);
monthNCVOO = retime(timetableNCVOO, 'monthly', 'mean');


%% figure 1 -> Pacific DIC
figure(1);
plot(monthALOHA.reformatALOHA, monthALOHA.DIC_ALOHA, 'k.', 'LineWidth', 2)
xlabel('Years', FontSize= 20), ylabel('DIC (umol)', FontSize= 20)
ylim([1800 2500])
title('DIC From Aloha', FontSize=20)
datetick("x", 22)
hold on;
%%
movemean = movmean(monthALOHA.DIC_ALOHA, 2);

%%
plot(monthALOHA.reformatALOHA, movemean, "r-", "LineWidth", 2)
legend({'Monthly Mean DIC', 'One Day Moving Mean DIC'}, 'Location','northeast')
hold on;
%% Figure 2 -> Mid Atlantic DIC
hold off;

figure(2);
plot(monthCVOO.reformatCVOO, monthCVOO.DIC_CVOO, 'k-', 'LineWidth', 2)
xlabel('Years', FontSize= 20), ylabel('DIC (umol)', FontSize= 20)
ylim([1800 2500])
title('DIC From CVOO', FontSize=20)
datetick("x", 22)

%% Figure 5 -> North Pacific N
figure(3);
plot(monthNALOHA.reformatALOHA, monthNALOHA.nALOHA, 'k.', 'LineWidth', 2)
xlabel('Years', FontSize= 20), ylabel('Nitrate (umol/kg)', FontSize= 20)
ylim([-0.2 0.2])
title('Nitrate from ALOHA', FontSize=20)
datetick("x", 22)
hold on;
%%
movemean1 = movmean(monthNALOHA.nALOHA, 2);

%%
plot(monthNALOHA.reformatALOHA, movemean1, "r-", "LineWidth", 2)
legend({'Monthly Mean DIC', 'One Day Moving Mean DIC'}, 'Location','northeast')
hold on;
%% Figure 6 -> Mid-Atlatnic N
hold off;
figure(4);
plot(monthNCVOO.reformatCVOO, monthNCVOO.nCVOO,"k-", 'LineWidth', 2)
xlabel('Years', FontSize= 20), ylabel('Nitrate (umol/kg)', FontSize= 20)
ylim([-20 60])
title('Nitrate From CVOO', FontSize=20)
datetick("x", 22)

%% File 2 from ERDDAP
northPacific = "Global.nc"
ncdisp(northPacific);
latC = double(ncread(northPacific, "latitude"));
lonC = double(ncread(northPacific, "longitude"));
timeC = ncread(northPacific, "time");
chlorophyllc = ncread(northPacific, "chlorophyll");

time_days = timeC / 86400;
newTime = datenum("1970-01-01 00:00:00") ;
time_final = newTime + time_days;
Datestring = datestr(time_final);
%full_times = [full_times;time_final];

figure(6); clf
ax = worldmap("World");
setm(ax,"Origin",[0 180 0])
contourfm(latC, lonC, log10(chlorophyllc(:,:,1))','linecolor','none');
c = colorbar
caxis([-2 2])
ylabel(c,'log_{10}(Chlorophyll-a (mg m^{-3})')
geoshow('landareas.shp','FaceColor','black')
scatterm(22.8,207,36,'r',"filled");
title('Global Chlorophyll-a Concentrations (mg m^-3)')


%% Here's a draft for chlorophyll

% Find nearest Station ALOHA grid point
[~,lat_idx] = min(abs(latC - 22.8));
[~,lon_idx] = min(abs(lonC - 207));

% Extract time series
chl_aloha = squeeze(chlorophyllc(lon_idx,lat_idx,:));

% Remove bad values
chl_aloha(chl_aloha < 0) = NaN;

% Plot
figure(7)
subplot(2, 1, 1)
plot(time_final, chl_aloha,'g','LineWidth',1.5)
xlabel('Years')
ylabel('Chlorophyll-a (mg m^{-3})')
datetick('x', 'mmmyy')
title('Chlorophyll at Station ALOHA')
grid on
hold on

subplot(2, 1, 2)

subplot(2,1,3)


%% subplot time


