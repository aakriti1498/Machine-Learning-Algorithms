%logistic regression
clc;
clear all;
%%
data1=readtable('iris_dataset.xlsx');
%%
%data preprocessing
%remove unnecessary columns
data=data1(:,2:6);
%find missing valuesT
for i=1:4
    s1='data(ismember(data.';
    s2=strcat('x',num2str(i));
    s3=',-1),:)=[];';
    exp=strcat(s1,s2,s3);
    eval(exp);
end
%normalizing the data
data.x4=(data.x4-min(data.x4))/(max(data.x4)-min(data.x4));
%%
c=cvpartition(size(data,1),'HoldOut',0.3);
idx=test(c);
Trained_data=data(~idx,:);
Test_data=data(idx,:);
X_train=[Trained_data.x1,Trained_data.x2,Trained_data.x3,Trained_data.x4];
Y_train=[Trained_data.y];
B=mnrfit(X_train,Y_train);
X_test=[Test_data.x1,Test_data.x2,Test_data.x3,Test_data.x4];
Y_test=[Test_data.y];
[p,q]=size(X_test);
predictions=[];
%%
for i=1:p
    pihat=mnrval(B,X_test(i,:));
    if (pihat(1,1)>pihat(1,2)&&pihat(1,1)>pihat(1,3))
        y_estimate=1;
    elseif(pihat(1,2)>pihat(1,1)&&pihat(1,2)>pihat(1,3))
        y_estimate=2;
    else
        y_estimate=3;
    end
    
    
    predictions=[predictions y_estimate];

end
predictions1=transpose(predictions);
cp=classperf(Test_data.y,predictions1);
accuracy=cp.CorrectRate;
display(accuracy);
