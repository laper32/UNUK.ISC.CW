% ===========================================================
% @brief Forward gaussian elimation, but could stop 
% in a specific step.
% 
% @param A                  The matrix n * n+1.
% @param r                  Forward elimiation rounds.
% @param s                  Number of row replacements to be 
%                       done in the last round
% @return                   The resultant vector.
% ===========================================================
function B = forwElimStop_func(A, r, s)
    % declare the size.
    n = size(A, 1);
    m_iCount = 0;
    % r and s is meanless, in fact.
    % we need to construct a formula to know what r and s doing.
    m_iBound = r * (n - 1) + s;

    % process the progress.
    for (i = 1 : n-1)
        % when the count >= the bound, stop
        if (m_iCount >= m_iBound)
            break;
        end

        % j only refer to the element position below the element position on the diagonal.
        for (j = i+1 : n)
            % Compute multiplier
            mij = A (j , i ) / A (i , i ) ;
            % Replace Ej by Ej -mij*Ei
            A (j, i) = 0;
            for k = i+1 : n+1
                A (j , k ) = A (j , k ) - mij * A (i , k ) ;
            end
            
            % when completed a row replacement, counter+=1
            m_iCount = m_iCount + 1;
            
            % then, check, if >= the bound, stop here.
            if (m_iCount >= m_iBound)
                break;
            end
        end
    end
    B = A;
end