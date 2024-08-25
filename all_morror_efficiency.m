function Sum_Efeild = all_morror_efficiency(model,tower)
%ALL_MORROR_EFFICIENCY 此处显示有关此函数的摘要
environment = initialization_environment();
Sum_Efeild = 0;

for i=1:model.circle_number
    if mod(i,2)==1 %奇数处理
       j = [-(model.MorrorsNumber_PerCircle(i)-1)/2:(model.MorrorsNumber_PerCircle(i)-1)/2];
       x = model.r(i)*cos(0.5*pi+j*model.dzeta(i));
       y = model.r(i)*sin(0.5*pi+j*model.dzeta(i));
    else
       j = [-(model.MorrorsNumber_PerCircle(i))/2:(model.MorrorsNumber_PerCircle(i))/2-1];
       x = model.r(i)*cos(0.5*pi+0.5*model.dzeta(i)+j*model.dzeta(i));
       y = model.r(i)*sin(0.5*pi+0.5*model.dzeta(i)+j*model.dzeta(i));
    end
    temp1 = tower.position(2);
    temp2 = model.h(i);
    temp3 = model.size;
    for k = 1:model.MorrorsNumber_PerCircle(i) 
        if sqrt(x(k)^2+(y(k)+temp1)^2) <= 350
            for l = 1:60
            Sum_Efeild = Sum_Efeild + environment(l).DNI*(1/60)*one_morror_efficiency(x(k),y(k)+temp1,temp2,temp3,environment,tower);
            end
        end
    end
    clear x y j temp1 temp2 temp3

end
Sum_Efeild = model.size(1)*model.size(2)*real(Sum_Efeild)*1000; % 输出热功率里面的面积放在这里，1000为kw转化为w
end

