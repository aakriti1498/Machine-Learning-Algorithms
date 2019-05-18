%logistic regression
clc;
clear all;
%%
%importing the data 
data1=readtable('breastcancer_dataset_standard_format.xlsx');
%%
%data preprocessing
data=data1(:,2:end);
%missing values
 for i=1:9
 s1='data(ismember(data.';'
 s2=strcat('x',num2str(i));
 s3=',-1),:)=[];';
 expr=strcat(s1,s2,s3);
 eval(expr);
end

%%
c=cvpartition((size(data,1)),'HoldOut',0.3);
idx=test(c);
Train_data=data(~idx,:);
Test_data=data(idx,:);
Test_data1=table2array(Test_data);
Train_data1=table2array(Train_data);
Train_data_X=Train_data1(:,1:9);
train_data_Y=Train_data1(:,10);
for  i=1:9
    Train_data_X(:,i)=double(Train_data_X(:,i));
    
end
%%
for i = 1:479 
    if(train_data_Y(i,1) == 0)
        train_data_Y(i,1) = 2;
    end
end
B = mnrfit(Train_data_X,train_data_Y);
predictions=[];
%%
for i=1:204
pihat = mnrval(B,(Test_data1(i,1:9)));
 if (pihat(1,1)> pihat(1,2))
        y_estimate=1;
 else
        y_estimate=2;
 end
 predictions=[predictions y_estimate];
end
cp = classperf(Test_data1(:,10),predictions');
accuracy = cp.CorrectRate

