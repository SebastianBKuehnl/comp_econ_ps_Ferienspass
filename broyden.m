function [beta, iter, t] = broyden(t, X, beta0, maxiter, tol)
% Broyden's algorithm: Quasi-Newton method using approximated Hessian
% function [beta, iter] = broyden(t, X, beta0, maxiter, tol)

%% (0) Initialise
tic
iter = 0;
beta = beta0;
% Evaluate likelihood equations for first guess
y = sigmoid(X*beta);
grad = X'*(y - t);
% Trivial initial guess for Hessian: I(K)
ncol = size(X,2);
Hess = eye(ncol);
Hess = inv(Hess); % Calculate inverse for first iteration

exit_flag = 0;
%% (1) Compute next iterate
for j = 1:maxiter
    iter = j;
    p = - Hess*grad;
    beta_new = beta + p;
    
    %% (2) Update approximate Hessian
    dbeta = beta_new - beta;
    y = sigmoid(X*beta_new);
    grad_new = X'*(y - t);
    dgrad = grad_new - grad;
    a = dgrad - Hess*dbeta;
    b = dbeta'*dbeta;
    c = a*dbeta';
    Hess = Hess + c/b;
    condition = cond(Hess);
    fprintf( 'The condition number of the Jacobian in iteration %g \n is %.4f \n', iter, condition)
    %% (3) Check stopping criterion
    check = ( norm( p ) <= tol*( 1+norm(beta_new) ) && norm(grad_new) <= tol );
    beta = beta_new;
    if check == 1
        exit_flag = 1; break;
    else                        
        grad = grad_new;
    end
end
%% (4) Report success or failure
if exit_flag == 0
    fprintf( 'Algorithm has not converged after %g iterations\n That is bad luck, my friend! \n', maxiter)
end
toc
t = toc;
