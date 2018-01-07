function [ r ] = mybisection( fun, a, b, maxiter, eps_step, eps_abs )
  % Finding a root using the bisection algorithm
  % fun   := function
  % a, b  := two points in the domain
  % maxiter := maximum number of iterations before the algorithm breaks
  
  
  % Check requirements: 
  if (maxiter<=0) || (eps_step<0) || (eps_abs<0)
    error('input parameters invalid');
  %% fun at a or b already zero? 
  if ( fun(a) == 0 )
    r = a;
    return;
  elseif ( fun(b) == 0 )
    r = b;
    return;
  %% [a,b] does contain a root?
  elseif ( fun(a) * fun(b) > 0 )
    error( 'f(a) and f(b) do not have opposite signs' );
  end
  
  % Iteration
  for i = 1:maxiter
    c = (a + b)/2; % midpoint
    % Is c already a root?
    
    % Determine the interval to be considered
    if ( fun(c) == 0 )
      r = c;
      return;
    elseif ( fun(c)*fun(a) < 0 ) 
      % proceed with [a, c] if f(a) and f(c) have opposite signs
      b = c; 
    else
      % proceed with [c, b] because f(b) and f(c) then have opposite signs
      a = c;
    end
    
    if ( b-a < eps_step )
      if ( abs( fun(a) ) < abs( fun(b) ) && abs( fun(a) ) < eps_abs )
        r = a;
        return;
      elseif ( abs( fun(b) ) < eps_abs )
        r = b;
        return;
      end
    end
  end
  
  error( 'No root could be found: the bisection did not converge' );
end   
