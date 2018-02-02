clear;
clc;
close all;
%PS5P1

%Monte Carlo Quadrature integration
%assume [-1,1]
seed=33;

%first of all, draw random numbers on uniform (-1,1)
a=-1;
b=1;
n=[100;1000;10000;50000];
f={@fivefct1;@fivefct2;@fivefct3};
nodes=[2;3;4;5;7];
integralm=nan(3,4,5);
for j=1:3  
  for i=1:5
      for k=1:4                      
        x=unifrnd(-1,1,n(k),1);        
        [yappp,p]=cheb(f{j},x,nodes(i),a,b);
        integralm(j,i,k)=(b-a)/n(k)*sum(p);
        clear  Clear p;
      end
  end
end   

%Gaussian Quadrature
%use Gauss-Legendere Quadrature, since the RV mght not be normal and no
%discounting
integral=nan(3,4,5);
for j=1:3  
  for i=1:5
      for k=1:4
        anz=n(k);                      %n
        [x,w]=qnwlege(anz,a,b);        %get x points, but dont use w
        [yap,p]=cheb(f{j},x,nodes(i),a,b);   %evaluate approximated function using chebychev nodes, at x --> p   
        integral(j,i,k)=w'*p;
        clear  Clear w;
        clear  Clear p;
      end
  end
end   