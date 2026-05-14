clc;
clear;
close all;

%% -------------------------------------------------
% 1. Drone Model
% G(s) = 1/(s^2 + 2s + 5)
%% -------------------------------------------------

G = tf(1,[1 2 5]);

figure;
step(G);
title('Open Loop Drone Response');

%% -------------------------------------------------
% 2. Closed Loop Without Controller
%% -------------------------------------------------

T_no_controller = feedback(G,1);

figure;
step(T_no_controller);
title('Closed Loop Response Without Controller');

%% -------------------------------------------------
% 3. PID Controller Design
%% -------------------------------------------------

% Automatic PID tuning

t = 0:0.01:20;
C = pidtune(G,'PID');

disp('PID Controller Parameters:');
C

% Closed loop with PID
T_pid = feedback(C*G,1);

figure;
step(T_pid);
title('Closed Loop Response With PID Controller');


%% -------------------------------------------------
% 4. Performance Metrics Comparison
%% -------------------------------------------------

info_open = stepinfo(G);

info_no_controller = stepinfo(T_no_controller);

info_pid = stepinfo(T_pid);

disp(' ');
disp('========== PERFORMANCE METRICS ==========');

%% Open Loop
disp(' ');
disp('--- OPEN LOOP RESPONSE ---');

fprintf('Rise Time        : %.4f sec\n', info_open.RiseTime);
fprintf('Settling Time    : %.4f sec\n', info_open.SettlingTime);
fprintf('Overshoot        : %.2f %%\n', info_open.Overshoot);
fprintf('Undershoot       : %.2f %%\n', info_open.Undershoot);
fprintf('Peak Value       : %.4f\n', info_open.Peak);
fprintf('Peak Time        : %.4f sec\n', info_open.PeakTime);

%% Closed Loop Without Controller
disp(' ');
disp('--- CLOSED LOOP WITHOUT PID ---');

fprintf('Rise Time        : %.4f sec\n', info_no_controller.RiseTime);
fprintf('Settling Time    : %.4f sec\n', info_no_controller.SettlingTime);
fprintf('Overshoot        : %.2f %%\n', info_no_controller.Overshoot);
fprintf('Undershoot       : %.2f %%\n', info_no_controller.Undershoot);
fprintf('Peak Value       : %.4f\n', info_no_controller.Peak);
fprintf('Peak Time        : %.4f sec\n', info_no_controller.PeakTime);

%% Closed Loop With PID
disp(' ');
disp('--- CLOSED LOOP WITH PID ---');

fprintf('Rise Time        : %.4f sec\n', info_pid.RiseTime);
fprintf('Settling Time    : %.4f sec\n', info_pid.SettlingTime);
fprintf('Overshoot        : %.2f %%\n', info_pid.Overshoot);
fprintf('Undershoot       : %.2f %%\n', info_pid.Undershoot);
fprintf('Peak Value       : %.4f\n', info_pid.Peak);
fprintf('Peak Time        : %.4f sec\n', info_pid.PeakTime);

%% -------------------------------------------------
% 5. Disturbance Rejection Test
% Disturbance applied at t = 5 sec
%% -------------------------------------------------

t = 0:0.01:20;

reference = ones(size(t));   % desired altitude
disturbance = zeros(size(t));
disturbance(t>=5) = -0.5;    % wind disturbance

sys_cl = feedback(C*G,1);

[y,~,x] = lsim(sys_cl,reference+disturbance,t);

figure;
plot(t,y,'LineWidth',2);
hold on;
plot(t,reference,'--');
title('Disturbance Rejection Test');
xlabel('Time (s)');
ylabel('Altitude');
legend('Altitude','Reference');

%% -------------------------------------------------
% 6. SENSOR NOISE TEST (Winning Feature ⭐)
%% -------------------------------------------------

noise = 0.05*randn(size(t));   % sensor noise

noisy_feedback = reference + noise;

[y_noise,~,~] = lsim(sys_cl,noisy_feedback,t);

figure;
plot(t,y_noise,'LineWidth',2);
hold on;
plot(t,reference,'--');
title('System Response with Sensor Noise');
xlabel('Time (s)');
ylabel('Altitude');
legend('Altitude with Noise','Reference');

%% -------------------------------------------------
% 7. Control Effort (Extra Professional Touch)
%% -------------------------------------------------

u = lsim(C, reference - y_noise, t);

figure;
plot(t,u,'LineWidth',2);
title('Control Effort (Thrust Command)');
xlabel('Time (s)');
ylabel('Control Input');

%% -------------------------------------------------
% 8. Comparison Plot
%% -------------------------------------------------

figure;

step(G,'b');
hold on;

step(T_no_controller,'r');

step(T_pid,'g');

grid on;

title('System Comparison');
xlabel('Time (s)');
ylabel('Amplitude');

legend('Open Loop', ...
    'Closed Loop Without PID', ...
    'Closed Loop With PID');