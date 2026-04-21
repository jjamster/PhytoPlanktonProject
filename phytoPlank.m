%%
clear;
%% For the csv file

filename = 'spots.csv'
SPOTS = readtable(filename);
%%
latitude = SPOTS.LATITUDE;
longitude = SPOTS.LONGITUDE;

oxygen = SPOTS.CTDOXY;
nitrate = SPOTS.NITRAT;
pCO2 = SPOTS.PCO2;
DOC = SPOTS.TCARBN;

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





