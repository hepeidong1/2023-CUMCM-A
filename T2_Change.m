function model= T2_Change(Asf,Arlim,x,y,h,y0,model)
%T1_CHANGE 此处显示有关此函数的摘要
%   此处显示详细说明
model.size(1) = x;
model.size(2) = y;
model.h = h * ones(1,model.circle_number);
tower = initialization_tower();
tower.position(2) = y0;

R = [];
R(1) = 100;
R(model.circle_number) = 0;

Dzeta = [];
Dzeta(model.circle_number) = 0;

flag_reset = 0;
flag_r0_per_area = 100;

minr = model.size(2)+5;
temp_dR = 0;
Dm = sqrt(model.size(1)^2+model.size(2)^2);%此处为后一区域镜子直径
temp_dr = max(minr,sqrt(Dm^2 - (Asf*model.size(1)/2)^2));
temp_zeta = real(2*asin(Asf*model.size(1)/(2*R(1))));
% temp_zeta = mod(temp_zeta,pi); % ???????? 还不知道怎么处理
Dzeta(1) = temp_zeta;

for R_num = 2:model.circle_number
   
    if flag_reset == 1 % 重新计算各区域的具体参数
        L1 = sqrt((tower.H_pole+0.5*tower.H_absorb-model.h(R_num-1))^2+R(R_num-1)^2);
        a1 = asin(R(R_num-1)/L1);
        a2 = asin(sqrt(model.size(1)^2+model.size(2)^2)/L1);%此处为前一区域镜子直径
        L3 = tan(a1+a2)*(tower.H_pole-model.h(R_num-1));
        temp_dR = max(minr,2*(L3-R(R_num-1)));
        temp_dr = max(minr,sqrt(Dm^2 - (Asf*model.size(1)/2)^2));
        temp_zeta = real(2*asin(Asf*model.size(1)/(2*R(R_num))));
    end
    
    if flag_reset == 1 % 区分区域的增加半径
        R(R_num) = R(R_num-1)+temp_dR;
        flag_r0_per_area = R(R_num);
    else
        R(R_num) = R(R_num-1)+temp_dr;
    end
    
    if flag_reset == 1 % 重新计算各区域的具体参数
        temp_zeta = real(2*asin(Asf*model.size(1)/(2*R(R_num))));
    end
    
    % 区域内部的角度都是相等的
    Dzeta(R_num) = temp_zeta;
    
    % 重置标志参数然后进行区域判断
    flag_reset = 0;
    if R(R_num)/flag_r0_per_area > Arlim
        flag_reset = 1;
    end
end
model.r = R;
model.dzeta = Dzeta;
model = ReStatisticsTheMorrors(model,tower);
end

