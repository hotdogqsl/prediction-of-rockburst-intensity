clear all;
clc;
X=xlsread('C:\Users\WH\Desktop\��������\��ά΢������(�޳�����).xlsx',1,'A1:C1500');
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
    %%%%%%%%%canopy �Զ����־������ĺ͸���%%%%%%%%%
    k(t) = 0;
    YB=[X zeros(num,1)]; 
    Centr=zeros(K_max,dim);
    while size(YB,1) && (k(t)<K_max)
        k(t)=k(t)+1;
        Centr(k(t),:)=YB(1,1:dim);
        YB(1,:)=[];            %��ѡȡ��һ����Ϊ����㲢ɾ��
        L=size(YB,1);
        if L
            dist1=(YB(:,1:dim)-ones(L,1)*Centr(k(t),1:dim)).^2;   %����ŷʽ����
            dist2=sum(dist1,2);  
        end
        for i=1:L-1
            if(dist2(i)<T2)  %<T2˵���Ǹ��࣬�ھ�����ɾ��
               YB(i,dim+1)=1;
            end
        end
        YB(YB(:,dim+1)==1,:)=[];  %ɾ���ѹ����Ԫ��
    end
end
tabulate(k(:))