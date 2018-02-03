clear;
clc;
close all;
%PS5P1
%assume [-1,1]
seed=33;
rng(seed);
%Gaussian Quadrature
%use Gauss-Legendere Quadrature, since the RV might not be normal and no
%discounting
xmin=-1;
xmax=1;
n=[100;1000;10000;50000];
f={@fivefct1;@fivefct2;@fivefct3};
nodes=[2;3;4;5;7];
integral=nan(3,5);
for j=1:3  
  for i=1:5
    clear Clear w;
    clear Clear b;
    %get node points and weights for new nodes
    [b,w]=qnwlege(nodes(i),xmin,xmax);
    %evaluate approximated function using chebyshev with chebyshev nodes
    [yap,p,stuff]=cheb(f{j},b,nodes(i),xmin,xmax);   
    integral(j,i)=w'*p;                              %integral value
    clear  Clear p;
  end
end


%Monte Carlo Quadrature integration
%first of all, draw random numbers on uniform [-1,1]
integralm=nan(3,4);
x=zeros(2,1); %for initial comparison
for i=1:4
  %x points for new n as uniformly distributed on [-1,1]  
  if n(i)>length(x)
    clear Clear x;
    x=unifrnd(-1,1,n(i),1);            
  end
  for j=1:3  
    y=f{j}(x); %evaluate function at x
    integralm(j,i)=(xmax-xmin)/n(i)*sum(y);  %integral values
    clear  Clear y;
  end
end
disp(integral);
disp(integralm);