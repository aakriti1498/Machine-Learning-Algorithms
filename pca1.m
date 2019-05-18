 
%% --------------- Importing the dataset -------------------------
% ---------------------------- Code ---------------------------
data = readtable('breastcancer_dataset_standard_format.xlsx');

%% --------------------------- PCA -------------------------------
% ---------------------------- Code ---------------------------
class_labels = data.y;
data = table2array(data(:,2:end-1));

[coeff,score,latent,tsquared,explained,mu] = pca(data);
 
 Var1 = score(:,1); %variance due to first feature is more hence we are using that it can be seen in explained of pca function
% Var2 = score(:,2);
 data = table(Var1,class_labels);