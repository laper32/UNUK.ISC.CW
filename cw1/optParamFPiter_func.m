% ===========================================================
% @brief Optimize the fixpoint iter scalar c.
% 
% @param f          Function handle.
% @param p0         Init point p0.
% @param p          The exact result.
% @param TOL        Tolerance.
% @param Nmax       Maximum iterate count.
% 
% @return c_opt     The suitable c array.
% @return N_opt     The minimun iter count.
% ===========================================================
function [c_opt, N_opt] = optParamFPiter_func(f, p0, p, TOL, Nmax)
    % Initial interval.
    m_pInterval = linspace(10 ^ (-3), 1, 1000);

    % Calculate the sizeof
    m_nSize     = length(m_pInterval);

    % Init result matrix.
    m_pResult   = zeros(m_nSize,    3);

    % we need to store default value.
    m_DefaultVal = p0;
    for (i = 1 : m_nSize)
        % Here to make sure that when we walk through a loop, 
        % will always initalize with p0, ie: no override.
        p0 = m_DefaultVal;
        % Init handle.
        g = @(x) x - m_pInterval(i) * f(x);
        % iter with specific function.
        for (j = 1 : Nmax)
            % Get next val.
            p1 = g(p0);
            
            % Write result.
            if (abs(p1 - p) < TOL)
                m_pResult(i, 1)     = p1;
                m_pResult(i, 2)     = j;
                m_pResult(i, 3)     = m_pInterval(i);
                break;
            else
                % Update.
                p0 = p1;
            end
        end
    end
    % Setup template matrix, for the last identification.
    m_pTempMatrix = m_pResult;
    % Clear all empty array, ie: (0, ..., 0)
    m_pTempMatrix(all(m_pTempMatrix==0,2),:)=[];
    % Find the minimum value.
    N_opt = min(m_pTempMatrix(:,2));
    % Find its index.
    [m_nResultIndex, ~] = find(m_pTempMatrix == N_opt);

    % Get the index array sizeof
    m_nResultIndexSize = length(m_nResultIndex);

    % Init vector.
    c_opt = zeros(m_nResultIndexSize, 1);
    
    % Write result.
    for i = 1 : m_nResultIndexSize
        c_opt(i) = m_pTempMatrix(m_nResultIndex(i), 3);
    end
end