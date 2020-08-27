clear all
clc
warning off
data = xlsread('C:\Users\Administrator\Desktop\数据.xlsx',1,'A1:H1500');
P1=data(:, 1 : 5);
T1=data(:, 6 : 8);
P2=xlsread('C:\Users\Administrator\Desktop\案例微震数据.xlsx',1,'A1:E10');
P_train = P1';
T_train = T1';
P_test = P2';
%% 归一化
[Pn_train,inputps] = mapminmax(P_train);
Pn_test = mapminmax('apply',P_test,inputps);

%% 参数设置
popsize = 200;                      % 种群大小
bestsize = 5;                       % 优胜子种群个数
tempsize = 5;                       % 临时子种群个数
SG = popsize / (bestsize+tempsize); % 子群体大小
S1 = size(Pn_train,1);              % 输入层神经元个数
S2 = 6;                            % 隐含层神经元个数
S3 = size(T_train,1);              % 输出层神经元个数
iter = 10;                          % 迭代次数

%% 随机产生初始种群
initpop = initpop_generate(popsize,S1,S2,S3,Pn_train,T_train);

%% 产生优胜子群体和临时子群体
% 得分排序
[sort_val,index_val] = sort(initpop(:,end),'descend');
% 产生优胜子种群和临时子种群的中心
bestcenter = initpop(index_val(1:bestsize),:);
tempcenter = initpop(index_val(bestsize+1:bestsize+tempsize),:);
% 产生优胜子种群
bestpop = cell(bestsize,1);
for i = 1:bestsize
    center = bestcenter(i,:);
    bestpop{i} = subpop_generate(center,SG,S1,S2,S3,Pn_train,T_train);
end
% 产生临时子种群
temppop = cell(tempsize,1);
for i = 1:tempsize
    center = tempcenter(i,:);
    temppop{i} = subpop_generate(center,SG,S1,S2,S3,Pn_train,T_train);
end

while iter > 0
    %% 优胜子群体趋同操作并计算各子群体得分
    best_score = zeros(1,bestsize);
    best_mature = cell(bestsize,1);
    for i = 1:bestsize
        best_mature{i} = bestpop{i}(1,:);
        best_flag = 0;                % 优胜子群体成熟标志(1表示成熟，0表示未成熟)
        while best_flag == 0
            % 判断优胜子群体是否成熟
            [best_flag,best_index] = ismature(bestpop{i});
            % 若优胜子群体尚未成熟，则以新的中心产生子种群
            if best_flag == 0
                best_newcenter = bestpop{i}(best_index,:);
                best_mature{i} = [best_mature{i};best_newcenter];
                bestpop{i} = subpop_generate(best_newcenter,SG,S1,S2,S3,Pn_train,T_train);
            end
        end
        % 计算成熟优胜子群体的得分
        best_score(i) = max(bestpop{i}(:,end));
    end
    
    %% 临时子群体趋同操作并计算各子群体得分
    temp_score = zeros(1,tempsize);
    temp_mature = cell(tempsize,1);
    for i = 1:tempsize
        temp_mature{i} = temppop{i}(1,:);
        temp_flag = 0;                % 临时子群体成熟标志(1表示成熟，0表示未成熟)
        while temp_flag == 0
            % 判断临时子群体是否成熟
            [temp_flag,temp_index] = ismature(temppop{i});
            % 若临时子群体尚未成熟，则以新的中心产生子种群
            if temp_flag == 0
                temp_newcenter = temppop{i}(temp_index,:);
                temp_mature{i} = [temp_mature{i};temp_newcenter];
                temppop{i} = subpop_generate(temp_newcenter,SG,S1,S2,S3,Pn_train,T_train);
            end
        end
        % 计算成熟临时子群体的得分
        temp_score(i) = max(temppop{i}(:,end));
    end
    
    %% 异化操作
    [score_all,index] = sort([best_score temp_score],'descend');
    % 寻找临时子群体得分高于优胜子群体的编号
    rep_temp = index(find(index(1:bestsize) > bestsize)) - bestsize;
    % 寻找优胜子群体得分低于临时子群体的编号
    rep_best = index(find(index(bestsize+1:end) < bestsize+1) + bestsize);
    
    % 若满足替换条件
    if ~isempty(rep_temp)
        % 得分高的临时子群体替换优胜子群体
        for i = 1:length(rep_best)
            bestpop{rep_best(i)} = temppop{rep_temp(i)};
        end
        % 补充临时子群体，以保证临时子群体的个数不变
        for i = 1:length(rep_temp)
            temppop{rep_temp(i)} = initpop_generate(SG,S1,S2,S3,Pn_train,T_train);
        end
    else
        break;
    end
    
    %% 输出当前迭代获得的最佳个体及其得分
    if index(1) < 6
        best_individual = bestpop{index(1)}(1,:);
    else
        best_individual = temppop{index(1) - 5}(1,:);
    end

    iter = iter - 1;
    
end

%% 解码最优个体
x = best_individual;

% 前S1*S2个编码为W1
temp = x(1:S1*S2);
W1 = reshape(temp,S2,S1);

% 接着的S2*S3个编码为W2
temp = x(S1*S2+1:S1*S2+S2*S3);
W2 = reshape(temp,S3,S2);

% 接着的S2个编码为B1
temp = x(S1*S2+S2*S3+1:S1*S2+S2*S3+S2);
B1 = reshape(temp,S2,1);

%接着的S3个编码B2
temp = x(S1*S2+S2*S3+S2+1:end-1);
B2 = reshape(temp,S3,1);

% E_optimized = zeros(1,100);
% for i = 1:100
%% 创建/训练BP神经网络
net_optimized = newff(Pn_train,T_train,S2);
% 设置训练参数
net_optimized.trainParam.epochs = 100;
net_optimized.trainParam.show = 10;
net_optimized.trainParam.goal = 1e-4;
net_optimized.trainParam.lr = 0.1;
net_optimized.trainParam.max_fail = 15;
% 设置网络初始权值和阈值
net_optimized.IW{1,1} = W1;
net_optimized.LW{2,1} = W2;
net_optimized.b{1} = B1;
net_optimized.b{2} = B2;
% 利用新的权值和阈值进行训练
net_optimized = train(net_optimized,Pn_train,T_train);

%% 仿真测试
Tn_sim_optimized1 = sim(net_optimized,Pn_test);     
