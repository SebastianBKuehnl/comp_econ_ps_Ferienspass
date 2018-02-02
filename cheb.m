function [yap,yapp]=cheb(fct,b,n,xmin,xmax)

%define function space with fundefn
fspace=fundefn('cheb',n,xmin,xmax);
%create nodes
%also, calculate function values at x
distance=(xmax-xmin)/(n-1);
x=zeros(n,1);
y=zeros(n,1);
z=zeros(n,1);
yy=zeros(n,1);
for i=1:n
  x(i)=xmin+(i-1)*distance; %equidistant nodes
  y(i)=fct(x(i));           %function values
  z(i)=-cos((2*i-1)*pi/(2*n)); %Chebychev nodes
  yy(i)=fct(z(i));             %function values
end

%calculate the matrix of basis functions
B=funbas(fspace,x);  %equidistant
Bb=funbas(fspace,z); %Chebychev

%get polynomial coefficients
c=B\y;  %equidistant
cc=Bb\yy; %chebychev

%approximate the function
yap=funeval(c,fspace,b);
yapp=funeval(cc,fspace,b);

end