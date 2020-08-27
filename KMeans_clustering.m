function [u re h k]=KMeans(data,N)   
    [m n]=size(data);   %m�����ݸ�����n������ά��
    ma=zeros(1,n);        %ÿһά������
    mi=zeros(1,n);        %ÿһά��С����
    u=zeros(N,n);       %�����ʼ�������յ�����ÿһ�������λ��
    re=zeros(m,n+1);   %���һ�д������
    re(:,1:n)=data(:,:);
    h=0;
    
    for i=1:n
       ma(i)=max(data(:,i));    %ÿһά������
       mi(i)=min(data(:,i));    %ÿһά��С����
       for j=1:N
            u(j,i)=ma(i)+(mi(i)-ma(i))*rand();  %�����ʼ��������������ÿһά[min max]�г�ʼ����Щ
       end      
    end
    k=u;
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
        if norm(pre_u-u)==0  %���ϵ���ֱ��λ�ò��ٱ仯
            break;
        end
    end   
end