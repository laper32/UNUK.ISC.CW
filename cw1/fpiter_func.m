% ==========================================
% @brief Fixed point iteration.
% 
% @param f                  Function handle.
% @param c                  Scalar of f(x)
% @param p0                 Init value.
% @param Nmax               Maximum iteration count.
% ==========================================
function p_vec = fpiter_func(f, c, p0, Nmax)
    % init array.
    p_vec = [];
    % init handle
    g = @(x) x - c * f(x);

    % init def index.
    i = 1;
    while i <= Nmax
        % get next val.
        p = g(p0);
        % joins the vector.
        p_vec=horzcat(p_vec, p);
        % index += 1;
        i = i+1;
        % update
        p0 = p;
    end
end