function [beta, iter, t] = mynewton( t, X, beta0, maxiter, tol )
% Newton's method: algorithm using exact Hessian
% function [beta, iter] = newton(t, X, beta0, maxiter, tol)

%% (0) Initialise
tic
iter = 0;
beta = beta0;
exit_flag = 0;

%% (1) Compute gradient and Hessian, then iterate
for j = 1:maxiter
    iter = j;
    y = sigmoid(X*beta);
    grad = X'*(y - t);
    h1 = y.*(1-y);
    R = diag(h1);
    Hess = X'*R*X;
    iHess = inv(Hess);
    p = - iHess*grad;
    % For clarity, display iteration steps:
    fprintf( 'Step made in iteration %g: \n', iter )
    p'
    beta_new = beta + p;
    %% (2) Check stopping criterion
    check = ( norm( p ) <= tol*( 1+norm(beta_new) ) && norm(grad) <= tol );
    if check == 1       
        exit_flag = 1; break;
    else
        beta = beta_new;
    end
end
%% (3) Report success or failure
if exit_flag == 0
    fprintf( 'Algorithm has not converged after %g iterations\n That is bad luck, my friend!\n', maxiter)
end
toc
t = toc;