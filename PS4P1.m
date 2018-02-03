%PS4P1
clear;
close all;
clc;

%Chebychev

%variable declaration
n1=5;  %number of nodes
n2=15;
n3=150;
%f(x) is simplef.m
f=@simplef;
xmin=-1;
xmax=1;
b=linspace(xmin,xmax,2000); %x-space
b=b';

[yapequi,yapchebsli,yapcheblec]=cheb(f,b,n1,xmin,xmax);
[yapequi2,yapchebsli2,yapcheblec2]=cheb(f,b,n2,xmin,xmax);
[yapequi3,yapchebsli3,yapcheblec3]=cheb(f,b,n3,xmin,xmax);


%SPLINES equidistant nodes
[yapspllin,yapsplcub]=spl(f,b,n1,xmin,xmax);
[yapspllin2,yapsplcub2]=spl(f,b,n2,xmin,xmax);
[yapspllin3,yapsplcub3]=spl(f,b,n3,xmin,xmax);

%actual function
yact=simplef(b);


%plots compare with same n
figure
plot(b,yapequi-yact,b,yapchebsli-yact,'--r',b,yapspllin,'.b')
line([-1, 1],[0, 0],'color','black')
xlabel('x')
ylabel('p(x)-f(x) residuals')
title('n= 5')
legend('Chebychev, equidistant nodes','Chebychev, Chebychev nodes','Linear splines')

figure
plot(b,yapequi2-yact,b,yapchebsli2-yact,'--r',b,yapspllin2,'.b')
xlabel('x')
ylabel('p(x)-f(x) residuals')
title('n= 15')
legend('Chebychev, equidistant nodes','Chebychev, Chebychev nodes','Linear splines')

figure
plot(b,yapequi3-yact,b,yapchebsli3-yact,'--r',b,yapspllin3,'.b')
xlabel('x')
ylabel('p(x)-f(x) residuals')
title('n= 150')
legend('Chebychev. equidistant nodes','Chebychev, Chebychev nodes','Linear splines')


%plots comparison same node method (no cheb lecture and no cubic splines)

figure
plot(b,yapequi-yact,'.b',b,yapequi2-yact,'--r',b,yapequi3-yact)
xlabel('x')
ylabel('p(x)-f(x)')
title('Chebychev, equidistant node approximations')
legend('n=5','n=15','n=150')

figure
plot(b,yapchebsli-yact,'.b',b,yapchebsli2-yact,'--r',b,yapchebsli3-yact)
xlabel('x')
ylabel('p(x)-f(x)')
title('Chebychev, Chebychev node approximations')
legend('n=5','n=15','n=150')

figure
plot(b,yapspllin-yact,'.b',b,yapspllin2-yact,'--r',b,yapspllin3-yact)
xlabel('x')
ylabel('p(x)-f(x)')
title('Linear splines, equidistant node approximations')
legend('n=5','n=15','n=150')


%compare linear splines and cubic splines

%plots compare with same n

figure
plot(b,yapspllin-yact,b,yapsplcub-yact,'--r')
line([-1, 1],[0, 0],'color','black')
xlabel('x')
ylabel('p(x)-f(x) residuals')
title('Splines, n= 5')
legend('linear','cubic')

figure
plot(b,yapspllin2-yact,b,yapsplcub2-yact)
xlabel('x')
ylabel('p(x)-f(x) residuals')
title('Splines, n= 15')
legend('linear','cubic')

figure
plot(b,yapspllin3-yact,b,yapsplcub3-yact,'--r')
xlabel('x')
ylabel('p(x)-f(x) residuals')
title('Splines, n= 150')
legend('linear','cubic')

%compare slides and lecture

%plots compare with same n
figure
plot(b,yapcheblec-yact,b,yapchebsli-yact,'--r')
line([-1, 1],[0, 0],'color','black')
xlabel('x')
ylabel('p(x)-f(x) residuals')
title('Chebychev, Chebychev nodes, n= 5')
legend('Lecture','Slides')

figure
plot(b,yapcheblec2-yact,b,yapchebsli2-yact,'--r')
xlabel('x')
ylabel('p(x)-f(x) residuals')
title('Chebychev, Chebychev nodes, n= 15')
legend('Lecture','Slides')

figure
plot(b,yapcheblec3-yact,b,yapchebsli3-yact,'--r')
xlabel('x')
ylabel('p(x)-f(x) residuals')
title('Chebychev, Chebychev nodes, n= 150')
legend('Lecture','Slides')
