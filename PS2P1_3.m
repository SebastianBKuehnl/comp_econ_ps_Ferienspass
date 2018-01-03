clear;
%PS2 Problem 1 3.
%get an idea how the difference looks like
x=0:10;
plot(x,difference(x));
%Use bisec algorithm
fun=@difference;
p=bisec(0,5,0.0001,fun);
disp(p)
%use fzero with guess 1
z=fzero(fun,1);
disp(z)
%Gauss-Seidel fixed point iteration
%initial values
i=1;
p(i)=0.1;
q(i)=0.1;
qdiff=1; %just >epsilon to get into the loop
%stopping criterion
e=0.0001;
delta=0.001;
maxi=25;
while i-1<maxi && qdiff>e*(1+abs(q(i)))
  i=i+1;
  p(i)=demand(q(i-1));
  q(i)=supply(p(i));
  qdiff=abs(q(i)-q(i-1));
end  
d=abs(supply(q(i))-q(i));
if d<=delta
    disp('success')
end
if d>delta
    disp('failure')
end
disp(i-1);
disp(q(i))
%there is a solution after 7 iterations, but "Failure"
%--> no convergence, reorder system of equations
