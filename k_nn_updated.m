clc;
clear all;
%%
data1=readtable('iris_dataset.xlsx');
%%
%data preprocessing
%remove unnecessary columns
data=data1(:,2:6);
%find missing values
for i=1:4
    s1='data(ismember(data.';
    s2=strcat('x',num2str(i));
    s3=',-1),:)=[];';
    expr=strcat(s1,s2,s3);
    eval(expr);
end
%normalizing the data
data.x4=(data.x4-min(data.x4))/(max(data.x4)-min(data.x4));
%%

%[train,test] = crossvalind('HoldOut',data.y,0.3);
%trained_data=data(train,:);
%test_data=data(test,:);
%mdl = fitcknn(trained_data,trained_data.y,'NumNeighbors',5);
%predictions = predict(mdl,test_data);
%cp = classperf(test_data.y,predictions);
%accuracy = cp.CorrectRate;
%disp(accuracy);
%cp=classperf(data.y);

c=cvpartition(size(data,1),'HoldOut',0.3);
idx=test(c);
Trained_data=data(~idx,:);
Test_data=data(idx,:);
Test_data1=data(idx,1:4);
model=fitcknn(Trained_data,'y','NumNeighbors',5);
predictions=predict(model,Test_data1);
cp = classperf(Test_data.y,predictions);
accuracy = cp.CorrectRate;
disp(accuracy);

