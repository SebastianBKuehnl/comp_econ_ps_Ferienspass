function [yspllin,ysplcub]=spl(fct,x,m,xmin,xmax)
% In Miranda-Fackler, in fundefn, n is the degree of approximation, which 
% is the number of nodes (m) -1

  fspacespllin=fundefn('spli',m-1,xmin,xmax,1);  %linear splines
  fspacesplcub=fundefn('spli',m-1,xmin,xmax,3);  %cubic splines  
  distance=(xmax-xmin)/(m-1);
  nodesspl=zeros(m,1);
  ynodes=zeros(m,1);
  %nodes
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