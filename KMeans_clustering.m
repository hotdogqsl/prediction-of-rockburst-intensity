function [u re h k]=KMeans(data,N)   
    [m n]=size(data);   %m是数据个数，n是数据维数
    ma=zeros(1,n);        %每一维最大的数
    mi=zeros(1,n);        %每一维最小的数
    u=zeros(N,n);       %随机初始化，最终迭代到每一类的中心位置
    re=zeros(m,n+1);   %最后一列储存类别
    re(:,1:n)=data(:,:);
    h=0;
    
    for i=1:n
       ma(i)=max(data(:,i));    %每一维最大的数
       mi(i)=min(data(:,i));    %每一维最小的数
       for j=1:N
            u(j,i)=ma(i)+(mi(i)-ma(i))*rand();  %随机初始化，不过还是在每一维[min max]中初始化好些
       end      
    end
    k=u;
    while 1
        pre_u=u;            %上一次求得的中心位置
        distence=zeros(1,N);
        num=zeros(1,N);
        for x=1:m
            for y=1:N
                distence(y)=norm(data(x,:)-pre_u(y,:));%计算到每个类的距离
            end
            [~, temp]=min(distence);%求最小的距离
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
        h=h+1;%迭代次数
        if norm(pre_u-u)==0  %不断迭代直到位置不再变化
            break;
        end
    end   
end