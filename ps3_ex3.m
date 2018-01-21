%% Problem set 3; problem 3: logit estimation
%% 3.3
% Load data set
filename = 'MRW92QJE-data.xlsx';
sheet = 1;
%[num, txt, raw] = xlsread(filename, sheet);
OECDdummy = xlsread(filename, sheet, 'E2:E122');
gdp85pad = xlsread(filename, sheet, 'G2:G122');
school = xlsread(filename, sheet, 'K2:K122');
X = [OECDdummy, gdp85pad, school];
nrow0 = size(X,1);
% Delete rows with NaN-values
X(any(isnan(X), 2), :) = [];
nrow1 = size(X,1);
diffrow = nrow0 - nrow1;
fprintf( 'N.b.: %g observations deleted due to missing values! \n', diffrow);

%% 3.4
% Dependent variable
t = X(:,1);
% Independent variables
const = ones(nrow1,1);
lgdp85pad = log(X(:,2));
lschool = log(X(:,3)/100);
X = [const, lgdp85pad, lschool];

%% 3.5
beta0 = zeros(3,1);
maxiter = 200;
tol = 0.00001;
% (a) Newton
[beta, iter, t] = mynewton(t, X, beta0, maxiter, tol);

% (b) Broyden's mthod


% (c) Fixed point iteration

% (d)
fun = @ps3ex3foc;
beta = fsolve(fun, beta0);
