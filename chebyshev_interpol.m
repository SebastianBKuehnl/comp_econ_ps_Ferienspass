function px = chebyshev_interpol( x, coeff, a, b, n )
% USAGE: Computes Chebyshev interpolant
% INPUT:
%     coeff := n+1 Chebyshev coefficients alpha_i from approximation
%     [a,b] := domain on which function is interpolated
%         n := degree of the polynomial, i = 0,...,n
% OUTPUT:
%        px := value of polynomial approximation evaluated at x

s = 0;
for i = 0:n
    temp = ( 2*( x - a ) )/( b - a ) - 1;
    Ti = cos( i*acos( temp ) );
    s = s + coeff(i+1)*Ti;
end
px = s;