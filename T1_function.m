function ans = T1_function(x)
model = CreatModel();
tower = initialization_tower();
model= T1_Change(1,x,model); % ���ڵ��Ļ�Asfһ��Ϊ1
ans = -all_morror_efficiency(model,tower); % �˴�����Ϊ�˷�����Ⱥ�Ż��㷨����Сֵ
end

