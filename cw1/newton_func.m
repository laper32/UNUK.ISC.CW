% ==============================================
% @brief Calculate the approximation root of a function.
% 
% @param f              The function handle.
% @param dfdx           The derivative of the function f.
% @param p0             Initial point.
% @param Nmax           Maximum iteration count.
% @return               The root value. Stored in as vector.
% ==============================================
function p_vec = newton_func(f, dfdx, p0, Nmax)
    % Dynamic array
    p_vec = [];

    % Init func handle for interate.
    m_fnFunc = @(x) x - f(x)/dfdx(x);

    % Setup default value.
    p_n = p0;
    for (i = 1 : Nmax)
        p_n = m_fnFunc(p0);
        p_vec = horzcat(p_vec, p_n);
        p0=p_n;
    end
end
