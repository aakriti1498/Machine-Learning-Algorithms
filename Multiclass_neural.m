%%
clear all;
close all;
clc;
%%
data = readtable('iris_dataset.xlsx');
data = data(:,2:6);
data_array = table2array(data);
[m,n] = size(data_array);
y1 = [];
y2 = [];
y3 = [];
for i = 1:m
    if(data_array(i,5) == 1)
        y1 = [y1 1];
        y2 = [y2 0];
        y3 = [y3 0];
       
    elseif (data_array(i,5) == 2)
        y1 = [y1 0];
        y2 = [y2 1];
        y3 = [y3 0];
    else 
        y1 = [y1 0];
        y2 = [y2 0];
        y3 = [y3 1];
    end
end
Y = data(:,5);
data_new = data_array(:,1:4);
data_new1 = [data_new y1' y2' y3'];
data_table = array2table(data_new1);
%%
c=cvpartition((size(data_table,1)),'HoldOut',0.3);
idx=test(c);
test_data = data_array(idx,5);
Train_data1=data_new1(~idx,1:5);
Train_data2=[data_new1(~idx,1:4) data_new1(~idx,6)];
Train_data3=[data_new1(~idx,1:4) data_new1(~idx,7)];
Test_data1=data_new1(idx,1:5);
Test_data2=[data_new1(idx,1:4) data_new1(idx,6)];
Test_data3=[data_new1(idx,1:4) data_new1(idx,7)];




    
%%
net1=patternnet(10);
net1=train(net1,Train_data1(:,1:4)',data_new1(~idx,5)');
net2=patternnet(10);
net2=train(net2,Train_data2(:,1:4)',data_new1(~idx,6)');
net3=patternnet(10);
net3=train(net3,Train_data3(:,1:4)',data_new1(~idx,7)');
%%
predictions1=net1(Test_data1(:,1:4)');
predictions2=net2(Test_data2(:,1:4)');
predictions3=net3(Test_data3(:,1:4)');
%%
for i=1:45
    if(predictions1(1,i)>=0.5 && predictions2(1,i)<=0.5 && predictions3(1,i)<=0.5  )
        predictions(1,i)=1;
    elseif(predictions1(1,i)<=0.5 && predictions2(1,i)>=0.5 && predictions3(1,i)<=0.5  )
        predictions(1,i)=2;
    else
        predictions(1,i)=3;
    end
end
cp = classperf(test_data,predictions);
accuracy = cp.CorrectRate


