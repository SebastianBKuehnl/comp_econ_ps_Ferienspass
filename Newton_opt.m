function [root,sol]=Newton_opt(fun,x_start,eps,delta,maxiter)
i=0;
x=zeros(25,1);
x(1)=x_start;
%to get in while
absdiff=1;
check=0;
%check input parameters
if (eps<=0) || (delta<=0) || (maxiter<=0)
    disp('invalid input parameters')
    return;
end
%function at x_start already in optimum?
syms a
f=fun(a);
grad=eval(subs(diff(f,a,1),a,x(1)));
if (grad==0)
    root=x(1);
    return;
end    
while (i<maxiter) && (absdiff>check)
  i=i+1;
  grad=eval(subs(diff(f,a,1),a,x(i)));
  he=eval(subs(diff(f,a,2),a,x(i)));
  x(i+1)=x(i)-he*grad;
  absdiff=abs(x(i)-x(i+1));
  check=eps*(1+abs(x(i+1)));
end
crit=delta*(1+abs(fun(x(i+1))));
val=abs(eval(subs(diff(f,a,1),a,x(i+1))));
if (i<maxiter) && (val<=crit)
    disp('success');
    sol=true;
    root=x(i+1);
else
    disp('failure');
    sol=false;
    root=-Inf;
end 
disp(['number iterations: ',int2str(i)])
end