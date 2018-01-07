clear;
%PS2 P1 2.
%get an idea how the function looks like, such that values can be guessed
i=1:300;
g=ffunction(i-40/40);
h=fffunction(i-40);
figure
plot(g);
title('Function 1');
figure
plot(h,'--r');
title('Function 2');
%do bisection
maxiter=20;
e=0.0001;
d=0.0001;
x_l=-5;
x_h=0.7;
fun=@ffunction;
a=mybisection(fun,x_l,x_h,maxiter,e,d);
disp(a)      %-1.6632
x_l=0.01;
x_h=0.7;
b=mybisection(fun,x_l,x_h,maxiter,e,d);
disp(b)      %0.2490
%x_l=0.25;
%x_h=100;
%l=mybisection(fun,x_l,x_h,maxiter,e,d);
%disp(l)    %(error: not opposite signs)
%x_l=-50;
%x_h=-1.7;
%l=mybisection(fun,x_l,x_h,maxiter,e,d);
%disp(l)    %(error: not opposite signs) --> no more zeros
%function 1 has zeros at -1.6632 and 0.2490
%function 2
x_l=0.1;
x_h=100;
fan=@fffunction;
c=mybisection(fan,x_l,x_h,maxiter,e,d);
disp(c)     %1
x_l=0;
x_h=100;
t=mybisection(fan,x_l,x_h,maxiter,e,d);
disp(t)     %0
%x_l=-0.1;
%x_h=-20;
%s=mybisection(fan,x_l,x_h,maxiter,e,d);
%disp(s)    (error: not opposite signs)
%x_l=1.1;
%x_h=100;
%v=mybisection(fan,x_l,x_h,maxiter,e,d);
%disp(v)    (error: not opposite signs)  --> no more zeros
%function 2 has zeros at 0 and 1
