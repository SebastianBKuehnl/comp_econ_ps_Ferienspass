function [beta, iter, t] = fixedpoint( t, X, beta0, maxiter, tol)
% Fixed point iteration <=>: gradient method/ steepest descent
% lambda is not obtained via linesearch but fixed at the beginning
% function [beta, iter] = fixedpoint( t, X, beta0, maxiter, tol, lambda0)

%% (0) Initialise
tic
iter = 0;
beta = beta0;
exit_flag = 0;
lambda = input( 'Please insert a dampening factor lambda: ' );

%% (1) Compute gradient and Hessian, then iterate
for j = 1:maxiter
    iter = j;
    y = sigmoid(X*beta);
    grad = X'*(y - t);
    p = - lambda*grad;
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

        