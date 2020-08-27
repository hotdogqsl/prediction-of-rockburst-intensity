clear all;
close all;
clc;
data=xlsread('C:\Users\WH\Desktop\��������\��ά΢������(�޳�����).xlsx',1,'A1:C1500');
[m n]=size(data);
re=zeros(m,n+1);   %���һ�д������
re(:,1:n)=data(:,:);
h=0;
load('k.mat');
N=5;
u=k;
while 1
    pre_u=u;            %��һ����õ�����λ��
    distence=zeros(1,N);
    num=zeros(1,N);
    for x=1:m
        for y=1:N
            distence(y)=norm(data(x,:)-pre_u(y,:));%���㵽ÿ����ľ���
        end
        [~, temp]=min(distence);%����С�ľ���
        re(x,n+1)=temp;
    end
    for y=1:N
        for x=1:m
            if re(x,n+1)==y
                u(y,:)=u(y,:)+re(x,1:n);
                num(y)=num(y)+1;
            end
        end
        u(y,:)=u(y,:)/num(y);
    end
    h=h+1;%��������
    if h==1
        figure;%subplot(2,2,1);
        for i=1:m
            if re(i,4)==1
                w1=scatter3(re(i,1),re(i,2),re(i,3),'ro');hold on;
            elseif re(i,4)==2
                w2=scatter3(re(i,1),re(i,2),re(i,3),'go');hold on;
            elseif re(i,4)==3
                w3=scatter3(re(i,1),re(i,2),re(i,3),'yo');hold on;
            elseif re(i,4)==4
                w4=scatter3(re(i,1),re(i,2),re(i,3),'ko');hold on;
            else
                w5=scatter3(re(i,1),re(i,2),re(i,3),'bo');hold on;
            end
        end
        grid on;
        view(35.7800,15.2800);
        legend([w1(1),w2(1),w3(1),w4(1),w5(1)],'����1', '����2', '����3', '����4', '����5','location', 'northeast');
        title('1')
    end
    if h==4
        figure;%subplot(2,2,2);
        for i=1:m
            if re(i,4)==1
                w1=scatter3(re(i,1),re(i,2),re(i,3),'ro');hold on;
            elseif re(i,4)==2
                w2=scatter3(re(i,1),re(i,2),re(i,3),'go');hold on;
            elseif re(i,4)==3
                w3=scatter3(re(i,1),re(i,2),re(i,3),'yo');hold on;
            elseif re(i,4)==4
                w4=scatter3(re(i,1),re(i,2),re(i,3),'ko');hold on;
            else
                w5=scatter3(re(i,1),re(i,2),re(i,3),'bo');hold on;
            end
        end
        grid on;
        view(35.7800,15.2800);
        legend([w1(1),w2(1),w3(1),w4(1),w5(1)],'����1', '����2', '����3', '����4', '����5','location', 'northeast');
        title('2')
    end
    if h==8
        figure;%subplot(2,2,3);
        for i=1:m
            if re(i,4)==1
                w1=scatter3(re(i,1),re(i,2),re(i,3),'ro');hold on;
            elseif re(i,4)==2
                w2=scatter3(re(i,1),re(i,2),re(i,3),'go');hold on;
            elseif re(i,4)==3
                w3=scatter3(re(i,1),re(i,2),re(i,3),'yo');hold on;
            elseif re(i,4)==4
                w4=scatter3(re(i,1),re(i,2),re(i,3),'ko');hold on;
            else
                w5=scatter3(re(i,1),re(i,2),re(i,3),'bo');hold on;
            end
        end
        grid on;
        view(35.7800,15.2800);
        legend([w1(1),w2(1),w3(1),w4(1),w5(1)],'����1', '����2', '����3', '����4', '����5','location', 'northeast');
        title('3')
    end
    if h==12
        figure;%subplot(2,2,4);
        for i=1:m
            if re(i,4)==1
                w1=scatter3(re(i,1),re(i,2),re(i,3),'ro');hold on;
            elseif re(i,4)==2
                w2=scatter3(re(i,1),re(i,2),re(i,3),'go');hold on;
            elseif re(i,4)==3
                w3=scatter3(re(i,1),re(i,2),re(i,3),'yo');hold on;
            elseif re(i,4)==4
                w4=scatter3(re(i,1),re(i,2),re(i,3),'ko');hold on;
            else
                w5=scatter3(re(i,1),re(i,2),re(i,3),'bo');hold on;
            end
        end
        grid on;
        view(35.7800,15.2800);
        legend([w1(1),w2(1),w3(1),w4(1),w5(1)],'����1', '����2', '����3', '����4', '����5','location', 'northeast');
        title('4')
    end
    if norm(pre_u-u)==0  %���ϵ���ֱ��λ�ò��ٱ仯
        break;
    end
end