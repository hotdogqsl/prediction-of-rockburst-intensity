clear all;
clc;
Data=xlsread('C:\Users\WH\Desktop\��������\΢������.xlsx',1,'E2:I1511');
mappedData=compute_mapping(Data,'tSNE',3);
scatter3(mappedData(:,1),mappedData(:,2),mappedData(:,3));