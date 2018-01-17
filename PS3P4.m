%PS3 Problem 4
%No T is given, so declare it at the beginning of the program, and for any
%theta
clear;
close all;
clc;
T=20;
theta=1;
%variable initialization (fixed)
time=linspace(0,T,T+1); %just for plot
w=zeros(T+1,1);
w(1)=10;
beta=0.99;
r=0.05;
%these variables will be determined
a=zeros(T+1,1);
c=zeros(T+1,1);
%computation (could also be written as a function)
num=zeros(T+1,1);
denom=zeros(T+1,1);
if theta==1
    factor=beta*(1+r);
else
    factor=(1+r)^((1-theta)/theta)*beta^(1/theta);
end
for i=0:T
  num(i+1)=w(i+1)*(1+r)^(-i);  
  denom(i+1)=(factor)^i;  
end
c(1)=sum(num)/sum(denom);
for i=1:T
  a(i+1)=a(i)*(1+r)+w(i)-c(i);
  c(i+1)=c(i)*(beta*(1+r))^(1/theta); 
  if c(i+1)<=0
      c(i+1)=0;
      display(['c<=0 in period ',int2str(i+1)])
  end
end
figure
plot(time,c,time,w,time,a);
legend('C','W','A')
acheck=a(end);
ccheck=c(end);
if (round(ccheck*1000)/1000==round(acheck*(1+r)*1000)/1000)
    display('True --> a_{T+1}= 0')
elseif (round(ccheck*1000)/1000>round(acheck*(1+r)*1000)/1000)
  display('a_{T+1}<0')
  disc=a(end);
  subst=zeros(T+1,1);
  for i=0:T
    subst(i+1)=(1+r)^i*((beta*(1+r))^(i/theta))^T-i;  
  end
  d=sum(subst);
  c(1)=c(1)-d;
  for i=1:T
    c(i+1)=c(i)*(beta*(1+r))^(i/theta);  
    a(i+1)=a(i)*(1+r)+w(i)-c(i);
  end
else
    display('error, a_{T+1}>0')
end

