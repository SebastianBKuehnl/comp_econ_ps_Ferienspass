%% Problem set 4, exercise 2
close all
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
linMU = @(W) .5*prob'*R*W;

%% CRRA utility
% Define nonlinear optimal consumption s.t. it constitutes a root-finding
% problem; implicitly defined by Euler equation.
nonlinMU = @(W, C0) ( prob(1)*( ( W*R(1) - C0 )^-gamma) + prob(2)*( ( W*R(2) - C0 )^-gamma) )^-(1/gamma) - C0;

% Plot implicit function C0 of W
fimplicit(nonlinMU, [Wmin Wmax 0 30])

%% Interpolation of quadratic utility using Chebyshev
[coeff1, xhat, yhat1] = chebyshev_approx(linMU, Wmin, Wmax, m, n, 'explicit');
ftilde1 = chebyshev_interpol( xhat, coeff1, Wmin, Wmax, n );

%% Interpolation of CRRA utility using Chebyshev
[coeff2, xhat, yhat2] = chebyshev_approx(nonlinMU, Wmin, Wmax, m, n, 'implicit');
ftilde2 = chebyshev_interpol( xhat, coeff2, Wmin, Wmax, n );