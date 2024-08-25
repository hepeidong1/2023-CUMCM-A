function model= T2_Change(Asf,Arlim,x,y,h,y0,model)
%T1_CHANGE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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
Dm = sqrt(model.size(1)^2+model.size(2)^2);%�˴�Ϊ��һ������ֱ��
temp_dr = max(minr,sqrt(Dm^2 - (Asf*model.size(1)/2)^2));
temp_zeta = real(2*asin(Asf*model.size(1)/(2*R(1))));
% temp_zeta = mod(temp_zeta,pi); % ???????? ����֪����ô����
Dzeta(1) = temp_zeta;

for R_num = 2:model.circle_number
   
    if flag_reset == 1 % ���¼��������ľ������
        L1 = sqrt((tower.H_pole+0.5*tower.H_absorb-model.h(R_num-1))^2+R(R_num-1)^2);
        a1 = asin(R(R_num-1)/L1);
        a2 = asin(sqrt(model.size(1)^2+model.size(2)^2)/L1);%�˴�Ϊǰһ������ֱ��
        L3 = tan(a1+a2)*(tower.H_pole-model.h(R_num-1));
        temp_dR = max(minr,2*(L3-R(R_num-1)));
        temp_dr = max(minr,sqrt(Dm^2 - (Asf*model.size(1)/2)^2));
        temp_zeta = real(2*asin(Asf*model.size(1)/(2*R(R_num))));
    end
    
    if flag_reset == 1 % ������������Ӱ뾶
        R(R_num) = R(R_num-1)+temp_dR;
        flag_r0_per_area = R(R_num);
    else
        R(R_num) = R(R_num-1)+temp_dr;
    end
    
    if flag_reset == 1 % ���¼��������ľ������
        temp_zeta = real(2*asin(Asf*model.size(1)/(2*R(R_num))));
    end
    
    % �����ڲ��ĽǶȶ�����ȵ�
    Dzeta(R_num) = temp_zeta;
    
    % ���ñ�־����Ȼ����������ж�
    flag_reset = 0;
    if R(R_num)/flag_r0_per_area > Arlim
        flag_reset = 1;
    end
end
model.r = R;
model.dzeta = Dzeta;
model = ReStatisticsTheMorrors(model,tower);
end

