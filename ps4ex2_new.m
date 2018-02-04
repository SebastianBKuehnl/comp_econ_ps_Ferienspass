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
[ylin, ftilde1, yhat1] = chebyshev_approx(linMU, Wmin, Wmax, m, n, 'explicit', x');

%% Interpolation of CRRA utility using Chebyshev
[ynonlin, ftilde2, yhat2] = chebyshev_approx(nonlinMU, Wmin, Wmax, m, n, 'implicit', x');
ynonlin=ynonlin';  % it gives 1X1000 matrix instead of 1000X1 (?!)

%% Plot residuals
figure(1)
plot(x',ftilde1-ylin,x',ftilde2-ynonlin,'--r')
xlabel('W')
ylabel('residuals')
legend('linear residuals','nonlinear residuals')
title('Approximation errors: Quadratic vs. CRRA. Baseline')
% Accuracy
acclin = max(abs(ftilde1-ylin));
fprintf( 'Approximation error*e+13 for quadratic utility: %.4f \n', acclin*10^13)
accnonlin = max(abs(ftilde2-ynonlin));
fprintf( 'Approximation error*e+13 for CRRA utility: %.4f \n', accnonlin*10^13)
% Maximum percentage deviation
maxdev = max(abs(ynonlin - ylin)./ylin);
fprintf(  'The maximum percentage deviation is %.2f percent \n', maxdev*100)

figure(2)
plot(x',ftilde1,x',ftilde2,'--r',x',ylin,'.b',x',ynonlin,':p')
xlabel('W')
ylabel('fcts')
legend('linear aprox','nonlinear approx','lin fct','nonlin fct')
title('Chebyshev approximation: Quadratic vs. CRRA. Baseline')

% What happens if setting is changed?
%% (i) Increase in gamma
gamma = 4;
nonlinMUgg = @(W, C0) ( prob(1).*( ( W.*R(1) - C0 ).^-gamma) + prob(2).*( ( W.*R(2) - C0 ).^-gamma) ).^-(1./gamma) - C0;
[ynonlingg, ftilde2gg, yhat2gg] = chebyshev_approx(nonlinMUgg, Wmin, Wmax, m, n, 'implicit', x');
ynonlingg=ynonlingg';

% Accuracy
accnonlin = max(abs(ftilde2gg-ynonlingg));
fprintf( '(i) Increase in gamma. For example, set gamma = %.2f \n', gamma)
fprintf( 'Approximation error*e+13 for CRRA utility: %.4f \n', accnonlin*10^13)
% Maximum percentage deviation
maxdev = max(abs(ynonlingg - ylin)./ylin);
fprintf(  'The maximum percentage deviation is %.2f percent \n', maxdev*100)

%% (ii) Decrease in p
gamma = 2;
p = 0.2;
prob = [p 1-p]';
nonlinMUpp = @(W, C0) ( prob(1).*( ( W.*R(1) - C0 ).^-gamma) + prob(2).*( ( W.*R(2) - C0 ).^-gamma) ).^-(1./gamma) - C0;
[ynonlinpp, ftilde2pp, yhat2pp] = chebyshev_approx(nonlinMUpp, Wmin, Wmax, m, n, 'implicit', x');
ynonlinpp=ynonlinpp';

% Accuracy
accnonlin = max(abs(ftilde2pp-ynonlinpp));
fprintf( '(ii) Decrease in p. For example, set p = %.2f \n', p)
fprintf( 'Approximation error*e+13 for CRRA utility: %.4f \n', accnonlin*10^13)
% Maximum percentage deviation
maxdev = max(abs(ynonlinpp - ylin)./ylin);
fprintf(  'The maximum percentage deviation is %.2f percent \n', maxdev*100)


%% (iii) Increase spread
p = 0.5;
prob = [p 1-p]';
inc = 0.2;
rmin = rmin - inc;
rmax = rmax + inc;
R = [1+rmin 1+rmax]';
nonlinMUsp = @(W, C0) ( prob(1).*( ( W.*R(1) - C0 ).^-gamma) + prob(2).*( ( W.*R(2) - C0 ).^-gamma) ).^-(1./gamma) - C0;
[ynonlinsp, ftilde2sp, yhat2sp] = chebyshev_approx(nonlinMUsp, Wmin, Wmax, m, n, 'implicit', x');
ynonlinsp=ynonlinsp';

% Accuracy
accnonlin = max(abs(ftilde2sp-ynonlinsp));
fprintf( '(iii) Change spread by +/- inc. For example, spread increase = %.2f \n', 2*inc)
fprintf( 'Maximum absolute error*e+13 for CRRA utility: %.4f \n', accnonlin*10^13)
% Maximum percentage deviation
maxdev = max(abs(ynonlinsp - ylin)./ylin);
fprintf(  'The maximum percentage deviation is %.2f percent \n', maxdev*100)

function [yact, yapp, yhat] = chebyshev_approx( fun, a, b, m, n, funtype, x)
% [yact, yapp, yhat] = chebyshev_approx( fun, a, b, m, n, funtype, x)
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
    % Calculate actual values of y for x instead of nodes only
    tmp2 = length(xhat);
    tmp3 = length(x);
    yhat = ones(1,tmp2);
    yact = ones(1,tmp3);
    for i = 1:tmp3
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

%% Evaluate approximation yapp for larger x
tmp4 = length(x);
Txnew = ones(tmp4, n+1); % Returns a vector of ones only if n = 0
if n >= 1          
    Txnew(:,2) = x';
end
% Recursively define rest of matrix Tx
if n >= 2
    for j = 3:(n+1)
        Txnew(:,j) = 2*x*Txnew(:,j-1) - Txnew(:,j-2);
    end
end
yapp = Txnew*coeff;

end