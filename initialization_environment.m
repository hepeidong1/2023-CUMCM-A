function environment = initialization_environment()
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
Day = [306,337,0,31,61,92,122,153,184,214,245,275];
ST = [9,10.5,12,13.5,15];
environment(60).phi_s = 0;
environment(60).delta_s = 0;
environment(60).omega_s = 0;
environment(60).alpha_s = 0;
environment(60).gamma_s = 0;
environment(60).DNI = 0;
environment(60).Sr = [0,0,0];
for D = 1:12
   for T = 1:5
       temp = calculate_environment(Day(D),ST(T));
       environment(5*(D-1)+T).phi_s = temp.phi_s;
       environment(5*(D-1)+T).delta_s = temp.delta_s;
       environment(5*(D-1)+T).omega_s = temp.omega_s;
       environment(5*(D-1)+T).alpha_s = temp.alpha_s;
       environment(5*(D-1)+T).gamma_s = temp.gamma_s;
       environment(5*(D-1)+T).DNI = temp.DNI;
       environment(5*(D-1)+T).Sr = [-cos(temp.alpha_s)*sin(temp.gamma_s),-cos(temp.alpha_s)*cos(temp.gamma_s),-sin(temp.alpha_s)];
   end
end
end

