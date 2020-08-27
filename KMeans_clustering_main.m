clear all;
close all;
clc;
data=xlsread('C:\Users\WH\Desktop\论文资料\三维微震数据(剔除案例).xlsx',1,'A1:C1500');
[u re h k]=KMeans(data,5);
[m n]=size(data);
figure;
for i=1:m 
    if re(i,4)==1   
         scatter3(re(i,1),re(i,2),re(i,3),'ro');hold on; 
    elseif re(i,4)==2
         scatter3(re(i,1),re(i,2),re(i,3),'go');hold on;
    elseif re(i,4)==3
         scatter3(re(i,1),re(i,2),re(i,3),'yo');hold on; 
    elseif re(i,4)==4
         scatter3(re(i,1),re(i,2),re(i,3),'ko');hold on;
    else 
         scatter3(re(i,1),re(i,2),re(i,3),'bo');hold on;
    end
end
grid on;