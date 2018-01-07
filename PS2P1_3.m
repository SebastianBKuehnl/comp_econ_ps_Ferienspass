clear;
%PS2 Problem 1 3.
%get an idea how the difference looks like
x=0:100;  
plot(x,difference(x));  %only 1 zero in this interval!
%Use bisec algorithm
fun=@difference;
maxiter=20;
a=3;
b=0.5;
psi=0.5;
c=1;
d=c;
x_l=0;
x_h=5;
q=mybisection(fun,x_l,x_h,maxiter,0.0001,0.0001);
disp(q);        %q=1.5279
p=demand(q);
disp(p);        %p=2.2361
%use fzero with guess 1
z=fzero(fun,1);
disp(z);        %q=1.5279
pp=demand(z);
disp(pp);       %p=2.2361
%Gauss-Seidel fixed point iteration
%initial values
i=1;
q(i)=0.1;
p(i)=supply(q(i));
qdiff=1; %just >epsilon to get into the loop
%stopping criterion
e=0.00001;
delta=0.001;
maxiter=25;
%start with q_supply=0.1
while (i-1<maxiter) && (qdiff>e)
  i=i+1;
  q(i)=(p(i-1)-a)/(-b);   
  p(i)=supply(q(i));     
  qdiff=abs(q(i)-q(i-1));
end  
d=abs(supply(q(i))-p(i)); %difference in prices
if ((i-1)==maxiter) || (d>delta) || (isnan(d))
    disp('failure')
else
    disp('success')
end
disp(i-1);          %#iterations = 25
disp(q(i))          %q=1.5405 
disp(p(i))          %p=2.2412
%it displays 'failure' --> convergence not fast enough --> reorder system of equations
p=[];
q=[];
i=1;
p(i)=0.1;
q(i)=((p(i)-c)/d)^(1/psi);
qdiff=1; %just >epsilon to get into the loop
%start with p_supply=0.1
while (i-1<maxiter) && (qdiff>e)
  i=i+1;
  p(i)=demand(q(i-1));               
  q(i)=((p(i)-c)/d)^(1/psi);          
  qdiff=abs(q(i)-q(i-1));
end  
d=abs(supply(q(i))-p(i));  %difference in prices
if ((i-1)==maxiter) || (d>delta) || (isnan(d))
    disp('failure')
else
    disp('success')
end
disp(i-1);          %#iterations = 1
disp(q(i))          %q= +inf
disp(p(i))          %p= -inf
%failure --> fast divergence --> try dampening
%dampening (of first method)
lambda=0.75; 
p=[];
q=[];
i=1;
q(i)=0.1;
qtilde(i)=0;
p(i)=supply(q(i));
qdiff=1; %just >epsilon to get into the loop
%stopping criterion
e=0.0001;
delta=0.0001;
maxiter=25;
%start with q_supply=0.1
while (i-1<maxiter) && (qdiff>e)
  i=i+1;
  qtilde(i)=(p(i-1)-a)/(-b);               %new value without dampening
  q(i)=lambda*qtilde(i)+(1-lambda)*q(i-1); %new value with dampening
  p(i)=supply(q(i));       
  qdiff=abs(q(i)-q(i-1));
end  
d=abs(supply(q(i))-p(i)); %difference in prices
if ((i-1)==maxiter) || (d>delta) || (isnan(d))
    disp('failure')
else
    disp('success')
end
disp(i-1);          %#iterations = 12
disp(q(i))          %q=1.5279 
disp(p(i))          %p=2.2361
%'success', same solutions as mybisection and fzero
%dampening (of second method)
p=[];
q=[];
lambda=1.5; 
i=1;
p(i)=0.1;
ptilde(i)=0;
q(i)=((p(i)-c)/d)^(1/psi);
qdiff=1; %just >epsilon to get into the loop
%start with p_supply=0.1
while (i-1<maxiter) && (qdiff>e)
  i=i+1;
  ptilde(i)=demand(q(i-1));
  p(i)=lambda*ptilde(i)+(1-lambda)*p(i-1);
  q(i)=((p(i)-c)/d)^(1/psi);          
  qdiff=abs(q(i)-q(i-1));
end  
d=abs(supply(q(i))-p(i));  %difference in quantities
if ((i-1)==maxiter) || (d>delta) || (isnan(d))
    disp('failure')
else
    disp('failure')
end
disp(i-1);          %#iterations = 1
disp(q(i))          %q= Inf
disp(p(i))          %p= -Inf
%'failure'   something must be wrong here (reordering, etc...)
