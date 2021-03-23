% ==========================================
% We need to write some functions to help us to check what value
% approximately converges to.
% @param a             value on the left.
% @param b             Value on the right.
% @param e             Tolerance
% @param f             Function what we want to use.
% ==========================================
function p_vec = bisectionStop_func(f, a, b, Nmax, TOL)
    % Array init
    p_vec = [];
    
    % Iterate
    for i = 1 : Nmax
        p_vec(i) = (a + b) / 2;
        % We need to make sure that the abs detection index must >= 2,
        % in order to avoid OOB.
        if (i >= 2 && abs(p_vec(i) - p_vec(i-1)) < TOL)
            break;
        else
            % Follows algorithm
            if ( f(a) * f(p_vec(i)) < 0 )
                % We are now using p_vec to store val,
                % so that we using p_vec(i) for override.
                b = p_vec(i);
            else
                a = p_vec(i);
            end
        end
    end
end