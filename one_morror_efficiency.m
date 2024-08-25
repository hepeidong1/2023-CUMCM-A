function eta = one_morror_efficiency(x,y,z,size,environment,tower)
% 计算每个镜子所能提供的功率


% 遮挡效率
% eta_sb = 1; % 无遮挡

% 余弦效率
Sr = environment.Sr;
Sf = [-x,-y,tower.H_pole-z];
Sf = [-x,-y,tower.H_pole-z]/norm(Sf);
eta_cos = sqrt((1-Sr*Sf')/2);

% 大气透射率
d_HR = sqrt((tower.H_pole+0.5*tower.H_absorb-z)^2+(x-tower.position(1))^2+(y-tower.position(2))^2);
eta_at = 0.99321-0.0001176*d_HR+1.97*10^(-8)*d_HR^2;

% 集热器截断效率
% sun = 2.51; % 太阳形状标准差
% s = 0.94; % 斜率误差标准差 定日镜光学测试结果呈椭圆高斯分布
% bp = (2*s)^2; % 光束质量误差标准差
w = acos(dot(Sr,Sf)/(norm(Sr)*norm(Sf)));
D = sqrt(size(1)^2+size(2)^2); % 3.8
Ht = D*abs(1-cos(w)); % 原文中 dhr = f 即焦点为吸收点
Ws = D*abs(1-cos(w));
ast = sqrt(0.5*(Ht^2+Ws^2))/(4*d_HR);% 像散误差标准差
% t = 0.63; % 跟踪误差标准差
tot = sqrt(d_HR^2*(ast^2+19.1890));
% % tot = sqrt(d_HR^2*(sun^2+bp^2+ast^2+t^2));
% tic
% syms xx yy
% zz = exp(-xx^2-yy^2)/(2*tot^2);
% eta_trunc = (1/(2*pi*tot^2))/double(int(int(zz,yy,0,size(2)),xx,0,size(1)));
% toc
% % 上个式子计算过程太复杂，随机数法计算
% loop_dim = 100;
% loop_x = size(1)*rand(1,loop_dim);
% loop_y = size(2)*rand(1,loop_dim);
% % gpu_loop_x = gpuArray(loop_x);
% % gpu_loop_y = gpuArray(loop_y);
% zz = size(1)*size(2)*mean(exp(-(loop_x.^2+loop_y.^2)).^(1/(2*tot^2)));
% eta_trunc = zz/(2*pi*tot^2);
clear xx yy
fun = @(xx,yy)exp(-xx.^2-yy.^2)/(2*tot^2);
x_range = [0,size(1)];
y_range = [0,size(2)];
eta_trunc = (1/(2*pi*tot^2))/integral2(fun,x_range(1),x_range(2),y_range(1),y_range(2));


% 镜面反射率
% eta_ref = 0.92;
% eta = eta_sb*eta_cos*eta_at*eta_trunc*eta_ref;
eta = eta_cos*eta_at*eta_trunc*0.92;
end

