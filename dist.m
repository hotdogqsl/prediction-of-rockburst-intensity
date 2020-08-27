clear all
clc
warning off
X1=[-0.509 -0.184 0.801];
X2=[-0.073 0.133 -0.752];
X3=[-0.786 -0.422 -0.384];
X4=[0.094 0.846 0.020];
X5=[0.608 -0.452 0.185];
X=[X1;X2;X3;X4;X5];
data = xlsread('C:\Users\Administrator\Desktop\°¸Àý.xlsx',1,'A1:J3');
d=data';
dist1=zeros(10,5);
for i=1:10
    for j=1:5
        dist1(i,j)=sqrt(sum((d(i,:)-X(j,:)).^2)); 
    end
end

    
    