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

%look at documentation for time
% look at total carbon or pCO2 -> dissolved carbon
% is most related to what we do

%%





