fid = fopen("data.txt", "r");

DATA = textscan(fid, "%*s = %f")

DATA = cell2mat(DATA)

save INITIALDATA.mat DATA;

fclose(fid);