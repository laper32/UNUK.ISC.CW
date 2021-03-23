% =====================
% @brief Stores approximation results into a vector.
%
% @param f              value on the left.
% @param a              Value on the right.
% @param b              Tolerance
% @param Nmax           Function what we want to use.
% @return               The approximation vector result.
% =====================
function p_vec = bisection_func(f,a,b,Nmax)
    % Similar with what have described above, we need to setup something.
    p_vec = [];

    % do iterator
    for i = 1 : Nmax
        % calculate new value.
        p = (a + b) / 2;
        % follows the algorithm.
        if ( f(a) * f(p) < 0 )
            b = p;
        else
            a = p;
        end
        % horzcat: https://ww2.mathworks.cn/help/matlab/ref/horzcat.html?lang=en
        p_vec = horzcat(p_vec, p);
    end
end