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
e=0.0001;
d=0.0001;
x_l=-5;
x_h=0.7;
fun=@ffunction;
a=mybisec(fun,x_l,x_h,e,d);
disp(a)
x_l=0.01;
x_h=0.7;
b=bisec(x_l,x_h,e,fun);
disp(b)
x_l=0.1;
x_h=100;
fan=@fffunction;
c=mybisec(fan,x_l,x_h,e,d);
disp(c)
x_l=0;
x_h=100;
d=bisec(x_l,x_h,e,fun);
disp(d)
