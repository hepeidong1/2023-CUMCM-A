function [] = Plot_Model(model,tower)
%PLOT_MODEL 此处显示有关此函数的摘要
hold on
for i=1:model.circle_number(1)
    if mod(i,2)==1 %奇数处理
       j = [-(model.MorrorsNumber_PerCircle(i)-1)/2:(model.MorrorsNumber_PerCircle(i)-1)/2];
       x = model.r(i)*cos(0.5*pi+j*model.dzeta(i));
       y = model.r(i)*sin(0.5*pi+j*model.dzeta(i));
    else
       j = [-(model.MorrorsNumber_PerCircle(i))/2:(model.MorrorsNumber_PerCircle(i))/2-1];
       x = model.r(i)*cos(0.5*pi+0.5*model.dzeta(i)+j*model.dzeta(i));
       y = model.r(i)*sin(0.5*pi+0.5*model.dzeta(i)+j*model.dzeta(i));
    end
    for k = 1:model.MorrorsNumber_PerCircle(i) 
        if sqrt(x(k)^2+(y(k)+tower.position(2))^2) <= 350
            scatter(x(k),y(k)+tower.position(2));
        end
    end
    clear x y j
end
scatter(0,tower.position(2),300,'pentagram','filled','r');
plot([0,0],[tower.position(2),-350],'LineWidth',2);
text(20,tower.position(2),{'集热塔'},'r')

aplha = 0:pi/40:2*pi;
r = 350;
x = r*cos(aplha);
y = r*sin(aplha);
plot(x,y,'-');

hold off
end