clear all;
clc;
X=xlsread('C:\Users\WH\Desktop\论文资料\三维微震数据(剔除案例).xlsx',1,'A1:C1500');
[num,dim] = size(X);
N=100;
k=zeros(N,1);
D=pdist(X);
%miu=mean(D);
%sigma=std(D);
miu=min(D);
sigma=max(D);
for t=1:N
    %T2=miu-3*sigma+(6*sigma)*(N-1)/99;
    %T2=(miu+3*sigma)*(N-1)/99;
    T2=miu+(sigma-miu)*(N-1)/99;
    K_max=20;
    %%%%%%%%%canopy 自动划分聚类中心和个数%%%%%%%%%
    k(t) = 0;
    YB=[X zeros(num,1)]; 
    Centr=zeros(K_max,dim);
    while size(YB,1) && (k(t)<K_max)
        k(t)=k(t)+1;
        Centr(k(t),:)=YB(1,1:dim);
        YB(1,:)=[];            %在选取第一个点为聚类点并删除
        L=size(YB,1);
        if L
            dist1=(YB(:,1:dim)-ones(L,1)*Centr(k(t),1:dim)).^2;   %计算欧式距离
            dist2=sum(dist1,2);  
        end
        for i=1:L-1
            if(dist2(i)<T2)  %<T2说明是该类，在矩阵中删除
               YB(i,dim+1)=1;
            end
        end
        YB(YB(:,dim+1)==1,:)=[];  %删除已归类的元素
    end
end
tabulate(k(:))