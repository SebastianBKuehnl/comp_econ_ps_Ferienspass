%% Problem set 4, exercise 2
close all;
clear;
% Set parameters
rmin = -0.08;
rmax = 0.12;
p = 0.5;
% CRRA
gamma = 2;
% Grid
Wmin = .5;
Wmax = 50;
% Set number of nodes & order of polynomial
m = 15;
n = 1;

prob = [p 1-p]';
R = [1+rmin 1+rmax]';

%% Quadratic utility
% Define linear optimal consumption 
linMU = @(W) .5*(prob'*R).*W;

%% CRRA utility
% Define nonlinear optimal consumption s.t. it constitutes a root-finding
% problem; implicitly defined by Euler equation.
nonlinMU = @(W, C0) ( prob(1).*( ( W.*R(1) - C0 ).^-gamma) + prob(2).*( ( W.*R(2) - C0 ).^-gamma) ).^-(1./gamma) - C0;

% Plot implicit function C0 of W
fimplicit(nonlinMU, [Wmin Wmax 0 30])

%% Interpolation of quadratic utility using Chebyshev
x=linspace(Wmin,Wmax,1000);
[ylin, ftilde1, yhat1] = chebyshev_approx(linMU, Wmin, Wmax, m, n, 'explicit',x');

%% Interpolation of CRRA utility using Chebyshev
[ynonlin, ftilde2, yhat2] = chebyshev_approx(nonlinMU, Wmin, Wmax, m, n, 'implicit',x');
ynonlin=ynonlin';  %it gives 1X1000 matrix instead of 1000X1 (?!)

%Plot residuals
figure
plot(x',ftilde1-ylin,x',ftilde2-ynonlin,'--r')
xlabel('W')
ylabel('residuals')
legend('linear residuals','nonlinear residuals')
title('Ferienspaﬂ im Semester')

figure
plot(x',ftilde1,x',ftilde2,'--r',x',ylin,'.b',x',ynonlin,':p')
xlabel('W')
ylabel('fcts')
legend('linear aprox','nonlinear approx','lin fct','nonlin fct')
title('Ferienspaﬂ im Semester')

function [yact , yapp, yhat] = chebyshev_approx( fun, a, b, m, n, funtype,x )
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
    %calculate actual values of y for x instead of nodes only
    tmp2 = length(xhat);
    tmpnew=length(x);
    yhat = ones(1,tmp2);
    yhatnew= ones(1,tmpnew);
    for i = 1:tmpnew
       Wnew = x(i);
       myfunnew= @(C0) fun(Wnew,C0);
       x0new=0;
       yact(i)=fzero( myfunnew,x0new);
    end
    for j = 1:tmp2
        W = xhat(j);
        myfun = @(C0) fun(W,C0);
        x0 = 0;
        yhat(j) = fzero( myfun,x0 ); % Rootfinder evaluates C0(W)
    end
else % exlicit optimal consumption function
    yhat = feval( fun, xhat );
    yact = feval( fun, x ); %same here
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

%evaluate approximation at x
s = 0;
for i = 0:n
    temp = ( 2*( x - a ) )/( b - a ) - 1;
    Ti = cos( i*acos( temp ) );
    s = s + coeff(i+1)*Ti;
end
yapp = s;

end