% input: A - trigonometric function matrix (MxN sym)
%        old_str - string matrix
%        new_str - string matrix
% output: A_sym - replace old_str with new_str of A(MxN sym)
function A_sym = sym_mapping(A,old_str,new_str)
    L = length(old_str);
    [M,N] = size(A);
    for i = 1 : M
        for j = 1 : N
            for k = 1 : L
                if k == 1
                    A_sym(i,j)=strrep(char(A(i,j)),old_str(k),new_str(k));
                else 
                    A_sym(i,j)=strrep(A_sym(i,j),old_str(k),new_str(k));
                end
            end
        end
    end
end