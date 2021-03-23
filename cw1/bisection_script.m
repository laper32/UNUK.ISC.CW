% M-file bisection_script.m

% Define f
f = @(x) x.^3 + x.^2 - 2*x - 2;
x = linspace(-1, 1, 0.1);
% Plot of f
fplot(f);

% Bisection algorithm
a = 1;
b = 2;
e = 10e-16;
% continue further here...
bisection(a, b, e, f);

% =====================
% We need to write some functions to help us to check what value
% approximately converges to.
% @param a             value on the left.
% @param b             Value on the right.
% @param e             Tolerance
% @param f             Function what we want to use.
% =====================
function bisection(a, b, e, f)
    % First, we need to set up something. ie: step, to count the iter
    % count.
    m_iStep = 1;
    fprintf('\nBisection method implementation: ');
    
    % using while (true) to help us iter.
    % when caught the tolerance ub, stop immediately.
    m_bAllowed = true;
    while (m_bAllowed)
        % presudocode has described the algorithm.
        p = (a + b) / 2;
        fprintf('Iteration: %2d, p = %.6f and f(p) = %3.16f\n', m_iStep, p, f(p));
        
        % In C/C++/some languages which supports '?' operator,
        % we can use something syntax below what have described:
        % ( f(a) * f(b) < 0 ) ? b = p : a = p;
        if ( f(a) * f(p) < 0 )
            b = p;
        else
            a = p;
        end
        % counter+=1;
        m_iStep = m_iStep + 1;
        % does the f(p) > tolerance?
        % will be false if abs(f(p)) <= e
        m_bAllowed = abs(f(p)) > e;
    end
    
    % Okay, let's output the result.
    fprintf('\nResult: %.8f', p);
end

