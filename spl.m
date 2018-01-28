function yapspl=spl(fct,x,m,a,b)
  c=max(m-1,2);
  fspacespl=fundefn('spli',c,-1,1,m);
  distance=(b-a)/(m-1);
  xspl=zeros(m,1);
  yspl=zeros(m,1);
  for i=1:m
    xspl(i)=a+(i-1)*distance; 
    yspl(i)=fct(xspl(i));    
  end

  %calculate the matrix of basis functions
  Bspl=funbas(fspacespl,xspl);  

  %get polynomial coefficients
  cspl=Bspl\yspl;  

  %approximate the function
  yapspl=funeval(cspl,fspacespl,x);
end