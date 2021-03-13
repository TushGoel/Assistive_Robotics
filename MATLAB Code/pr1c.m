%% DC motor model
R = 2.0; % Ohms
L = 0.5; % Henrys
Km = 0.1; % torque constant
Kb = 0.1; % back emf constant
Kf = 0.2; % Nms
J = 0.02; % kg .m^2/ s ^2
h1 = tf(Km, [L,R]); % armature
h2 = tf(1, [J, Kf]); % eqn of motion
dcm = ss(h2)*[h1,1]; % w = h2 ∗ ( h1∗Va + Td)
dcm = feedback(dcm,Kb,1,1); % close back emf loop
Kff = 1/ dcgain (dcm(1)) % kff = 4. 1
t = 0:0.1:15;
Td = -0.01 * (t>5 & t<10);
u = [ones(size(t)); Td];
c1_ff = dcm * diag([Kff,1]);
c1_ff.InputName = {'w_ref','Td'};
c1_ff.OutputName = 'w';
% plot
h = lsimplot(c1_ff,u,t);
title('Setpoint tracking and disturbance rejection');
legend('c1\_ff');
% Annotate plot
line([5,5],[.2,.3],'HandleVisibility','off');
line([10,10],[.2,.3],'HandleVisibility','off');
text(7.5,.25,{'disturbance','T_d=-0.01Nm'},...
'vertic','middle','horiz','center','color','r');
