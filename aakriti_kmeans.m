clc;
clear all;
%%
data1=readtable('iris_dataset.xlsx');
%%
%data preprocessing
%remove unnecessary columns
data=data1(:,2:5);

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
data_arr=table2array(data);
%clustering the data
[idx,C]=kmeans(data_arr,4);
%visualizing the results
figure,
gscatter(data_arr(:,1),data_arr(:,2),idx);
hold on
for i=1:5
    scatter(C(i,1),C(i,2),48,'black','filled');
end
legend({'Cluster 1', 'Cluster 2', 'Cluster 3','Cluster4'});
