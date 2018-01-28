clear;
clc;
close all;
%PS5P1

%Monte Carlo Quadrature integration
%assume [-1,1]

%first of all, draw random numbers on uniform (-1,1)
a=-1;
b=1;
n1=100;
n2=1000;
n3=10000;
n4=50000;
x1=unifrnd(-1,1,n1,1);
x2=unifrnd(-1,1,n2,1);
x3=unifrnd(-1,1,n3,1);
x4=unifrnd(-1,1,n4,1);

%Polynomial approximation of the functions
%SPLINES for every draw of random numbers do
m1=3;
m2=4;
m3=5;
m4=6;
m5=7;
m=[m1;m2;m3;m4;m5];
ypsilon1=zeros(n1,5,3);
ypsilon2=zeros(n2,5,3);
ypsilon3=zeros(n3,5,3);
ypsilon4=zeros(n4,5,3);
ef1=zeros(5,3);
ef2=zeros(5,3);
ef3=zeros(5,3);
ef4=zeros(5,3);
func={@fivefct1;@fivefct2;@fivefct3};
%for every function and number of nodes do splines
%n=100
for i=1:5
  x1=unifrnd(-1,1,n1,1);
  for j=1:3
    ypsilon1(:,i,j)=spl(func{j},x1,m(i),a,b);
    ef1(i,j)=(b-a)/n1*sum(ypsilon1(:,i,j));
  end
end
%n=1000
for i=1:5
  x2=unifrnd(-1,1,n2,1);
  for j=1:3
    ypsilon2(:,i,j)=spl(func{j},x2,m(i),a,b);
    ef2(i,j)=(b-a)/n2*sum(ypsilon2(:,i,j));
  end
end
%n=10000
for i=1:5
  x3=unifrnd(-1,1,n3,1);
  for j=1:3
    ypsilon3(:,i,j)=spl(func{j},x3,m(i),a,b);
    ef3(i,j)=(b-a)/n3*sum(ypsilon3(:,i,j));
  end
end
%n=50000
for i=1:5
  x4=unifrnd(-1,1,n4,1);
  for j=1:3
    ypsilon4(:,i,j)=spl(func{j},x4,m(i),a,b);
    ef4(i,j)=(b-a)/n4*sum(ypsilon4(:,i,j));
  end
end

%Gaussian Quadrature
[xg1,w1]=lgwt(n1,a,b);
[xg2,w2]=lgwt(n2,a,b);
[xg3,w3]=lgwt(n3,a,b);
%[xg4,w4]=lgwt(n4,a,b);
ypsilong1=zeros(n1,5,3);
ypsilong2=zeros(n2,5,3);
ypsilong3=zeros(n3,5,3);
ypsilong4=zeros(n4,5,3);
efg1=zeros(5,3);
efg2=zeros(5,3);
efg3=zeros(5,3);
efg4=zeros(5,3);
%n=100
for i=1:5
  for j=1:3
    ypsilong1(:,i,j)=spl(func{j},xg1,m(i),a,b);
    efg1(i,j)=(b-a)/n1*sum(ypsilong1(:,i,j).*w1);
  end
end
%n=1000
for i=1:5
  for j=1:3
    ypsilong2(:,i,j)=spl(func{j},xg2,m(i),a,b);
    efg2(i,j)=(b-a)/n2*sum(ypsilong2(:,i,j).*w2);
  end
end
%n=10000
for i=1:5
  for j=1:3
    ypsilong3(:,i,j)=spl(func{j},xg3,m(i),a,b);
    efg3(i,j)=(b-a)/n3*sum(ypsilong3(:,i,j).*w3);
  end
end
%n=50000
%for i=1:5
%  for j=1:3
%    ypsilong4(:,i,j)=spl(func{j},xg4,m(i),a,b);
%    efg4(i,j)=(b-a)/n4*sum(ypsilong4(:,i,j).*w4);
%  end
%end

