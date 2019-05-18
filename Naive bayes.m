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

c=cvpartition(size(data,1),'HoldOut',0.3);
idx=test(c);
Trained_data=data(~idx,:);
Test_data=data(idx,:);
Test_data1=data(idx,1:4);
model=fitcnb(Trained_data,'y');
%%
prediction=predict(model,Test_data1);
cp = classperf(Test_data.y,prediction);
accuracy = cp.CorrectRate;
disp(accuracy);

Results = confusionmat(Test_data.y,prediction);
plot(Results);
