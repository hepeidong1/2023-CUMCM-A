function ef = T2_function(input)

Arlim = input(1);
x=input(2);
y=input(3);
h=input(4);
y0=input(5);
 
Asf = 1;% �˴����ڵ�����ȻԽ�ܼ�Խ��
if x > y
ef = 1;
elseif 0.5*y < h
ef = 1;
else
model = CreatModel();
model= T2_Change(Asf,Arlim,x,y,h,y0,model);  
tower = initialization_tower();
tower.position(2) = y0;
ef = -all_morror_efficiency(model,tower); % �˴�����Ϊ�˷�����Ⱥ�Ż��㷨����Сֵ
end
