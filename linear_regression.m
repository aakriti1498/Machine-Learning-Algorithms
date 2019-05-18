close all;
clc;
clear all;
%importing data
data = readtable('prostate cancer_StandardFormat.xlsx');
%%
%data preprocessing
%data scaling
data=data(:,2:10);
x3_scale=(data.x3-mean(data.x3))/std(data.x3);
data.x3=x3_scale;
x7_scale = (data.x7 - mean(data.x7))/std(data.x7);
data.x7 = x7_scale; 
x8_scale = (data.x8- mean(data.x8))/std(data.x8);
data.x8=x8_scale;
x2_scale = (data.x2-mean(data.x2))/std(data.x2);
data.x2=x2_scale;
%%
c=cvpartition(size(data,1),'HoldOut',0.3);
idx = test(c);
TrainingData= data(~idx,:);
TestData=data(idx,:);
Test_data1=data(idx,1:8);

%%
%training a linear regression model on training data
model=fitlm(TrainingData);
%%
%making preditions on test data
prediction=predict(model,Test_data1);
%%
plot(TestData.y);
hold on;
plot(prediction);



