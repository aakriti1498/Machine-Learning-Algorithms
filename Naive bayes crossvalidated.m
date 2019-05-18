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
cv=cvpartition(size(data,1),'HoldOut',0.3);
idx=test(cv);
train_data=data(~idx,:);
test_data=data(idx,:);
Test_data1=data(idx,1:4);
model=fitcnb(train_data,'y');
cross_validatedmodel=crossval(model,'kFold',10);
accuracy1=[];
for k=1:10
    final_model=cross_validatedmodel.Trained{k};
    predictions=predict(final_model,Test_data1);
    cp=classperf(test_data.y,predictions);
    accuracy=cp.CorrectRate;
    accuracy1=[accuracy1 accuracy];
end
accurate_model=cross_validatedmodel.Trained{10};
predicted_class=predict(accurate_model,Test_data1);
cp=classperf(test_data.y,predictions);
accuracy_percent=cp.CorrectRate;
disp(accuracy_percent);