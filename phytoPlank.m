%% Hello 

filenames = ["Monthly_dFe_V2.nc"];

for i = 1:length(filenames)
  ncdisp(filenames(i));
end

lat = ncread(filenames, "Latitude");
lon = ncread(filenames, "Longitude");

%% 1c. Use the function "ncread" to extract the variables "time" and
%"ctdmo_seawater_temperature"
iron = ncread(filenames, "dFe_RF");
months = ncread(filenames, "Month")

figure(1);
plot(months, iron, "k.")
datetick("x", 22)


%%
