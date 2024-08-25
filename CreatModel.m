function model = CreatModel()
% n 环数
% dzeta 偏转角度
% r 半径
% h 高度
% morror_r 镜子半径
model = initialization_model();
tower = initialization_tower();
x = 6;
y = 6;
n = 120;
morror_r = 0.5*sqrt(x^2+y^2);
dzeta_min = 2*asin(morror_r/100);

model.size = [x,y];
model.morror_r = morror_r;
model.circle_number = n;

temp = [model.r_min:(model.r_max-model.r_min)/(n-1):model.r_max];
model.r = temp;
clear temp

temp = dzeta_min*ones(1,n);
model.dzeta = temp;
clear temp

temp = 4*ones(1,n);
model.h = temp;
clear temp

model = ReStatisticsTheMorrors(model,tower);
end

