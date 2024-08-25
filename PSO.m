 
%% Particle Swarm Optimization Algorithm (PSO) 
% source codes version 1.0

% nPop = ����Ⱥ������
% nVar = ��������
% MaxIt = ����������
% VarMin=[Min1,Min2,...,Minn]  Minn�Ǳ���n������
% VarMax=[Max1,Max2,...,Maxn]  Maxn�Ǳ���n������
% ������б�����������ͬ�����Խ��ñ�������Ϊ��������

% To run PSO: [BestPosition,BestScore,ConvergenceCurve] = PSO(VarMin,VarMax,nVar,nPop,MaxIt)

function [BestPosition,BestScore,ConvergenceCurve] = PSO(VarMin,VarMax,nVar,nPop,MaxIt,CostFunction)
%% ���ⶨ��

% CostFunction=@(x) Sphere(x);        % ���ۺ���

VarSize=[1 nVar];   % ��������Ĵ�С

%% �㷨����
w=1;            % ����ָ��
wdamp=0.99;     % ����ָ���½��ٶ�
c1=1.5;         % ����ѧϰ����
c2=2.0;         % ȫ��ѧϰ����

% �ٶ�����
VelMax=0.1*(VarMax-VarMin);
VelMin=-VelMax;

%% ��ʼ����Ⱥ

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
disp('��ʼ����� ');

%% ��������

IsOutside(nPop,:) = false(VarSize);
BestCost=zeros(MaxIt,1);
for it=1:MaxIt

    parfor i=1:nPop %���ۺ������㸴��(1min)ʱ����� parfor
        % �����ٶ�
        particle(i).Velocity = w*particle(i).Velocity ...
            +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
            +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
        
        % �ٶ�����
        particle(i).Velocity = max(particle(i).Velocity,VelMin);
        particle(i).Velocity = min(particle(i).Velocity,VelMax);
        
        % ����λ��
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        
        % ������Χ���ٶȱ�Ϊ����
        IsOutside(i,:) = (particle(i).Position<VarMin | particle(i).Position>VarMax);
        particle(i).Velocity(IsOutside(i,:))=-particle(i).Velocity(IsOutside(i,:));
        
        % λ������
        particle(i).Position = max(particle(i).Position,VarMin);
        particle(i).Position = min(particle(i).Position,VarMax);
        
        % ����
        particle(i).Cost = CostFunction(particle(i).Position);
        
        % ���¸�������λ��
        if particle(i).Cost<particle(i).Best.Cost
            
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
              
        end
        
    end
    for i=1:nPop
            % ����ȫ������λ��
        if particle(i).Best.Cost<GlobalBest.Cost
                
                GlobalBest=particle(i).Best;
                
        end 
    end
    
    BestCost(it)=GlobalBest.Cost;
    
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    w=w*wdamp;
    
end

%% ��ֵ��
BestPosition     = GlobalBest.Position;
BestScore        = GlobalBest.Cost;
ConvergenceCurve = BestCost;

%% ���չʾ

% figure;
% %plot(BestCost,'LineWidth',2);
% semilogy(BestCost,'LineWidth',2);
% xlabel('Iteration');
% ylabel('Best Cost');
% grid on;

end

