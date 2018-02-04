function [coeff, xhat, yhat] = chebyshev_approx( fun, a, b, m, n, funtype )
% function [coeff, xhat, yhat] = chebyshev_approx( fun, a, b, m, n )
% USAGE: Chebychev interpolation 
% INPUT:
%     fun  := function handle, e.g., @exp(-x)
%  [a, b]  := domain on which fun is interpolated
%       m  := nb. of nodes, j = 1,...,m
%       n  := degree of chebyshev polynomial; n.b.: n < m
% funtype  := 'explicit' or 'implicit' function
% OUTPUT:
%   coeff  := Chebyshev coefficients alpha_i, i = 0,...,n
%    xhat  := Chebyshev nodes
%    yhat  := Function values at Chebyshev nodes

%% (0) Initialisation
if n > m
    error( 'Error. It must hold that n < m.' )
end

%% (1) Compute row vector of m Chebyshev nodes in [-1,1]
row = 1:m;
tmp = ( 2*row - 1 )*pi;
zhat = - cos( tmp / (2*m) );

%% (2) Rescale Chebyshev nodes to [a,b]
xhat = a + .5*( b - a )*( zhat + 1 );

%% (3) Evaluate function at Chebyshev nodes
if strcmp(funtype, 'implicit') % implicit optimal consumption function
    % Plug in xhat for W
    tmp2 = length(xhat);
    yhat = ones(1,tmp2);
    for j = 1:tmp2
        W = xhat(j);
        myfun = @(C0) fun(W,C0);
        x0 = 0;
        yhat(j) = fzero( myfun,x0 ); % Rootfinder evaluates C0(W)
    end
else % exlicit optimal consumption function
    yhat = feval( fun, xhat );
end

%% (4) Polynomial coeffs are solution to linear equation Tx*coeff = yhat
% Construct interpolation matrix Tx of size m*(n+1)
Tx = ones(m, n+1); % Returns a vector of ones only if n = 0
if n >= 1          
    Tx(:,2) = xhat';
end
% Recursively define rest of matrix Tx
if n >= 2
    for j = 3:(n+1)
        Tx(:,j) = 2*xhat*Tx(:,j-1) - Tx(:,j-2);
    end
end
% Then, polynomial coefficients are given by
coeff = Tx\yhat';
