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
end

meanLonALOHA = mean(lonALOHA);
meanLatALOHA = mean(latALOHA);
findALOHAPeriod = find(dateALOHA >= 20100000 & dateALOHA <= 20191231);
timeALOHA = time_ALOHA(findALOHAPeriod);
tempALOHA = dateALOHA(findALOHAPeriod);

nALOHA = nitrate_ALOHA(findALOHAPeriod);

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
plot(monthALOHA.reformatALOHA, monthALOHA.DIC_ALOHA, 'k-', 'LineWidth', 2)
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
plot(monthNALOHA.reformatALOHA, monthNALOHA.nALOHA, 'k-', 'LineWidth', 2)
xlabel('Years', FontSize= 20), ylabel('Nitrate (umol/kg)', FontSize= 20)
ylim([-20 60])
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

%% File 1 Mid Atlantic from ERDDAP
midAtlantic = "Tried.nc";
ncdisp(midAtlantic);
latO = double(ncread(midAtlantic, "latitude"));
lonO = double(ncread(midAtlantic, "longitude"));
timeO = ncread(midAtlantic, "time");
chlorophyllO = ncread(midAtlantic, "chlorophyll");
full_times = [];

%Convert time
time_days = timeO / 86400;
newTime = datenum("1970-01-01 00:00:00") ;
time_final = newTime + time_days;
Datestring = datestr(time_final);
full_times = [full_times;time_final];

