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

% for North Pacific
indexK2 = find(SPOTS.TimeSeriesSite == "K2");
indexKNOT = find(SPOTS.TimeSeriesSite == "KNOT");
indexALOHA = find(SPOTS.TimeSeriesSite == "ALOHA");

% for MidAtlantic
indexCARIACO = find(SPOTS.TimeSeriesSite == "CARIACO");
indexCVOO = find(SPOTS.TimeSeriesSite == "CVOO");
indexRADCOR4 = find(SPOTS.TimeSeriesSite == "RADCOR_4");
indexRADCOR2 = find(SPOTS.TimeSeriesSite == "RADCOR_2");

%% Now finding corrected times and latitude and longtiudes
% for each station
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
end

meanLonK2 = mean(lonK2);
meanLatK2 = mean(latK2);
findK2Period = find(dateK2 >= 20150000 & dateK2 <= 20201231);
DIC_K2 = DIC_K2(findK2Period);
DIC_K2(DIC_K2 == -999) = 0;

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
end

meanLonKNOT = mean(lonKNOT);
meanLatKNOT = mean(latKNOT);
findKNOTPeriod = find(dateKNOT >= 20150000 & dateKNOT <= 20201231);
yearKNOT = floor(dateKNOT(findKNOTPeriod)/10000);
monthKNOT = floor((dateKNOT(findKNOTPeriod) - yearKNOT*10000)/100); 
dayKNOT = dateKNOT(findKNOTPeriod)-yearKNOT*10000 - monthKNOT*100;

%oxygenKNOTgrid = NaN(length(lonKNOT), length(latKNOT), length(dateKNOT));
%nitrateKNOTgrid = NaN(length(lonKNOT), length(latKNOT), length(dateKNOT));
%pCO2KNOTgrid = NaN(length(lonKNOT), length(latKNOT), length(dateKNOT));
%DOCKNOTgrid = NaN(length(lonKNOT), length(latKNOT), length(dateKNOT));

% This is for ALOHA

for i = indexALOHA
    lonALOHA = longitude(i);
    latALOHA = latitude(i);
    dateALOHA = SPOTS.DATE(i);
    DIC_ALOHA = DIC(i);
    nitrate_ALOHA = nitrate(i);
end

meanLonALOHA = mean(lonALOHA);
meanLatALOHA = mean(latALOHA);
findALOHAPeriod = find(dateALOHA >= 20150000 & dateALOHA <= 20201231);
yearALOHA = floor(dateALOHA(findALOHAPeriod)/10000);
monthALOHA = floor((dateALOHA(findALOHAPeriod) - yearALOHA*10000)/100); 
dayALOHA = dateALOHA(findALOHAPeriod)-yearALOHA*10000 - monthALOHA*100;

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
end

meanLonRadcor2 = mean(lonRadcor2);
meanLatRadcor2 = mean(latRadcor2);
findRADCOR2Period = find(dateRadcor2 >= 20150000 & dateRadcor2 <= 20201231);
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
end

meanLonRadcor4 = mean(lonRadcor4);
meanLatRadcor4 = mean(latRadcor4);
findRADCOR4Period = find(dateRadcor4 >= 20150000 & dateRadcor4 <= 20201231);
yearRadcor4 = floor(dateRadcor4(findRADCOR4Period)/10000);
monthRadcor4 = floor((dateRadcor4(findRADCOR4Period) - yearRadcor4*10000)/100); 
dayRadcor4 = dateRadcor4(findRADCOR4Period)-yearRadcor4*10000 - monthRadcor4*100;

%oxygenRadcor4grid = NaN(length(lonRadcor4), length(latRadcor4), length(dateRadcor4));
%nitrateRadcor4grid = NaN(length(lonRadcor4), length(latRadcor4), length(dateRadcor4));
%pCO2Radcor4grid = NaN(length(lonRadcor4), length(latRadcor4), length(dateRadcor4));
%DOCRadcor4grid = NaN(length(lonRadcor4), length(latRadcor4), length(dateRadcor4));

% This is for CVOO - doesn't up to 2020, only 2019
for i = indexCVOO
    lonCVOO = longitude(i);
    latCVOO = latitude(i);
    dateCVOO = SPOTS.DATE(i);
    DIC_CVOO = DIC(i);
    nitrate_CVOO = nitrate(i);
end

meanLonCVOO = mean(lonCVOO);
meanLatCVOO = mean(latCVOO);
findCVOOPeriod = find(dateCVOO >= 20150000 & dateCVOO <= 20201231);
yearCVOO = floor(dateCVOO(findCVOOPeriod)/10000);
monthCVOO = floor((dateCVOO(findCVOOPeriod) - yearCVOO*10000)/100); 
dayCVOO = dateCVOO(findCVOOPeriod)-yearCVOO*10000 - monthCVOO*100;

%oxygenCVOOgrid = NaN(length(lonCVOO), length(latCVOO), length(dateCVOO));
%nitrateCVOOgrid = NaN(length(lonCVOO), length(latCVOO), length(dateCVOO));
%pCO2CVOOgrid = NaN(length(lonCVOO), length(latCVOO), length(dateCVOO));
%DOCCVOOgrid = NaN(length(lonCVOO), length(latCVOO), length(dateCVOO));

%% figure 1 -> Pacific
figure 1; clf
plot(yearK2, DIC_K2, "b.")
xlabel('Year', FontSize= 20), ylabel('DIC (umol)', FontSize= 20)
title('DIC From K2', FontSize=20)
datetick("x", 22)

%% figure 2 -> MidAtlantic

figure 2; clf
plot(time_final, pressure, "b.")
xlabel('Time', FontSize= 20), ylabel('Pressure (dbar)', FontSize= 20)
title('Pressure Time Series', FontSize=20)
datetick("x", 22)
%% File 1 from ERDDAP
midAtlantic = "erdMH1chlamday_Lon0360_6099_064e_6a6d.nc"
ncdisp(midAtlantic);
latO = ncread(midAtlantic, "latitude");
lonO = ncread(midAtlantic, "longitude");
timeO = ncread(midAtlantic, "time");

%% File 2 from ERDDAP
northPacific = "erdMH1chlamday_Lon0360_b436_f404_709c.nc"
ncdisp(northPacific);
latC = ncread(northPacific, "latitude");
lonC = ncread(northPacific, "longitude");
timeC = ncread(northPacific, "time");
%%
%look at documentation for time
% look at total carbon or pCO2 -> dissolved carbon
% is most related to what we do

%%





