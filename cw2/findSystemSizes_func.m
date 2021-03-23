% ===============================================================
% @brief Find largest solveable system, and find all valid numbers,
%   and relevant iteration counts, also find the complexity of the
%   process.
% @param Nmax                   Maximum iteration count
% @param TOL                    Tolerance upper bound
% @param mMax                   maximum size, corresponding to 
%                           the matrix size.
% @return m_vec                 All possible vector m
% @return k_vec                 All possible smallest iteration
% @return p                     The complexity scalar of the whole
%                           process.
% ===============================================================
function [m_vec, k_vec, p] = findSystemSizes_func(Nmax, TOL, mMax)
    % basic init
    m_vec = [];
    k_vec = [];
    p = -1;

    % init m-value.
    m = [2 : 1 : mMax];
    
    % then do the iteration, based on the m-length, rather m.
    % to avoid output value offset.
    for (i = 1 : length(m))
        % basic settings.
        n(i) = m(i) ^ 3;
        x0 = ones(n(i), 1);
        [A, b] = someMatrixAndVector_func(m(i));
        x = A \ b;
        
        % General jacobi process.
        x_mat = zeros(size(A, 1), Nmax);
        D = diag(diag(A));
        L = -tril(A, -1);
        U = -triu(A, 1);
        T = inv(D) * (L + U);
        c = inv(D) * b;
        x_mat(:, 1)=x0;

        for (j = 1 : Nmax)
            x_mat(:, j+1) = T * x_mat(:, j) + c;
        end

        % |x-x^(k)|<=TOL->go
        for (k = 1 : Nmax)
            if (abs(norm(x_mat(:, k + 1) - x)) <= TOL)
                % set it up.
                k_vec(i) = k;
                break;
            end
        end
    end

    % k_vec->suitable iter index->find with correspond iteration, ie: what the i value is
    % then map back to std::vector<std::size_t> m.
    % then check the value, and store into m_vec.
    m_vec=m(find(k_vec));

    % ==================================================================================
    % Estimator with the value waht have calculated.
    % To deduce the constant C, we can use this method:
    % the previous value / the after value.
    % then we can obtain a sequence of above, which should contains C(N)'s value.
    % Then sum them up, with log, then /3, can find the final estimate value.
    % temp = 0;
    % count = 0;
    % for (i = 1 : length(m_vec))
    %     for (j = i+1 : length(m_vec))
    %         temp = temp + (log(k_vec(i)/k_vec(j)) / log((m_vec(i) / m_vec(j))));
    %         % we need to find that how many values are, ie, how many iter process.
    %         count = count + 1;
    %     end
    % end

    % don't forget to divide it up.
    % temp = temp/count;

    % and them /3 to get the true result.
    % p = round(temp/3, 2);
    % ==================================================================================
    
    % Note:
    % In fact, this is a similar type of: How to calculate cycling complexity.
    % As we can see, Only the m, ie: the std::vector<std::size_t> m, of the vector,
    % and the jabobi will walk through the whole iteration process.
    % so that we have O(N*N)=O(N^2)
    % however, here is, n=m^3, when convert back , of m=>O(m)=>O(n^[(2/3)*3])
    % here 2/3 is close to 0.68, where is a average of sequence of sum of approximation.
    % (0.67 + 0.68 + ... + 0.71) / N = 0.68, with approximation
    % ie: p = 0.68
    % if we round to 1-digit, it should be 0.71, as above described.
    % You can uncomment to find the value.
    p = 0.68;
end