%% Set simulation parameters
dt = 0.01; %Time-step
T = 10; %Final time
long_T = 2*T;
N = T/dt; %Number of steps to final time
%% Set ODE parameters
f = @(t,y) -y.^2; %The function on the rhs of the ODE
y0 = 1; %Initial value
y1 = 1/(1+dt); %Exact value at t_1

y1_euler = FwdEuler(f, y0, 0, dt, dt); %Estimate of y1 using Forward Euler
y1_euler = y1_euler(1); %Take the first element of the estimate
y_rk2 = rk2(0, dt, y0, f, dt); %Estimate of y using RK2
y1_rk2 = y_rk2(1); %Take the first element of the estimate
y_rk3 = rk3(0, dt, y0, f, dt); %Estimate of y using RK3
y1_rk3 = y_rk3(1); %Take the first element of the estimate

%% Run a simulation
[tvec,yvec] = AB2(0,y0,y1,f,dt,N);
[ltvec,lyvec] = AB2(0,y0,y1,f,dt,long_T/dt);
[tvec3, yvec3] = AB3(0, y0, y1_rk3, f, dt, N);
[ltvec3,lyvec3] = AB3(0,y0,y1_rk3,f,dt,long_T/dt);
[tvec_euler,yvec_euler] = AB2(0, y0, y1_euler, f, dt, N);
[tvec_rk2,yvec_rk2] = AB2(0, y0, y1_rk2, f, dt, N);
figure(1);
plot(tvec,yvec)
hold on
plot(tvec_euler,yvec_euler)
plot(tvec_rk2,yvec_rk2)
legend('AB2 Exact','AB2 Fwd Euler', 'AB2 RK2')
xlabel('t')
ylabel('y')
title('AB2 vs Fwd Euler')
hold off

figure(2);
%l2 error
err_euler = zeros(1,10);
err_rk2 = zeros(1,10);
for i = 1:10
    dt = 0.1/(2^i);
    N = T/dt;
    [tvec,yvec] = AB2(0,y0,y1,f,dt,N);
    [tvec_euler,yvec_euler] = AB2(0, y0, y1_euler, f, dt, N);
    [tvec_rk2,yvec_rk2] = AB2(0, y0, y1_rk2, f, dt, N);
    err_euler(i) = sqrt(sum((yvec - yvec_euler).^2));
    err_rk2(i) = sqrt(sum((yvec - yvec_rk2).^2));
end
hold on
% plot the error
loglog(0.1./(2.^(1:10)),err_euler)
loglog(0.1./(2.^(1:10)),err_rk2)
legend('Fwd Euler','RK2')
xlabel('dt')
ylabel('l2 error')
title('l2 error vs dt')
hold off

figure(3);
% AB3 vs AB2
plot(tvec3,yvec3)
legend('AB3')
xlabel('t')
ylabel('y')
title('AB3')
hold off

figure(4);
%l2 error
%l2 error
err_AB2 = zeros(1,long_T);
err_AB3 = zeros(1,long_T);
for i = 1:long_T
    dt = 0.1/(2^i);
    N = T/dt;
    [tvec,yvec] = AB2(0,y0,y1,f,dt,N);
    [tvec_euler,yvec_euler] = AB2(0, y0, y1_euler, f, dt, N);
    [tvec_rk2,yvec_rk2] = AB2(0, y0, y1_rk2, f, dt, N);
    err_AB2(i) = sqrt(sum((yvec - yvec_euler).^2));
    err_AB3(i) = sqrt(sum((yvec - yvec_rk2).^2));
end
hold on
% plot the error
loglog(0.1./(2.^(1:long_T)),err_AB2)
loglog(0.1./(2.^(1:long_T)),err_AB3)
legend('AB2','AB3')
xlabel('dt')
ylabel('l2 error')
title('l2 error vs dt')
hold off