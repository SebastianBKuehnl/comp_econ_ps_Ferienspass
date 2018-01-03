%PS2 P1 Bisection 1
function zero=bisecc(x_l,x_h,e,d)
%check if x_l<x_h and if so interchange values
if x_l>x_h;
    dummy=x_h;
    x_h=x_l;
    x_l=dummy;
end
%check if x_l and x_h are on the same side of the zero
if fffunction(x_l)*fffunction(x_h)>0;
    error('values are on the same side')
end
%check parameeter values
if e<=0; or d<=0;
    error('epsilon and delta have to be positive');
end
diff=x_h-x_l;
%stopping criterion at beginning
while diff>e;
%compute midpoint
x_m=(x_l+x_h)/2;
%x_m is new x_h or x_l
if fffunction(x_l)*fffunction(x_m)<0
    x_h=x_m;
else
    x_l=x_m;
end
diff=x_h-x_l;
end
%return the zero value
zero=x_m;


