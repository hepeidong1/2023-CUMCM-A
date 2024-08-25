function ans = T1_function(x)
model = CreatModel();
tower = initialization_tower();
model= T1_Change(1,x,model); % 无遮挡的话Asf一定为1
ans = -all_morror_efficiency(model,tower); % 此处负数为了方便狼群优化算法找最小值
end

