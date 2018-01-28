%PS4P1
clear;
close all;
clc;
%variable declaration
n=5; %number of equidistant nodes
%f(x) is simplef.m
xmin=-1;
xmax=1;

%define function space with fundefn
fspace=fundefn('cheb',n,-1,1);
%create nodes
%also, calculate function values at x
distance=(xmax-xmin)/(n-1);
x=zeros(n,1);
y=zeros(n,1);
z=zeros(n,1);
yy=zeros(n,1);
for i=1:n
  x(i)=xmin+(i-1)*distance; %equidistant nodes
  y(i)=simplef(x(i));       %function values
  z(i)=-cos((2*i-1)*pi/(2*n)); %Chebychev nodes
  yy(i)=simplef(z(i));         %function values
end

%calculate the matrix of basis functions
B=funbas(fspace,x);  %equidistant
Bb=funbas(fspace,z); %Chebychev

%get polynomial coefficients
c=B\y;  %equidistant
cc=Bb\yy; %chebychev

%approximate the function
b=linspace(-1,1,2000); %x-space
b=b';
yap=funeval(c,fspace,b);
yapp=funeval(cc,fspace,b);
yact=zeros(length(b),1); 
for i=1:length(b)
   yact(i)=simplef(b(i));
end

%plots
figure
plot(b,yap-yact,b,yapp-yact,'--r')
xlabel('x')
ylabel('p(x)-f(x)')
title(['Chebychev, n= ', int2str(n)])
legend('equidistant nodes residuals','Chebychev nodes residuals')

figure
plot(b,yap,'.b',b,yapp,'--r',b,yact)
xlabel('x')
ylabel('p(x)-f(x)')
title(['n= ', int2str(n)])
legend('equidistant nodes approx','Chebychev nodes approx','function')


%n=15
n=15; %number of equidistant nodes
%f(x) is simplef.m
xmin=-1;
xmax=1;

%define function space with fundefn
fspace2=fundefn('cheb',n,-1,1);
%create nodes
%also, calculate function values at x
distance2=(xmax-xmin)/(n-1);
x2=zeros(n,1);
y2=zeros(n,1);
z2=zeros(n,1);
yy2=zeros(n,1);
for i=1:n
  x2(i)=xmin+(i-1)*distance2; %equidistant nodes
  y2(i)=simplef(x2(i));       %function values
  z2(i)=-cos((2*i-1)*pi/(2*n)); %Chebychev nodes
  yy2(i)=simplef(z2(i));         %function values
end

%calculate the matrix of basis functions
B2=funbas(fspace2,x2);  %equidistant
Bb2=funbas(fspace2,z2); %Chebychev

%get polynomial coefficients
c2=B2\y2;  %equidistant
cc2=Bb2\yy2; %chebychev

%approximate the function
yap2=funeval(c2,fspace2,b);
yapp2=funeval(cc2,fspace2,b);

%n=150
%variable declaration
n=150; %number of equidistant nodes
%f(x) is simplef.m
xmin=-1;
xmax=1;

%define function space with fundefn
fspace3=fundefn('cheb',n,-1,1);
%create nodes
%also, calculate function values at x
distance3=(xmax-xmin)/(n-1);
x3=zeros(n,1);
y3=zeros(n,1);
z3=zeros(n,1);
yy3=zeros(n,1);
for i=1:n
  x3(i)=xmin+(i-1)*distance3; %equidistant nodes
  y3(i)=simplef(x3(i));       %function values
  z3(i)=-cos((2*i-1)*pi/(2*n)); %Chebychev nodes
  yy3(i)=simplef(z3(i));         %function values
end

%calculate the matrix of basis functions
B3=funbas(fspace3,x3);  %equidistant
Bb3=funbas(fspace3,z3); %Chebychev

%get polynomial coefficients
c3=B3\y3;  %equidistant
cc3=Bb3\yy3; %chebychev

%approximate the function
yap3=funeval(c3,fspace3,b);
yapp3=funeval(cc3,fspace3,b);

%plots compare with same n
figure
plot(b,yap-yact,b,yapp-yact,'--r')
xlabel('x')
ylabel('p(x)-f(x)')
title('Chebychev, n= 5')
legend('equidistant nodes residuals','Chebychev nodes residuals')

figure
plot(b,yap2-yact,b,yapp2-yact,'--r')
xlabel('x')
ylabel('p(x)-f(x)')
title('Chebychev, n= 15')
legend('equidistant nodes residuals','Chebychev nodes residuals')

figure
plot(b,yap3-yact,b,yapp3-yact,'--r')
xlabel('x')
ylabel('p(x)-f(x)')
title('Chebychev, n= 150')
legend('equidistant nodes residuals','Chebychev nodes residuals')


%plots comparison same node method

figure
plot(b,yap-yact,'.b',b,yap2-yact,'--r',b,yap3-yact)
xlabel('x')
ylabel('p(x)-f(x)')
title('equidistant node approximations')
legend('n=5','n=15','n=150')

figure
plot(b,yapp-yact,'.b',b,yapp2-yact,'--r',b,yapp3-yact)
xlabel('x')
ylabel('p(x)-f(x)')
title('Chebychev node approximations')
legend('n=5','n=15','n=150')
