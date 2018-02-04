function [y]=chebi(fct,x,m,xmin,xmax)

%Chebyshev interpolation m=n
%define function space using fundefn

fspace=fundefn('cheb',m,-1,1);

anodes=NaN(m,1);
nodes=NaN(m,1);

%create nodes and evaluate fct values at nodes
for j=1:m
  nodes(j,1)=-cos((2*j-1)*pi/(2*m)); %Chebyshev nodes
  nodes(j,1)=(nodes(j,1)+1)*(xmax-xmin)/2+xmin; %Rescale nodes
  anodes(j,1)=fct(nodes(j,1)); %Evaluate function at nodes 
end

figure
scatter(nodes,ones(m,1))
title("Distribution of Chebyshev Nodes")

%calculate  matrix of basis functions
B=funbas(fspace,nodes);  

%solve for polynomial coefficients
c=B\anodes;

%approximate function a
y=funeval(c,fspace,x);

end