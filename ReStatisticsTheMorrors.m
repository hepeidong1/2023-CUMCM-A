function model = ReStatisticsTheMorrors(model,tower)
%STATISTICSTHEMORRORS 此处显示有关此函数的摘要
%   此处显示详细说明
munber_PerCircle = [];
munber_PerCircle(model.circle_number) = 0;
for i=1:model.circle_number
    munber_PerCircle(i) = floor(2*pi/model.dzeta(i));
    % 修正数据
    if mod(i,2)==1 %奇数处理
        munber_PerCircle(i) = 2*ceil(munber_PerCircle(i)/2)-1;
    else
        munber_PerCircle(i) = 2*floor(munber_PerCircle(i)/2);
    end

    if mod(i,2)==1 %奇数处理
       j = [-(munber_PerCircle(i)-1)/2:(munber_PerCircle(i)-1)/2];
       x = model.r(i)*cos(0.5*pi+j*model.dzeta(i))+tower.position(1);
       y = model.r(i)*sin(0.5*pi+j*model.dzeta(i))+tower.position(2);
    else
       j = [-(munber_PerCircle(i))/2:(munber_PerCircle(i))/2-1];
       x = model.r(i)*cos(0.5*pi+0.5*model.dzeta(i)+j*model.dzeta(i))+tower.position(1);
       y = model.r(i)*sin(0.5*pi+0.5*model.dzeta(i)+j*model.dzeta(i))+tower.position(2);
    end
    s = size(j);
    n = zeros(1,s(2));
    parfor k = 1:s(2)
        if x(k)^2+y(k)^2 <= 350^2
            n(k) = 1
        end
    end
    munber_PerCircle(i) = sum(n);
    clear n
end
model.MorrorsNumber_PerCircle= munber_PerCircle;
model.MorrorsNumber = sum(munber_PerCircle);
end

