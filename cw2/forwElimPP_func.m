% ==========================================================
% Forward Gaussian elimation, with partial pivoting.
% @param A                  The matrix n*4 what have input.
% @return                   Matrix with echelon form.
% ==========================================================
function B = forwElimPP_func(A)
    n = size(A, 1);
    % First of all, we need to find th emaximum row index.
    [~, idx] = max(A);

    % Partial pivoting...
    for (i = 1 : n-1)
        % Gets the current row what we calculating...
        operating_row = A(i, :);

        % We have knwon the maximum index of maximum val of row of index.
        % Then, override with that row.
        A(i, :) = A(idx(i), :);

        % In this term, set back of that original row what we have been overrided.
        A(idx(i), :) = operating_row;
    end

    % Now, do forward elimation
    for i = 1 : n-1
        % Eliminate column i
        for j = i +1: n
            % Compute multiplier
            m_flOverrideCoeffiecient = A (j , i ) / A (i , i ) ;
            % Replace Ej by Ej -mij*Ei
            A(j, i) = 0;
            for k = i+1 : n+1
                A(j, k) = A(j, k) - m_flOverrideCoeffiecient * A(i, k);
            end
        end
    end
    
    B = A;
end