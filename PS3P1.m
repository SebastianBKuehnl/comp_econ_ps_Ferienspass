clear;
clc;
close all;
%PS3 Problem 1
%Simple Functions

%Newton returns the root of a function
%To find extrema, use Newton of the derivative of the functions f1 and f2

%Parameter declaration
epsilon=0.001;
delta=0.001;
maxiterations= 25;
%how do the functions look like?
v=-20:20;
y=f1(v);
figure
plot(v,y)  %--> somewhere around 0
x_s1=0;
y2=f2(v);
figure
plot(v,y2) %--> converges to 0 from above (try 20)
x_s2=20;
funct=@df1;
%apply Newton on df1
[extremum_x,sol]=Newton(funct,x_s1,epsilon,delta,maxiterations);
extremum_y=f1(extremum_x);
if sol==true
    disp(['S(x,f1(x)) = (',int2str(extremum_x),'/',int2str(extremum_y),')'])
end
%apply Newton on df2
functi=@df2;
[extremum_x2,sol]=Newton(functi,x_s2,epsilon,delta,maxiterations);
extremum_y2=f2(extremum_x2);
if sol==true
    disp(['S(x,f2(x)) = (',int2str(extremum_x2),'/',int2str(extremum_y2),')'])
end
%apply Newton_opt on f1
%i=1;
funct=@f1;
x_s1=10;
[extremum_x,sol]=Newton_opt(funct,x_s1,epsilon,delta,maxiterations);
extremum_y=f1(extremum_x);
if sol==true
    disp(['S(x,f1(x)) = (',int2str(extremum_x),'/',int2str(extremum_y),')'])
end
%apply Newton_opt on f2
%i=1;
funct=@f2;
x_s2=20;
[extremum_x2,sol]=Newton_opt(funct,x_s2,epsilon,delta,maxiterations);
extremum_y2=f2(extremum_x2);
if sol==true
    disp(['S(x,f2(x)) = (',int2str(extremum_x2),'/',int2str(extremum_y2),')'])
end