% =====================================================
% @brief Gets each calculation, using jacobi method
% @param A                  matrix waht have input
% @param b                  vector b, used for calculate 
%                       the solution
% @param x0                 Init result vector
% @param Nmax               Maximum iteration count
% @return x_mat             The calculated matrix.
% =====================================================
function x_mat = jacobi_func(A, b, x0, Nmax) 
    x_mat = zeros(size(A, 1), Nmax);
    % A=D-L-U
    D = diag(diag(A));
    L = -tril(A, -1);
    U = -triu(A, 1);
    T = inv(D) * (L + U);
    c = inv(D) * b;

    % init 
    x_mat(:, 1) = x0;
    
    % iteration process
    for (i = 1 : Nmax)
        x_mat(:, i+1) = T * x_mat(:, i) + c;
    end
end