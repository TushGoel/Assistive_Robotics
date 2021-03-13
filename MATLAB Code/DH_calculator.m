% Input:(standard DH method table)
% table = [
%     r1,alpha1,d1,theta1;
%     r2,alpha2,d2,theta2;
%     ...
% ]
% Output:
% T =A1*A2*A3*...=[
%     r11,r12,r13,d1;
%     r21,r22,r23,d2;
%     r31,r32,r33,d3;
%     0,0,0,1;
% ]
% Tn{n} = An

function [T,Tn] = DH_calculator(table)
    [N,M] = size(table);
    % acquire parameters
    for i = 1 : N
        a(i) = table(i,1);
        alpha(i) = table(i,2);
        d(i) = table(i,3);
        theta(i) = table(i,4);
    end
    % SDH formula
    syms ax alphax dx thetax real
    Tx = [
        cos(thetax), -sin(thetax)*cos(alphax), sin(thetax)*sin(alphax), ax*cos(thetax);
        sin(thetax), cos(thetax)*cos(alphax), -cos(thetax)*sin(alphax), ax*sin(thetax);
        0, sin(alphax), cos(alphax), dx;
        0, 0, 0 ,1;
    ];
    % Tn(:,:,i) = Ai
    % T = A1*A2*A3*...
    T = eye(4);
    for i = 1 : N 
        Tn(: ,: ,i) = subs(Tx,{ax,alphax,dx,thetax},{a(i),alpha(i),d(i),theta(i)});
        T = T * Tn(:,:,i);
    end
end
