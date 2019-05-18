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
s1='data(ismember(data.';
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
test_data=Test_data1(:,1:9);
Train_data1=table2array(Train_data);
Train_data_X=Train_data1(:,1:9);
train_data_Y=Train_data1(:,10);
for  i=1:9
    Train_data_X(:,i)=double(Train_data_X(:,i));
    
end
%%
net=patternnet(10);
net=train(net,Train_data_X',train_data_Y');
%%
predictions=net(test_data');
for i=1:204
    if(predictions(1,i)<=0.5)
        predictions(1,i)=0;
    else
        predictions(1,i)=1;
    end
end
%classes=vec2ind(predictions);
%perf = perform(net,t,y);
perf=perform(net,Test_data.y',predictions);



