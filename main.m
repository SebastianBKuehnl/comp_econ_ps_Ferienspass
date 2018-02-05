%PS4P3
clear;
close all;
clc;

%variable declaration
n=15;  %number of nodes;
f=@simplefQ4P3;
f_const=@simplefQ4P3const;
%Set up Gamma space
xmin=1;
xmax=50;
b=linspace(xmin,xmax,1000); 
b=b';

for i=1:2
    if i==1

%Unconstrained alpha
approximated_alpha=chebi(f,b,n,xmin,xmax);
real_alpha=simplefQ4P3(b);
difference= abs(approximated_alpha - real_alpha);
alphaspline=spl(f,b,n,xmin,xmax);
difference_spline= abs(alphaspline - real_alpha);
    else
%Constrained alpha
approximated_alpha=chebi(f_const,b,n,xmin,xmax);
real_alpha=simplefQ4P3const(b);
difference= abs(approximated_alpha - real_alpha);
alphaspline=spl(f_const,b,n,xmin,xmax);
difference_spline= abs(alphaspline - real_alpha);
    end
figure
subplot(2,2,1)
plot(b,approximated_alpha,b,real_alpha)
title("Chebyshev Approximated and True Values")
line([min(b),max(b)],[0,0],'Color','red','LineStyle','--')
line([min(b),max(b)],[1,1],'Color','red','LineStyle','--')
legend("Chebyshev Approximation","True Values","\alpha Bound",'location','best')
xlabel("\gamma")
ylabel("Optimal \alpha")

subplot(2,2,2)
plot(b,real_alpha)
title("True Value")
line([min(b),max(b)],[0,0],'Color','red','LineStyle','--')
line([min(b),max(b)],[1,1],'Color','red','LineStyle','--')
legend("True Values","\alpha Bound",'location','best')
xlabel("\gamma")
ylabel("Optimal \alpha")

subplot(2,2,3)
plot(b,approximated_alpha)
line([min(b),max(b)],[0,0],'Color','red','LineStyle','--')
line([min(b),max(b)],[1,1],'Color','red','LineStyle','--')
title("Chebyshev Approximated Values Only")
legend("Chebyshev Approximation","\alpha Bound",'location','best')
xlabel("\gamma")
ylabel("Optimal \alpha")

subplot(2,2,4)
plot(b,difference)
title("Difference in Absolute Terms (Chebyshev)")
xlabel("\gamma")
ylabel("Optimal \alpha")

figure
subplot(2,2,1)
plot(b,alphaspline,b,real_alpha)
title("Spline Approximated and True Values")
line([min(b),max(b)],[0,0],'Color','red','LineStyle','--')
line([min(b),max(b)],[1,1],'Color','red','LineStyle','--')
legend("Spline Approximation","True Values","\alpha Bound",'location','best')
xlabel("\gamma")
ylabel("Optimal \alpha")

subplot(2,2,2)
plot(b,real_alpha)
title("True Value")
line([min(b),max(b)],[0,0],'Color','red','LineStyle','--')
line([min(b),max(b)],[1,1],'Color','red','LineStyle','--')
legend("True Values","\alpha Bound",'location','best')
xlabel("\gamma")
ylabel("Optimal \alpha")

subplot(2,2,3)
plot(b,alphaspline)
line([min(b),max(b)],[0,0],'Color','red','LineStyle','--')
line([min(b),max(b)],[1,1],'Color','red','LineStyle','--')
title("Spline Approximated Values Only")
legend("Spline Approximation","\alpha Bound",'location','best')
xlabel("\gamma")
ylabel("Optimal \alpha")

subplot(2,2,4)
plot(b,difference_spline)
title("Difference in Absolute Terms (Spline)")
xlabel("\gamma")
ylabel("Optimal \alpha")

end

% Adjust grid for Spline Interploation:
[V, I]=max(difference_spline);
alphaspline_adapt=spladapt(f_const,b,n,xmin,xmax,I,b);
difference_spline_adapt= abs(alphaspline_adapt - real_alpha);

figure
subplot(2,1,1)
plot(b,alphaspline_adapt,b,real_alpha)
title("Spline Approximated with adjusted grid and True Values")
line([min(b),max(b)],[0,0],'Color','red','LineStyle','--')
line([min(b),max(b)],[1,1],'Color','red','LineStyle','--')
legend("Spline Approximation","True Values","\alpha Bound",'location','best')
xlabel("\gamma")
ylabel("Optimal \alpha")
subplot(2,1,2)
plot(b,difference_spline_adapt)
title("Difference in Absolute Terms (Spline)")
xlabel("\gamma")
ylabel("Optimal \alpha")

function [yspllin,ysplcub]=spladapt(fct,x,m,xmin,xmax,I,b)
% In Miranda-Fackler, in fundefn, n is the degree of approximation, which 
% is the number of nodes (m) -1

  fspacespllin=fundefn('spli',m-1,xmin,xmax,1);  %linear splines
  fspacesplcub=fundefn('spli',m-1,xmin,xmax,3);  %cubic splines  
  %distance=(xmax-xmin)/(m-1);
  nodesspl=zeros(m,1);
  ynodes=zeros(m,1);
  %nodes
  distance_nodes=round((xmin-b(I(1,1),1))/(xmax-xmin)*(m-1),0);
  distance=(xmin-b(I(1,1),1))/distance_nodes;
  
  for i=1:m
    nodesspl(i)=xmin+(i-1)*distance;   %eqidistant nodes
    ynodes(i)=fct(nodesspl(i));        %fct values at nodes
  end
  
  %calculate the matrix of basis functions
  Bspllin=funbas(fspacespllin,nodesspl);  
  Bsplcub=funbas(fspacesplcub,nodesspl);
  
  %get polynomial coefficients
  cspllin=Bspllin\ynodes;  
  csplcub=Bsplcub\ynodes;
  
  %approximate the function
  yspllin=funeval(cspllin,fspacespllin,x);
  ysplcub=funeval(csplcub,fspacesplcub,x);

end
