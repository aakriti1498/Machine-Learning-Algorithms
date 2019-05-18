%%
clear all;
clc;
close all;
%%
data = readtable('GasFurnace_dataset.xlsx');
data_array = table2array(data);
x1 = [];
x2 = [];
x3 = [];
for i = 6:296
x1 = [x1 data_array(i-1,2)];
x2 = [x2 data_array(i-3,1)];
x3 = [x3 data_array(i-4,1)];
end
x1 = x1';
x2 = x2';
x3 = x3';
y = data_array(6:end,2);
data_new = table(x1,x2,x3,y);
[m,n] = size(data_new);
train_index = round(0.7*m);
train_data = data_new(1:train_index,:);
test_data = data_new(train_index+1:end,:);
model = fitlm(train_data);
predictions = predict(model,test_data(:,1:3));
plot(test_data.y);
hold on;
plot(predictions);
error = (predictions - test_data.y).^2;
mse = mean(error);
disp(mse);