function ef = T2_function(input)

Arlim = input(1);
x=input(2);
y=input(3);
h=input(4);
y0=input(5);
 
Asf = 1;% 此处无遮挡，当然越密集越好
if x > y
ef = 1;
elseif 0.5*y < h
ef = 1;
else
model = CreatModel();
model= T2_Change(Asf,Arlim,x,y,h,y0,model);  
tower = initialization_tower();
tower.position(2) = y0;
ef = -all_morror_efficiency(model,tower); % 此处负数为了方便狼群优化算法找最小值
end
