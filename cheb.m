function [yequi,ychebsli,ycheblec]=cheb(fct,x,m,xmin,xmax)

%define function space with fundefn
fspace=fundefn('cheb',m-1,xmin,xmax);
distance=(xmax-xmin)/(m-1);
nodesequi=zeros(m,1);
ynodesequi=zeros(m,1);
nodeschebslides=zeros(m,1);
ynodeschebsli=zeros(m,1);
ynodescheblec=zeros(m,1);
nodescheblecture=zeros(m,1);
%create nodes
%also, calculate function values at x
for j=1:m
  nodesequi(j)=xmin+(j-1)*distance;            %equidistant nodes
  ynodesequi(j)=fct(nodesequi(j));             %function values
  nodeschebslides(j)=-cos((2*j-1)*pi/(2*m));    %Chebyshev nodes according to slide set 7
  nodescheblecture(j)=-cos((2*j-1)*pi/(m));    %Chebyshev nodes according to lecture notes
  ynodeschebsli(j)=fct(nodeschebslides(j));
  ynodescheblec(j)=fct(nodescheblecture(j));  
end

%calculate the matrix of basis functions
Bequi=funbas(fspace,nodesequi);  %equidistant
Bchebsli=funbas(fspace,nodeschebslides);  %Chebyshev
Bcheblec=funbas(fspace,nodescheblecture);  %Chebyshev


%get polynomial coefficients
cequi=Bequi\ynodesequi;  %equidistant
cchebsli=Bchebsli\ynodeschebsli;  %chebychev
ccheblec=Bcheblec\ynodescheblec;

%approximate the function
yequi=funeval(cequi,fspace,x);
ychebsli=funeval(cchebsli,fspace,x);
ycheblec=funeval(ccheblec,fspace,x);

end