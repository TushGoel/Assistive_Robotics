clear
%% declare symbol variables %%
syms theta1 theta2 theta3 theta4 theta5 theta6 real
syms a1 a2 a3 a4 a5 a6 real
syms d1 d2 d3 d4 d5 d6 real
%% SDH table %%
% r alpha d theta %
table = [
    0,-pi/2,0,theta1;
    0,pi/2,d2,theta2;
    0,0,d3,0;
    0,-pi/2,0,theta4;
    0,pi/2,0,theta5;
    0,0,d6,theta6
];
%% calculate An and T %%
[T,Tn] = DH_calculator(table);

%% convert Ai to Ri,di %%
[N,M] = size(table);
for i = 1 : N
    [R(:,:,i),d(:,:,i)] = A2R(Tn(:,:,i));
end
%% calculate Jacobian matrix %%
joint_type = [0,0,1,0,0,0];
[J,Ai0,Ri0,oi0]=Jacobian_calculator(joint_type,Tn);
%% symbols mapping %%
old_str = [
    "sin(theta1)","sin(theta2)","sin(theta3)","sin(theta4)","sin(theta5)","sin(theta6)",...
    "cos(theta1)","cos(theta2)","cos(theta3)","cos(theta4)","cos(theta5)","cos(theta6)",...
    "a1","a2","a3","a4","a5","a6",...
    "d1","d2","d3","d4","d5","d6",...
    "*",...
    ];
new_str = [
    "s_1","s_2","s_3","s_4","s_5","s_6",...
    "c_1","c_2","c_3","c_4","c_5","c_6",...
    "a_1","a_2","a_3","a_4","a_5","a_6",...
    "d_1","d_2","d_3","d_4","d_5","d_6",...
    "",...
];

for i = 1 : N
    % Result: Ai
    Tn_sym(:,:,i)= sym_mapping(Tn(:,:,i),old_str,new_str);
    % Result: R_i^0
    Ri0_sym(:,:,i) = sym_mapping(Ri0(:,:,i),old_str,new_str);
    % Result: o_i^0
    oi0_sym(:,:,i) = sym_mapping(oi0(:,:,i),old_str,new_str);
end 
% Result: T
T_sym = sym_mapping(simplify(T),old_str,new_str);
%  Result: J
J_sym = sym_mapping(simplify(J),old_str,new_str);
