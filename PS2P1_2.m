clear;
%PS2 P1 2.
%get an idea how the function looks like, such that values can be guessed
i=1:300;
g=ffunction(i-40/40);
h=fffunction(i-40);
plot(g);
hold on
plot(h,'--r');
hold off
%do bisection
e=0.0001;
d=0.0001;
x_l=-5;
x_h=0.7;
fun=@ffunction;
a=bisec(x_l,x_h,e,fun);
x_l=0.01;
x_h=0.7;
b=bisec(x_l,x_h,e,fun);
x_l=0.1;
x_h=100;
fun=@fffunction;
c=bisec(x_l,x_h,e,fun);
x_l=0;
x_h=100;
fun=@fffunction;
d=bisec(x_l,x_h,e,fun);
disp(a)
disp(b)
disp(c)
disp(d)


