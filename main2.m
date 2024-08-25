
%% 
clc 
clear
model = CreatModel();
%% 
SearchAgents_no=100; % Number of search agents
Max_iteration=20; % Maximum numbef of iterations
lb = [1.5,model.x_min,model.y_min,model.h_min,-model.r_max];
ub = [2,model.x_max,model.y_max,model.h_max,model.r_max];
dim = 5;

[BestPosition,BestScore,ConvergenceCurve]=PSO(lb,ub,dim,SearchAgents_no,Max_iteration,@T2_function);
tower = initialization_tower();
tower.position(2) = BestPosition(5);
% 无遮挡的话Asf一定为1
Asf = 1;
model = T2_Change(Asf,BestPosition(1),BestPosition(2),BestPosition(3),BestPosition(4),BestPosition(5),model);
Plot_Model(model,tower);

% -BestScore 为结果