 
%% Particle Swarm Optimization Algorithm (PSO) 
% source codes version 1.0

% nPop = 粒子群粒子数
% nVar = 变量个数
% MaxIt = 最大迭代次数
% VarMin=[Min1,Min2,...,Minn]  Minn是变量n的下限
% VarMax=[Max1,Max2,...,Maxn]  Maxn是变量n的上限
% 如果所有变量上下限相同，可以将该变量定义为单个数字

% To run PSO: [BestPosition,BestScore,ConvergenceCurve] = PSO(VarMin,VarMax,nVar,nPop,MaxIt)

function [BestPosition,BestScore,ConvergenceCurve] = PSO(VarMin,VarMax,nVar,nPop,MaxIt,CostFunction)
%% 问题定义

% CostFunction=@(x) Sphere(x);        % 代价函数

VarSize=[1 nVar];   % 迭代矩阵的大小

%% 算法参数
w=1;            % 惯性指数
wdamp=0.99;     % 惯性指数下降速度
c1=1.5;         % 个体学习因数
c2=2.0;         % 全局学习因数

% 速度限制
VelMax=0.1*(VarMax-VarMin);
VelMin=-VelMax;

%% 初始化种群

empty_particle.Position=[];
empty_particle.Cost=[];
empty_particle.Velocity=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];

particle=repmat(empty_particle,nPop,1);

GlobalBest.Cost=inf;

parfor i=1:nPop
    % Initialize Position
    particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    % Initialize Velocity 
    particle(i).Velocity=zeros(VarSize);
    
    % Evaluation
    particle(i).Cost=CostFunction(particle(i).Position);
    
    % Update Personal Best
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
end
for i=1:nPop
    % Update Global Best
    if particle(i).Best.Cost < GlobalBest.Cost
        
        GlobalBest=particle(i).Best;
        
    end
    
end
disp('初始化完成 ');

%% 迭代过程

IsOutside(nPop,:) = false(VarSize);
BestCost=zeros(MaxIt,1);
for it=1:MaxIt

    parfor i=1:nPop %代价函数计算复杂(1min)时这里改 parfor
        % 更新速度
        particle(i).Velocity = w*particle(i).Velocity ...
            +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
            +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
        
        % 速度限制
        particle(i).Velocity = max(particle(i).Velocity,VelMin);
        particle(i).Velocity = min(particle(i).Velocity,VelMax);
        
        % 更新位置
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        
        % 超出范围则速度变为反向
        IsOutside(i,:) = (particle(i).Position<VarMin | particle(i).Position>VarMax);
        particle(i).Velocity(IsOutside(i,:))=-particle(i).Velocity(IsOutside(i,:));
        
        % 位置限制
        particle(i).Position = max(particle(i).Position,VarMin);
        particle(i).Position = min(particle(i).Position,VarMax);
        
        % 评估
        particle(i).Cost = CostFunction(particle(i).Position);
        
        % 更新个体最优位置
        if particle(i).Cost<particle(i).Best.Cost
            
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
              
        end
        
    end
    for i=1:nPop
            % 更新全局最优位置
        if particle(i).Best.Cost<GlobalBest.Cost
                
                GlobalBest=particle(i).Best;
                
        end 
    end
    
    BestCost(it)=GlobalBest.Cost;
    
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    w=w*wdamp;
    
end

%% 赋值区
BestPosition     = GlobalBest.Position;
BestScore        = GlobalBest.Cost;
ConvergenceCurve = BestCost;

%% 结果展示

% figure;
% %plot(BestCost,'LineWidth',2);
% semilogy(BestCost,'LineWidth',2);
% xlabel('Iteration');
% ylabel('Best Cost');
% grid on;

end

