
%% 
clc 
clear
model = CreatModel();
%% 
SearchAgents_no=100; % Number of search agents
Max_iteration=10; % Maximum numbef of iterations
lb = 1;
ub = 4;
dim = 1;

[Best_pos,Best_score,GWO_cg_curve]=PSO(lb,ub,dim,SearchAgents_no,Max_iteration,@T1_function);
% 无遮挡的话Asf一定为1
Asf = 1;
Arlim = Best_pos(1);
model = T1_Change(Asf,Arlim,model);
tower = initialization_tower();
Plot_Model(model,tower);