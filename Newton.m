function [root,sol]=Newton(fun,x_start,eps,delta,maxiter)
i=0;
x=zeros(25,1);
x(1)=x_start;
%build first derivative of fun
syms y c
y=fun(c);
dfun=diff(y,c);
%to get in while
absdiff=1;
check=0;
%check input parameters
if (eps<=0) || (delta<=0) || (maxiter<=0)
    disp('invalid input parameters')
    return;
end
%function at x_start already 0?
if (fun(x(1))==0)
    root=x(1);
    return;
end    
while (i<maxiter) && (absdiff>check)
  i=i+1;
  x(i+1)=x(i)-(subs(dfun,c,x(i)))^(-1)*fun(x(i));
  absdiff=abs(x(i)-x(i+1));
  check=eps*(1+abs(x(i+1)));
end
if (i<maxiter) && (abs(fun(x(i+1)))<=delta)
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