figure(5); clf
worldmap world
contourfm(latO, lonO, log10(chlorophyllO(:,:,1))','linecolor','none');
c = colorbar
caxis([-2 2])
ylabel(c,'log_{10}(Chlorophyll-a mg m^{-3})')
geoshow('landareas.shp','FaceColor','black')
scatterm(17.6,340.7,36,'r',"filled");
title('Chlorophyll-a Concentrations in the Mid-Atlantic (mg m^-3)')

%% File 2 from ERDDAP
northPacific = "erdMH1chlamday_Lon0360_9893_1eef_1224.nc"
ncdisp(northPacific);
latC = double(ncread(northPacific, "latitude"));
lonC = double(ncread(northPacific, "longitude"));
timeC = ncread(northPacific, "time");
chlorophyllc = ncread(northPacific, "chlorophyll");

figure(6); clf
ax = worldmap("World");
setm(ax,"Origin",[0 180 0])
contourfm(latC, lonC, log10(chlorophyllc(:,:,1))','linecolor','none');
c = colorbar
caxis([-2 2])
ylabel(c,'log_{10}(Chlorophyll-a mg m^{-3})')
geoshow('landareas.shp','FaceColor','black')
scatterm(22.8,207,36,'r',"filled");
title('Chlorophyll-a Concentrations in the North Pacific (mg m^-3)')


%% Here's a draft for chlorophyll

% Find nearest Station ALOHA grid point
[~,lat_idx] = min(abs(latC - 22.8));
[~,lon_idx] = min(abs(lonC - 207));

% Extract time series
chl_aloha = squeeze(chlorophyllc(lon_idx,lat_idx,:));

% Remove bad values
chl_aloha(chl_aloha < 0) = NaN;

% Plot
figure
plot(timeC, chl_aloha,'g','LineWidth',1.5)
xlabel('Time')
ylabel('Chlorophyll-a (mg m^{-3})')
title('Chlorophyll at Station ALOHA')
grid on
%%
%look at documentation for time
% look at total carbon or pCO2 -> dissolved carbon
% is most related to what we do

%%%% No use stations
findPeriod = find(SPOTS.DATE >= 20150000 & SPOTS.DATE <= 20201231);
year = floor(findPeriod/10000);
month = floor(findPeriod - year*10000)/100;
day = findPeriod-year*10000 - month*100;

% this is for Pacific Data
% This is K2 data

for i = indexK2
    lonK2 = longitude(i);
    latK2 = latitude(i);
    dateK2 = SPOTS.DATE(i);
    DIC_K2 = DIC(i);
    nitrate_K2 = nitrate(i);
    hour_K2 = hours(i);
end

meanLonK2 = mean(lonK2);
meanLatK2 = mean(latK2);
findK2Period = find(dateK2 >= 20150000 & dateK2 <= 20201231);
DIC_K2 = DIC_K2(findK2Period);
DIC_K2(DIC_K2 == -999) = 1;

timeK2 = hour_K2(findK2Period);
yearK2 = floor(dateK2(findK2Period)/10000);
monthK2 = floor((dateK2(findK2Period) - yearK2*10000)/100); 
dayK2 = dateK2(findK2Period)-yearK2*10000 - monthK2*100;
%oxygenK2grid = NaN(length(lonK2), length(latK2), length(dateK2));
%nitrateK2grid = NaN(length(lonK2), length(latK2), length(dateK2));
%pCO2K2grid = NaN(length(lonK2), length(latK2), length(dateK2));
%DOCK2grid = NaN(length(lonK2), length(latK2), length(dateK2));

% This is KNOT data

for i = indexKNOT
    lonKNOT = longitude(i);
    latKNOT = latitude(i);
    dateKNOT = SPOTS.DATE(i);
    DIC_KNOT = DIC(i);
    nitrate_KNOT = nitrate(i);
    hour_KNOT = hours(i);
end

meanLonKNOT = mean(lonKNOT);
meanLatKNOT = mean(latKNOT);
findKNOTPeriod = find(dateKNOT >= 20150000 & dateKNOT <= 20201231);
timeKNOTS = hour_KNOT(findKNOTPeriod);
yearKNOT = floor(dateKNOT(findKNOTPeriod)/10000);
monthKNOT = floor((dateKNOT(findKNOTPeriod) - yearKNOT*10000)/100); 
dayKNOT = dateKNOT(findKNOTPeriod)-yearKNOT*10000 - monthKNOT*100;

%oxygenKNOTgrid = NaN(length(lonKNOT), length(latKNOT), length(dateKNOT));
%nitrateKNOTgrid = NaN(length(lonKNOT), length(latKNOT), length(dateKNOT));
%pCO2KNOTgrid = NaN(length(lonKNOT), length(latKNOT), length(dateKNOT));
%DOCKNOTgrid = NaN(length(lonKNOT), length(latKNOT), length(dateKNOT));


%oxygenALOHAgrid = NaN(length(lonALOHA), length(latALOHA), length(dateALOHA));
%nitrateALOHAgrid = NaN(length(lonALOHA), length(latALOHA), length(dateALOHA));
%pCO2ALOHAgrid = NaN(length(lonALOHA), length(latALOHA), length(dateALOHA));
%DOCALOHAgrid = NaN(length(lonALOHA), length(latALOHA), length(dateALOHA));

% This is North Pacific 
%This is for Radcor_1
for i = indexRADCOR2
    lonRadcor2 = longitude(i);
    latRadcor2 = latitude(i);
    dateRadcor2 = SPOTS.DATE(i);
    DIC_RADCOR2 = DIC(i);
    nitrate_RADCOR2 = nitrate(i);
    hours_RADCOR2 = hours(i);
end

meanLonRadcor2 = mean(lonRadcor2);
meanLatRadcor2 = mean(latRadcor2);
findRADCOR2Period = find(dateRadcor2 >= 20150000 & dateRadcor2 <= 20201231);
time_RADCOR2 = hours_RADCOR2(findRADCOR2Period);
yearRadcor2 = floor(dateRadcor2(findRADCOR2Period)/10000);
monthRadcor2 = floor((dateRadcor2(findRADCOR2Period) - yearRadcor2*10000)/100); 
dayRadcor2 = dateRadcor2(findRADCOR2Period)-yearRadcor2*10000 - monthRadcor2*100;

% This is for Radcor_4

for i = indexRADCOR4
    lonRadcor4 = longitude(i);
    latRadcor4 = latitude(i);
    dateRadcor4 = SPOTS.DATE(i);
    DIC_RADCOR4 = DIC(i);
    nitrate_RADCOR4 = nitrate(i);
    hours_RADCOR4 = hours(i);
end

meanLonRadcor4 = mean(lonRadcor4);
meanLatRadcor4 = mean(latRadcor4);
findRADCOR4Period = find(dateRadcor4 >= 20150000 & dateRadcor4 <= 20201231);
time_RADCOR4 = hours_RADCOR4(findRADCOR4Period);
yearRadcor4 = floor(dateRadcor4(findRADCOR4Period)/10000);
monthRadcor4 = floor((dateRadcor4(findRADCOR4Period) - yearRadcor4*10000)/100); 
dayRadcor4 = dateRadcor4(findRADCOR4Period)-yearRadcor4*10000 - monthRadcor4*100;

%oxygenRadcor4grid = NaN(length(lonRadcor4), length(latRadcor4), length(dateRadcor4));
%nitrateRadcor4grid = NaN(length(lonRadcor4), length(latRadcor4), length(dateRadcor4));
%pCO2Radcor4grid = NaN(length(lonRadcor4), length(latRadcor4), length(dateRadcor4));
%DOCRadcor4grid = NaN(length(lonRadcor4), length(latRadcor4), length(dateRadcor4));

%oxygenCVOOgrid = NaN(length(lonCVOO), length(latCVOO), length(dateCVOO));
%nitrateCVOOgrid = NaN(length(lonCVOO), length(latCVOO), length(dateCVOO));
%pCO2CVOOgrid = NaN(length(lonCVOO), length(latCVOO), length(dateCVOO));
%DOCCVOOgrid = NaN(length(lonCVOO), length(latCVOO), length(dateCVOO));

%% Munida
for i = indexIcelandSea
    lonIcelandSea = longitude(i);
    latIcelandSea = latitude(i);
    dateIcelandSea = SPOTS.DATE(i);
    DIC_IcelandSea = DIC(i);
    nitrate_IcelandSea = nitrate(i);
    time_IcelandSea = time(i);
end

meanLonIcelandSea = mean(lonIcelandSea);
meanLatIcelandSea = mean(latIcelandSea);
findIcelandSeaPeriod = find(dateIcelandSea >= 20100000 & dateIcelandSea <= 20191231);
timeIcelandSea = time_IcelandSea(findIcelandSeaPeriod);
tempIcelandSea = dateIcelandSea(findIcelandSeaPeriod);

nIcelandSea = nitrate(findIcelandSeaPeriod);

%Datestring = datetime(timeALOHA,'InputFormat','yyyyMMdd');;
hourIcelandSea = floor(timeIcelandSea/100);
minutesIcelandSea = floor(timeIcelandSea - hourIcelandSea*100);
yearIcelandSea = floor(dateIcelandSea(findIcelandSeaPeriod)/10000);
monthIcelandSea = floor((dateIcelandSea(findIcelandSeaPeriod) - yearIcelandSea*10000)/100); 
dayIcelandSea = dateIcelandSea(findIcelandSeaPeriod)-yearIcelandSea*10000 - monthIcelandSea*100;

refTimeIcelandSea = (yearIcelandSea + "-" + monthIcelandSea + "-" + dayIcelandSea);

reformatIcelandSea = datetime(refTimeIcelandSea, 'InputFormat', 'yyyy-M-dd');

%% Time table stuff and clean up
[reformatIcelandSea, idxI] = sort(reformatIcelandSea);
DIC_IcelandSea = DIC_IcelandSea(idxI);
nIcelandSea = nIcelandSea(idxI);

for i = 1:220
    if DIC_IcelandSea(i) == -999
       DIC_IcelandSea(i) = NaN;
    end

end

for i = 1:220
    if nIcelandSea(i) == -999
       nIcelandSea(i) = NaN;
    end

end

timetableIcelandSea = timetable(reformatIcelandSea, DIC_IcelandSea);
monthIcelandSea = retime(timetableIcelandSea, 'monthly', 'mean');

timetableNIcelandSea = timetable(reformatIcelandSea, nIcelandSea);
monthNIcelandSea = retime(timetableNIcelandSea, 'monthly', 'mean');




