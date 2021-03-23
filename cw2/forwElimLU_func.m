% ====================================================
% @brief Execute LU decomposition.
% 
% @param A              The original matrix A.
% @return L             The lower triangle matrix.
% @return U             The upper triangle matrix.
% ====================================================
function [L, U] = forwElimLU_func(A)
    % Gets the size of the matrix.
    n = size(A, 1);
    % Init diagonal matrix, to lower triangle matrix.
    L = eye(n);
    
    % Note: looks like i = 1 : n && i = 1 : n-1 doesn't affect anything.....
    for i = 1 : n-1
        % when the diagonal of the original matrix encounters nearly to 0,
        % we stop here.
        if abs(A(i, i) < 10e-8)
            % stop the iteration, and quit the loop.
            break;
        end
        % from notes, we could know that lower triangle is the factor of the elimination
        % coefficients.
        % So that we can store it directly.
        % Of course we can also write a template variable here.....
        L(i+1 : n, i) = A(i+1:n, i) / A(i, i);
        
        for j = i+1: n
            % fprintf("L(j = %d, i = %d) = %d\n",j, i, L(j, i));
            % First round: i = 1; 
            %               j = 2 : 3 // goes 1 time
            % then, obviously, iterate lower triangle, we could use it directly, 
            % to calculate upper triangle.
            A(j,:)=A(j,:)-L(j,i)*A(i,:);
        end
    end
    % Don't forget to set U=A, where A is calculated.
    U = A;
end