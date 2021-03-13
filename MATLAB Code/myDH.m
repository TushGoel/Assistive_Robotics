% Function:
% convert DH table into a transform matrice
%   note : update the old_str and new_str cells for reducing the matrix
%   before using this function.
% Input:(standard DH method table)
% table = [
%     r1,alpha1,d1,theta1;
%     r2,alpha2,d2,theta2;
%     ...
% ]
% Output:
% T = [
%     r11,r12,r13,d1;
%     r21,r22,r23,d2;
%     r31,r32,r33,d3;
%     0,0,0,1;
% ]
% EX % test data:
% syms theta1 theta2 theta3 theta4 theta5 theta6
% syms a2 a3
% syms d6
% table = [
%     0,pi/2,0,theta1;
%     a2,0,0,-theta2;
%     a3,0,0,-theta3;
%     0,pi/2,0,0;
%     0,pi/2,0,theta4;
%     0,-pi/2,0,theta5;
%     0,0,d6,theta6
% ];
% [T,Tn] =myDH(table)
% Tn{1}

function [T,Tn] = myDH(table)
    % acquire parameters
    N = length(table);
    for i = 1 : N
        a(i) = table(i,1);
        alpha(i) = table(i,2);
        d(i) = table(i,3);
        theta(i) = table(i,4);
    end
    % SDH formula
    syms ax alphax dx thetax
    Tx = [
        cos(thetax), -sin(thetax)*cos(alphax), sin(thetax)*sin(alphax), ax*cos(thetax);
        sin(thetax), cos(thetax)*cos(alphax), -cos(thetax)*sin(alphax), ax*sin(thetax);
        0, sin(alphax), cos(alphax), dx;
        0, 0, 0 ,1;
    ];
    % intermediate matrix
    for i = 1 : N 
        Tn{i} = subs(Tx,{ax,alphax,dx,thetax},{a(i),alpha(i),d(i),theta(i)});
    end
    % resulted matrix
    T_result = eye(4);
    for i = 1 : N
        T_result = T_result * Tn{i};
    end
    % simplification
    T_result=simplify(T_result);
    old_str = {
        'sin(theta1)','sin(theta2)','sin(theta3)','sin(theta4)','sin(theta5)','sin(theta6)',...
        'cos(theta1)','cos(theta2)','cos(theta3)','cos(theta4)','cos(theta5)','cos(theta6)'
    };
    new_str = {
        's1','s2','s3','s4','s5','s6',...
        'c1','c2','c3','c4','c5','c6',
    };

    r11 = char(T_result(1,1));
    r12 = char(T_result(1,2));
    r13 = char(T_result(1,3));
    d1 = char(T_result(1,4));
    r21 = char(T_result(2,1));
    r22 = char(T_result(2,2));
    r23 = char(T_result(2,3));
    d2 = char(T_result(2,4));
    r31 = char(T_result(3,1));
    r32 = char(T_result(3,2));
    r33 = char(T_result(3,3));
    d3 = char(T_result(3,4));
    for i = 1 : length(old_str)
        r11 = strrep(r11,old_str{i},new_str{i});
        r12 = strrep(r12,old_str{i},new_str{i});
        r13 = strrep(r13,old_str{i},new_str{i});
        d1 = strrep(d1,old_str{i},new_str{i});
        r21 = strrep(r21,old_str{i},new_str{i});
        r22 = strrep(r22,old_str{i},new_str{i});
        r23 = strrep(r23,old_str{i},new_str{i});
        d2 = strrep(d2,old_str{i},new_str{i});
        r31 = strrep(r31,old_str{i},new_str{i});
        r32 = strrep(r32,old_str{i},new_str{i});
        r33 = strrep(r33,old_str{i},new_str{i});
        d3 = strrep(d3,old_str{i},new_str{i});
    end
    % return value
    T = {
        r11,r12,r13,d1;
        r21,r22,r23,d2;
        r31,r32,r33,d3;
        0,0,0,1
    };
    T = string(T);
end

