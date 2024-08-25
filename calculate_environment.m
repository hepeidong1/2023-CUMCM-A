function environment = calculate_environment(Day,ST)
%  ��ʼ������
% alpha_s ̫���߶Ƚ� 
% gamma_s ̫����λ�� 
% delta_s ̫����γ��
% phi_s ����γ��
% omega_s ̫��ʱ��
% ST ����ʱ��
% Day ����
% DNI ����ֱ�ӷ�����ն�
% G0(��)̫������
% H ����
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

