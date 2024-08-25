function environment = calculate_environment(Day,ST)
%  初始化环境
% alpha_s 太阳高度角 
% gamma_s 太阳方位角 
% delta_s 太阳赤纬角
% phi_s 当地纬度
% omega_s 太阳时角
% ST 当地时间
% Day 日期
% DNI 法向直接辐射辐照度
% G0(零)太阳常数
% H 海拔
H = 3;
G0 = 1.366;
environment.phi_s = 39.4*pi/180;
environment.delta_s = asin(sin(2*pi*Day/365)*sin(2*pi*23.45/365));
environment.omega_s = pi*(ST-12)/12;
environment.alpha_s = asin(cos(environment.delta_s)*cos(environment.phi_s)*cos(environment.omega_s)+sin(environment.delta_s)*sin(environment.phi_s));
environment.gamma_s = real(acos((sin(environment.delta_s)-sin(environment.alpha_s)*sin(environment.phi_s))/(cos(environment.alpha_s)*cos(environment.phi_s))));
a = 0.4237-0.00821*(6-H)^2;
b = 0.5055+0.00595*(6.5-H)^2;
c = 0.2711+0.01858*(2.5-H)^2;
environment.DNI = G0*(a+b*exp(-c/sin(environment.alpha_s)));

end

