%backup monte carlo
function [integral_dx] = integral_dx( f,a,b )
%integrate function (f) using monte carlo method

x2=linspace(a,b,1000);
syms z % zero vector holder to find max y value
z = zeros(size(x2));

z = f(x2);

y = f(b).*rand(1,1000);

x = rand(1,1000);

h=0; % counters
n= 0;
%if you want to see visual representation just un-commnet plot lines

plot(x2,z); hold on;
plot(x,y,'x')
count = 0;
for k=1:numel(x);

      if y(k) <= exp(x(k))+1;
          count= count +1;
      end

end

count
integral_dx = count/numel(x) * max(z) * (b-a);
end