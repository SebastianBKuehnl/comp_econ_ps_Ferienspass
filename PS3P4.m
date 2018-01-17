%PS3 Problem 4
%No T is given, so declare it at the beginning of the program, and for any
%theta
T=20;
time=linspace(0,20,21);
theta=0.8;
%variable initialization (fixed)
w=zeros(T+1,1);
w(1)=10;
beta=0.99;
r=0.05;
%these variables will be determined
a=zeros(T+1,1);
c=zeros(T+1,1);
%computation (could also be written as a function)
num=zeros(T+1);
denom=zeros(T+1);
for i=0:T
  num(i+1)=w(i+1)*(1+r)^(-i);  
  denom(i+1)=((1+r)^((1-theta)/theta)*beta^(1/theta))^i;  
end
c(1)=sum(num)/sum(denom);
for i=1:T
  c(i+1)=c(i)*(beta*(1+r))^(i/theta);  
  a(i+1)=a(i)*(1+r)+w(i)-c(i);
end
if a(end)<0
  disc=a(end); 
end

figure
plot(time,c,time,w,time,a);

