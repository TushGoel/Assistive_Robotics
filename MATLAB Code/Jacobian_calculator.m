% input: joint_type - 0 revolute 1 primistic (1xN matrix)
%           A -  transform matrix (4x4xN sym)
% output: J - Jacobian matrix(6xN sym)
%         Ri0 - R_i^0 transform matrix (3x3xN sym)
%         oi0 - O_i^0 tranlation vector(1x3xN sym)
function [J,Ai0,Ri0,oi0] = Jacobian_calculator(joint_type,A)
    [L,M,N] = size(A);
    % calculate Rio, oi0
    for i = 1 : N
        R(:,:,i) = A2R(A(:,:,i));
        if i == 1
            Ai0(:,:,i)=A(:,:,i);
        else
            Ai0(:,:,i)=Ai0(:,:,i-1)*A(:,:,i);
        end
        [Ri0(:,:,i),oi0(:,:,i)] = A2R(Ai0(:,:,i));
    end
    % calculate J
    for i = 1 : N
        if joint_type(i) == 1
            if i == 1
                Jv = eye(3) * [0;0;1];
                Jw = [0;0;0];
            else
                Jv = Ri0(:,:,i-1) * [0;0;1];
                Jw = [0;0;0];
            end
        else
            if i ==1
                Jv = cross(eye(3) * [0;0;1],oi0(:,:,N));
                Jw = eye(3) * [0;0;1];
            else
                Jv = cross(Ri0(:,:,i-1) * [0;0;1],oi0(:,:,N)-oi0(i-1));
                Jw = Ri0(:,:,i-1) * [0;0;1];
            end
        end
        J(:,i) = [Jv;Jw];
    end
        
end