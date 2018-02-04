%PS4P1
clear;
close all;
clc;

%Chebychev

%variable declaration
n=15;  %number of nodes;
%f(x) is simplef.m
f=@simplefct;
xmin=1;
xmax=50;
b=linspace(xmin,xmax,1000); %x-space
x=2;
b=b';

    [a]=cheb(f,b,n,xmin,xmax);
  




%SPLINES equidistant nodes
[alphaspline]=spl(f,b,n,xmin,xmax);

%real function
realalpha=simplef(b);

figure
plot(b,a-realalpha,b,alphaspline-realalpha,'--r')
legend('chebyshev','splines')
title('residuals')


