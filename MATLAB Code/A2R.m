% Input: homogeneous transform matrix A(4x4 sym)
% Output: rotation matrix R(3x3 sym) and translation matrix d(4x1 sym)
function [R,d] = A2R(A)
    for i = 1 : 3
        for j = 1 : 3
            R(i,j) = A(i,j);
        end
        d(i,:) = A(i,4);
    end
end
